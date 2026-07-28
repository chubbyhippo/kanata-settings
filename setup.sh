#!/bin/sh
# Copyright (C) 2026 Chubby Hippo
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -eu

REPO_RAW="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main"
REQUIRED_VERSION="1.11.0"
MARKER="wins/kanata.kbd"

usage() {
    cat <<'EOF'
kanata-settings setup — detects your platform and installs the matching config.

Usage: setup.sh [options]

Options:
  --detect-only        Print what was detected, then exit. Changes nothing.
  --dry-run            Print every action instead of performing it.
  --platform VALUE     Override: linux | wsl | windows | darwin
  --family VALUE       Override: debian | fedora | arch | guix
  --init VALUE         Override: systemd | openrc
  --desktop VALUE      Override: gnome | kde | cinnamon | other
  -h, --help           This text.

Platforms: macOS delegates to mac/install.sh. WSL and MSYS/Cygwin install the
Windows config. Guix prints its declarative service snippet. Every other Linux
gets the group/udev setup plus a systemd user unit or an OpenRC service.
EOF
}

main() {
    detect_only=no
    dry_run=no
    platform_override=""
    family_override=""
    init_override=""
    desktop_override=""

    parse_args "$@"
    locate_source
    detect

    report
    [ "$detect_only" = no ] || exit 0

    case "$platform" in
        darwin)         run_darwin ;;
        windows|wsl)    run_windows ;;
        linux)
            case "$family" in
                guix) run_guix ;;
                *)    run_linux ;;
            esac
            ;;
        *) die "unsupported platform: $platform" ;;
    esac
}

parse_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            --detect-only) detect_only=yes ;;
            --dry-run)     dry_run=yes ;;
            --platform)    shift; platform_override="${1:-}" ;;
            --family)      shift; family_override="${1:-}" ;;
            --init)        shift; init_override="${1:-}" ;;
            --desktop)     shift; desktop_override="${1:-}" ;;
            -h|--help)     usage; exit 0 ;;
            *)             usage >&2; die "unknown option: $1" ;;
        esac
        shift
    done
}

