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
install_hint="kanata is in the AUR, not the official repos. Install one of:
      paru -S kanata-bin      # prebuilt release binary
      paru -S kanata          # built from source
  or run: cargo install kanata"

main() {
    base="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/arch"
    config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/kanata"
    unit_dir="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
    udev_rule="/etc/udev/rules.d/99-input.rules"
    user="$(id -un)"

    [ "$(id -u)" -ne 0 ] || {
        echo "run as your normal user, not root — this script sudos only the steps that need it" >&2
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
    echo "using kanata $version at $kanata_bin"

    getent group uinput >/dev/null 2>&1 || sudo groupadd --system uinput
    sudo usermod -aG input,uinput "$user"
    sudo modprobe uinput

    tmp_rule="$(mktemp)"
    curl -fsSL "$base/99-input.rules" -o "$tmp_rule"
    sudo install -m 644 -o root -g root "$tmp_rule" "$udev_rule"
    rm -f "$tmp_rule"
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    echo "installed $udev_rule"

    mkdir -p "$config_dir"
    tmp_kbd="$(mktemp)"
    curl -fsSL "$base/kanata.kbd" -o "$tmp_kbd"
    "$kanata_bin" --cfg "$tmp_kbd" --check
    install -m 644 "$tmp_kbd" "$config_dir/kanata.kbd"
    rm -f "$tmp_kbd"
    echo "installed $config_dir/kanata.kbd"

    mkdir -p "$unit_dir"
    tmp_unit="$(mktemp)"
    curl -fsSL "$base/kanata.service" -o "$tmp_unit"
    sed "s|^ExecStart=/usr/bin/kanata |ExecStart=$kanata_bin |" "$tmp_unit" > "$unit_dir/kanata.service"
    rm -f "$tmp_unit"
    systemctl --user daemon-reload
    systemctl --user enable kanata.service
    echo "installed $unit_dir/kanata.service"

    if id -nG | tr ' ' '\n' | grep -qx uinput; then
        systemctl --user restart kanata.service
        echo "done — test: hold the right thumb (RAlt) + e -> up arrow (NAV)"
        echo "logs: journalctl --user -u kanata -f"
    else
        echo ""
        echo "the uinput group is not active in this login session yet."
        echo "log out and back in, then:  systemctl --user start kanata.service"
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

main "$@"
