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

main() {
    base="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac"
    daemons="/Library/LaunchDaemons"
    kanata_plist="dev.kanata.kanata.plist"
    vhid_plist="org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"
    driver_ver="6.2.0"
    driver_sha="9e8c46239f0748161241e42444857901224e5c82f5b58a1731df4c70bf0736a8"
    manager="/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"

    [ "$(id -u)" -eq 0 ] || {
        echo "must run as root:  curl -fsSL $base/install.sh | sudo sh" >&2
        exit 1
    }

    if systemextensionsctl list 2>/dev/null | grep "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice" | grep -q "activated enabled"; then
        echo "Karabiner driver already activated"
    else
        if [ ! -x "$manager" ]; then
            pkg="/tmp/Karabiner-DriverKit-VirtualHIDDevice-$driver_ver.pkg"
            curl -fsSL "https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v$driver_ver/Karabiner-DriverKit-VirtualHIDDevice-$driver_ver.pkg" -o "$pkg"
            echo "$driver_sha  $pkg" | shasum -a 256 -c - >/dev/null
            installer -pkg "$pkg" -target /
            rm -f "$pkg"
        fi
        "$manager" forceActivate
        echo ""
        echo "driver installed — one manual step Apple requires:"
        echo "  System Settings -> General -> Login Items & Extensions -> Driver Extensions -> enable Karabiner-DriverKit-VirtualHIDDevice"
        echo "then re-run this script to finish:  curl -fsSL $base/install.sh | sudo sh"
        exit 0
    fi

    kanata_bin=""
    for c in /opt/homebrew/bin/kanata /usr/local/bin/kanata; do
        if [ -x "$c" ]; then kanata_bin="$c"; break; fi
    done
    [ -n "$kanata_bin" ] || {
        echo "kanata binary not found — install it first (see README), then re-run" >&2
        exit 1
    }

    mkdir -p /etc/kanata
    tmp_kbd="$(mktemp /tmp/mac.kbd.XXXXXX)"
    curl -fsSL "${base%/mac}/kanata.kbd" -o "$tmp_kbd"
    "$kanata_bin" --cfg "$tmp_kbd" --check
    chmod 644 "$tmp_kbd"
    mv "$tmp_kbd" /etc/kanata/mac.kbd
    echo "installed /etc/kanata/mac.kbd"

    if launchctl print system 2>/dev/null | grep -q "Karabiner-VirtualHIDDevice-Daemon"; then
        echo "VirtualHIDDevice daemon already managed — skipping its LaunchDaemon"
    else
        curl -fsSL "$base/$vhid_plist" -o "$daemons/$vhid_plist"
        chown root:wheel "$daemons/$vhid_plist"
        launchctl bootstrap system "$daemons/$vhid_plist"
        echo "installed VirtualHIDDevice daemon"
    fi

    curl -fsSL "$base/$kanata_plist" -o "$daemons/$kanata_plist"
    sed -i '' "s|/usr/local/bin/kanata|$kanata_bin|" "$daemons/$kanata_plist"
    chown root:wheel "$daemons/$kanata_plist"
    launchctl bootout system/dev.kanata.kanata 2>/dev/null || true
    launchctl bootstrap system "$daemons/$kanata_plist"

    echo "done — test: hold the right thumb (RCmd) + e -> up arrow (NAV)   (logs: /var/log/kanata.log)"
}

main "$@"