locate_source() {
    local_dir=""
    case "$0" in
        */*) candidate="${0%/*}" ;;
        *)   candidate="." ;;
    esac
    candidate="$(cd "$candidate" 2>/dev/null && pwd || printf '')"
    [ -n "$candidate" ] && [ -r "$candidate/$MARKER" ] && local_dir="$candidate" || true
}

detect() {
    if [ -n "$platform_override" ]; then platform="$platform_override"; else detect_platform; fi
    family=n/a; init=n/a; desktop=n/a; desktop_raw=""
    [ "$platform" = linux ] || return 0
    distro_name="$(os_release_field PRETTY_NAME)"
    if [ -n "$family_override" ];  then family="$family_override";   else detect_family;  fi
    if [ -n "$init_override" ];    then init="$init_override";       else detect_init;    fi
    if [ -n "$desktop_override" ]; then desktop="$desktop_override"; else detect_desktop; fi
}

detect_platform() {
    case "$(uname -s)" in
        Darwin)                     platform=darwin ;;
        MINGW*|MSYS*|CYGWIN*)       platform=windows ;;
        Linux)
            if is_wsl; then platform=wsl; else platform=linux; fi
            ;;
        *) platform=unknown ;;
    esac
}

is_wsl() {
    [ -n "${WSL_DISTRO_NAME:-}" ] && return 0
    [ -r /proc/sys/kernel/osrelease ] || return 1
    tr '[:upper:]' '[:lower:]' < /proc/sys/kernel/osrelease | grep -q 'microsoft\|wsl'
}

os_release_field() {
    [ -r /etc/os-release ] || return 0
    ( . /etc/os-release 2>/dev/null || true
      case "$1" in
          ID)          printf '%s' "${ID:-}" ;;
          ID_LIKE)     printf '%s' "${ID_LIKE:-}" ;;
          PRETTY_NAME) printf '%s' "${PRETTY_NAME:-}" ;;
      esac )
}

detect_family() {
    haystack=" $(os_release_field ID) $(os_release_field ID_LIKE) "
    case "$haystack" in
        *" guix "*)                                     family=guix ;;
        *" arch "*|*" manjaro "*|*" artix "*|*" endeavouros "*|*" garuda "*|*" cachyos "*)
                                                        family=arch ;;
        *" fedora "*|*" rhel "*|*" centos "*)           family=fedora ;;
        *" debian "*|*" ubuntu "*)                      family=debian ;;
        *)                                              family=unknown ;;
    esac
}

detect_init() {
    if [ -d /run/systemd/system ]; then
        init=systemd
    elif [ -f /run/openrc/softlevel ]; then
        init=openrc
    elif command -v openrc-run >/dev/null 2>&1 && command -v rc-update >/dev/null 2>&1; then
        init=openrc
    elif command -v systemctl >/dev/null 2>&1; then
        init=systemd
    else
        init=none
    fi
}

detect_desktop() {
    desktop_raw="${XDG_CURRENT_DESKTOP:-}"
    [ -n "$desktop_raw" ] || desktop_raw="${XDG_SESSION_DESKTOP:-}"
    [ -n "$desktop_raw" ] || desktop_raw="${DESKTOP_SESSION:-}"
    case "$(printf '%s' "$desktop_raw" | tr '[:upper:]' '[:lower:]')" in
        *kde*|*plasma*)  desktop=kde ;;
        *cinnamon*)      desktop=cinnamon ;;
        *gnome*|*unity*) desktop=gnome ;;
        "")              desktop=unknown ;;
        *)               desktop=other ;;
    esac
}

report() {
    echo "detected:"
    printf '  platform : %s\n' "$platform"
    if [ "$platform" = linux ]; then
        printf '  distro   : %s (family %s)\n' "${distro_name:-unknown}" "$family"
        printf '  init     : %s\n' "$init"
        printf '  desktop  : %s%s\n' "$desktop" \
            "$([ -n "$desktop_raw" ] && printf ' (XDG_CURRENT_DESKTOP=%s)' "$desktop_raw" || printf '')"
    fi
    printf '  source   : %s\n' "${local_dir:-$REPO_RAW}"
    [ "$dry_run" = no ] || echo "  mode     : dry run, nothing will be changed"
}

run() {
    if [ "$dry_run" = yes ]; then
        printf '  [dry-run] %s\n' "$*"
    else
        "$@"
    fi
}

did() {
    if [ "$dry_run" = yes ]; then echo "would install $1"; else echo "installed $1"; fi
}

die() { echo "error: $*" >&2; exit 1; }
warn() { echo "warning: $*" >&2; }

fetch() {
    if [ -n "$local_dir" ] && [ -r "$local_dir/$1" ]; then
        cp "$local_dir/$1" "$2"
    else
        curl -fsSL "$REPO_RAW/$1" -o "$2"
    fi
}

kanata_version() {
    "$1" --version 2>&1 \
        | tr ' ' '\n' \
        | sed -n 's/^v\{0,1\}\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*/\1/p' \
        | head -n 1
}

version_at_least() {
    [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n 1)" = "$2" ]
}

install_hint() {
    case "$family" in
        debian) echo "Debian ships kanata 1.9.0 (sid/forky only) and Ubuntu/Mint ship none." ;;
        fedora) echo "Fedora has no official kanata package." ;;
        arch)   echo "kanata is in the AUR: paru -S kanata-bin. On Manjaro, AUR support is off by default in pamac." ;;
        *)      echo "Your distro may not package kanata." ;;
    esac
    echo "  Install one directly:  cargo install kanata"
    echo "  or drop a release binary from https://github.com/jtroo/kanata/releases into ~/.local/bin"
}

require_kanata() {
    kanata_bin="$(command -v kanata || true)"
    [ -n "$kanata_bin" ] || { echo "kanata not found on PATH." >&2; install_hint >&2; exit 1; }
    version="$(kanata_version "$kanata_bin")"
    version_at_least "$version" "$REQUIRED_VERSION" \
        || { echo "kanata $version at $kanata_bin is too old — need $REQUIRED_VERSION+." >&2; install_hint >&2; exit 1; }
    echo "using kanata $version at $kanata_bin"
}

patch_desktop() {
    case "$desktop" in
        gnome)
            ;;
        kde)
            echo "applying KDE Plasma keybindings"
            sed -i -e 's|^  overview lmet$|  overview M-w|' \
                   -e 's|^  minimize M-h$|  minimize M-pgdn|' \
                   -e 's|^  emoji C-\.$|  emoji M-.|' \
                   -e 's|^  langtoggle M-spc$|  langtoggle M-A-k|' "$1"
            ;;
        cinnamon)
            warn "Cinnamon has no upstream default for 'overview' or 'minimize'."
            warn "  Bind Expo/Scale and Minimize in Keyboard settings, then edit those two aliases."
            ;;
        *)
            warn "desktop '${desktop_raw:-unknown}' not recognised — leaving the GNOME aliases in place."
            warn "  Review overview / minimize / emoji / langtoggle against your desktop's defaults."
            ;;
    esac
}

