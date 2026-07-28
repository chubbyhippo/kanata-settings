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

required_version="1.11.0"
install_hint="No Debian-family archive carries a usable kanata: Debian's is
  1.9.0 (sid/forky only, older than the $required_version this config needs),
  and Ubuntu publishes none at all — nor do Mint, Pop!_OS and the rest
  downstream of it. Install a current one directly:
      cargo install kanata
  or drop a release binary from https://github.com/jtroo/kanata/releases
  into ~/.local/bin and chmod +x it."

main() {
    base="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/debian"
    config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/kanata"
    config_path="$config_dir/kanata.kbd"
    initd_script="/etc/init.d/kanata"
    udev_rule="/etc/udev/rules.d/99-input.rules"
    user="$(id -un)"

    [ "$(id -u)" -ne 0 ] || {
        echo "run as your normal user, not root — this script sudos only the steps that need it," >&2
        echo "and it needs your username and \$HOME to point the service at your config" >&2
        exit 1
    }

    command -v rc-update >/dev/null 2>&1 && command -v rc-service >/dev/null 2>&1 || {
        echo "OpenRC not found (no rc-update / rc-service)." >&2
        echo "  On a systemd host use install.sh instead." >&2
        exit 1
    }

    openrc_run="$(command -v openrc-run || echo /sbin/openrc-run)"
    [ -x "$openrc_run" ] || {
        echo "openrc-run not found — expected /sbin/openrc-run or on PATH" >&2
        exit 1
    }

    kanata_bin="$(command -v kanata || true)"
    [ -n "$kanata_bin" ] || {
        echo "kanata not found on PATH." >&2
        echo "  $install_hint" >&2
        exit 1
    }

    version="$(kanata_version "$kanata_bin")"
    version_at_least "$version" "$required_version" || {
        echo "kanata $version at $kanata_bin is too old — this config needs $required_version+." >&2
        echo "  $install_hint" >&2
        exit 1
    }
    echo "using kanata $version at $kanata_bin, openrc-run at $openrc_run"

    getent group uinput >/dev/null 2>&1 || sudo groupadd --system uinput
    sudo usermod -aG input,uinput "$user"
    sudo modprobe uinput

    tmp_rule="$(mktemp)"
    curl -fsSL "$base/99-input.rules" -o "$tmp_rule"
    sudo install -m 644 -o root -g root "$tmp_rule" "$udev_rule"
    rm -f "$tmp_rule"
    if command -v udevadm >/dev/null 2>&1; then
        sudo udevadm control --reload-rules
        sudo udevadm trigger
        echo "installed $udev_rule"
    else
        echo "installed $udev_rule (no udevadm — reboot, or ensure /dev/uinput is 0660 root:uinput)"
    fi

    mkdir -p "$config_dir"
    tmp_kbd="$(mktemp)"
    curl -fsSL "$base/kanata.kbd" -o "$tmp_kbd"
    "$kanata_bin" --cfg "$tmp_kbd" --check
    install -m 644 "$tmp_kbd" "$config_path"
    rm -f "$tmp_kbd"
    echo "installed $config_path"

    tmp_init="$(mktemp)"
    curl -fsSL "$base/kanata.openrc" -o "$tmp_init"
    sed -e "1s|^#!/sbin/openrc-run$|#!$openrc_run|" \
        -e "s|^command=\"/usr/bin/kanata\"$|command=\"$kanata_bin\"|" \
        -e "s|^command_args=\".*\"$|command_args=\"--cfg $config_path --no-wait\"|" \
        -e "s|^command_user=\"user\"$|command_user=\"$user\"|" \
        "$tmp_init" > "$tmp_init.subst"
    verify_substituted "$tmp_init.subst"
    sudo install -m 755 -o root -g root "$tmp_init.subst" "$initd_script"
    rm -f "$tmp_init" "$tmp_init.subst"
    echo "installed $initd_script"

    sudo rc-update add kanata default
    if id -nG | tr ' ' '\n' | grep -qx uinput; then
        sudo rc-service kanata restart
        sudo rc-service kanata status
        echo "done — test: hold the right thumb (RAlt) + e -> up arrow (NAV)"
        echo "logs: tail -f /var/log/kanata.log"
    else
        echo ""
        echo "the uinput group is not active for $user yet — the service will pick it up"
        echo "after a fresh login. Log out and back in, then:  sudo rc-service kanata start"
    fi
}

verify_substituted() {
    ! grep -qE '^command="/usr/bin/kanata"$|/home/user/\.config|^command_user="user"$' "$1" || {
        echo "placeholder substitution failed — refusing to install a broken init script" >&2
        exit 1
    }
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

${__SOURCED__:+return}

main "$@"