config_folder() {
    case "$family" in
        debian|fedora|arch) printf '%s' "$family" ;;
        *)                  printf 'debian' ;;
    esac
}

run_linux() {
    [ "$(id -u)" -ne 0 ] || die "run as your normal user, not root — the script sudos where it needs to"
    [ "$family" != unknown ] || warn "unrecognised distro — using the debian folder's files, which are identical anyway"
    [ "$init" != none ] && [ "$init" != n/a ] \
        || die "no systemd or OpenRC found. Do the steps in kanata's docs/setup-linux.md by hand."

    require_kanata
    setup_permissions
    install_linux_config
    case "$init" in
        systemd) install_systemd ;;
        openrc)  install_openrc ;;
        *)       die "unsupported init: $init" ;;
    esac
}

setup_permissions() {
    getent group uinput >/dev/null 2>&1 || run sudo groupadd --system uinput
    run sudo usermod -aG input,uinput "$(id -un)"
    run sudo modprobe uinput

    tmp_rule="$(mktemp)"
    fetch "$(config_folder)/99-input.rules" "$tmp_rule"
    run sudo install -m 644 -o root -g root "$tmp_rule" /etc/udev/rules.d/99-input.rules
    rm -f "$tmp_rule"
    if command -v udevadm >/dev/null 2>&1; then
        run sudo udevadm control --reload-rules
        run sudo udevadm trigger
    else
        warn "no udevadm — reboot, or make sure /dev/uinput is 0660 root:uinput"
    fi
    did /etc/udev/rules.d/99-input.rules
}

install_linux_config() {
    config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/kanata"
    config_path="$config_dir/kanata.kbd"
    tmp_kbd="$(mktemp)"
    fetch "$(config_folder)/kanata.kbd" "$tmp_kbd"
    patch_desktop "$tmp_kbd"
    "$kanata_bin" --cfg "$tmp_kbd" --check
    run mkdir -p "$config_dir"
    run install -m 644 "$tmp_kbd" "$config_path"
    rm -f "$tmp_kbd"
    did "$config_path"
}

install_systemd() {
    unit_dir="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
    tmp_unit="$(mktemp)"
    fetch "$(config_folder)/kanata.service" "$tmp_unit"
    sed "s|^ExecStart=/usr/bin/kanata |ExecStart=$kanata_bin |" "$tmp_unit" > "$tmp_unit.out"
    grep -q "^ExecStart=$kanata_bin " "$tmp_unit.out" \
        || die "could not substitute the kanata path into the unit — refusing to install it"
    run mkdir -p "$unit_dir"
    run install -m 644 "$tmp_unit.out" "$unit_dir/kanata.service"
    rm -f "$tmp_unit" "$tmp_unit.out"
    run systemctl --user daemon-reload
    run systemctl --user enable kanata.service
    did "$unit_dir/kanata.service"
    finish_linux "systemctl --user start kanata.service" "journalctl --user -u kanata -f"
}

install_openrc() {
    tmp_init="$(mktemp)"
    fetch "debian/kanata.openrc" "$tmp_init"
    openrc_run="$(command -v openrc-run || echo /sbin/openrc-run)"
    sed -e "1s|^#!/sbin/openrc-run$|#!$openrc_run|" \
        -e "s|^command=\"/usr/bin/kanata\"$|command=\"$kanata_bin\"|" \
        -e "s|^command_args=\".*\"$|command_args=\"--cfg $config_path --no-wait\"|" \
        -e "s|^command_user=\"user\"$|command_user=\"$(id -un)\"|" \
        "$tmp_init" > "$tmp_init.out"
    ! grep -qE '^command="/usr/bin/kanata"$|/home/user/\.config|^command_user="user"$' "$tmp_init.out" \
        || die "placeholder substitution failed — refusing to install a broken init script"
    run sudo install -m 755 -o root -g root "$tmp_init.out" /etc/init.d/kanata
    rm -f "$tmp_init" "$tmp_init.out"
    run sudo rc-update add kanata default
    did /etc/init.d/kanata
    finish_linux "sudo rc-service kanata start" "tail -f /var/log/kanata.log"
}

finish_linux() {
    if id -nG | tr ' ' '\n' | grep -qx uinput; then
        run $1
        echo "done — test: hold the right thumb (RAlt) + e -> up arrow (NAV)"
    else
        echo ""
        echo "the uinput group is not active in this login session yet."
        echo "log out and back in, then:  $1"
    fi
    echo "logs: $2"
}

run_guix() {
    cat <<EOF

Guix is declarative — there is nothing to install imperatively.
(gnu services desktop) already exports kanata-service-type, which creates the
daemon user, the groups, the udev rule and the Shepherd service.

Add to your operating-system:

    (use-modules (gnu services desktop)
                 (guix gexp))

    (services
     (cons* (service kanata-service-type
                     (kanata-configuration
                      (keymaps (list (local-file "${local_dir:-/path/to/kanata-settings}/guix/kanata.kbd")))))
            %desktop-services))

Then:  sudo guix system reconfigure /etc/config.scm

Full notes: guix/README.md
EOF
}

run_darwin() {
    if [ -n "$local_dir" ] && [ -r "$local_dir/mac/install.sh" ]; then
        echo "delegating to mac/install.sh (needs root)"
        run sudo sh "$local_dir/mac/install.sh"
    else
        cat <<EOF

macOS installs through its own script, which must run as root:

    curl -fsSL $REPO_RAW/mac/install.sh | sudo sh

Full notes: mac/README.md
EOF
    fi
}

windows_home() {
    if [ "$platform" = wsl ]; then
        raw="$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r\n')"
        [ -n "$raw" ] || die "could not read %USERPROFILE% from cmd.exe"
        wslpath -u "$raw"
    elif command -v cygpath >/dev/null 2>&1 && [ -n "${USERPROFILE:-}" ]; then
        cygpath -u "$USERPROFILE"
    else
        printf '%s' "${USERPROFILE:-$HOME}"
    fi
}

windows_kanata() {
    command -v kanata.exe 2>/dev/null && return 0
    [ "$platform" = wsl ] || return 1
    raw="$(cmd.exe /c 'where kanata.exe' 2>/dev/null | head -n 1 | tr -d '\r\n')"
    [ -n "$raw" ] || return 1
    wslpath -u "$raw"
}

run_windows() {
    home_dir="$(windows_home)"
    startup="$home_dir/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
    [ -d "$home_dir" ] || die "Windows home not found at $home_dir"
    echo "windows home: $home_dir"

    tmp_kbd="$(mktemp)"
    fetch "wins/kanata.kbd" "$tmp_kbd"

    exe="$(windows_kanata || true)"
    if [ -n "$exe" ]; then
        version="$(kanata_version "$exe")"
        version_at_least "$version" "$REQUIRED_VERSION" \
            || die "kanata $version at $exe is too old — need $REQUIRED_VERSION+"
        echo "using kanata $version at $exe"
        "$exe" --cfg "$(to_native "$tmp_kbd")" --check
    else
        warn "kanata.exe not found — skipping --check. Install it from"
        warn "  https://github.com/jtroo/kanata/releases and put it on your PATH."
    fi

    run install -m 644 "$tmp_kbd" "$home_dir/kanata.kbd"
    rm -f "$tmp_kbd"
    did "$home_dir/kanata.kbd"

    tmp_bat="$(mktemp)"
    fetch "wins/katana.bat" "$tmp_bat"
    sed -e 's/\r$//' -e 's/$/\r/' "$tmp_bat" > "$tmp_bat.crlf"
    run mkdir -p "$startup"
    run install -m 644 "$tmp_bat.crlf" "$startup/kanata.bat"
    rm -f "$tmp_bat" "$tmp_bat.crlf"
    did "$startup/kanata.bat"

    echo ""
    echo "done — run that kanata.bat once (or log off and on) to start kanata."
    echo "test: hold the inner-left thumb (LAlt) + c -> Ctrl+C"
}

to_native() {
    if [ "$platform" = wsl ]; then
        wslpath -w "$1"
    elif command -v cygpath >/dev/null 2>&1; then
        cygpath -w "$1"
    else
        printf '%s' "$1"
    fi
}

${__SOURCED__:+return}

main "$@"
