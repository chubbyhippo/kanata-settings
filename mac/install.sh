#!/bin/sh
# kanata mac setup — config + LaunchDaemons (the mac equivalent of katana.bat).
# Usage:  curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac/install.sh | sudo sh
#
# Prereqs (manual, see README.md): Karabiner driver v6.2.0 installed + activated,
# kanata binary installed, Input Monitoring + Accessibility granted.
# Idempotent: safe to re-run after editing the config or moving the binary.

set -eu

main() {
    base="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac"
    daemons="/Library/LaunchDaemons"
    kanata_plist="dev.kanata.kanata.plist"
    vhid_plist="org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"

    [ "$(id -u)" -eq 0 ] || {
        echo "must run as root:  curl -fsSL $base/install.sh | sudo sh" >&2
        exit 1
    }

    # find the kanata binary (Homebrew Apple Silicon, Homebrew Intel / manual install)
    kanata_bin=""
    for c in /opt/homebrew/bin/kanata /usr/local/bin/kanata; do
        if [ -x "$c" ]; then kanata_bin="$c"; break; fi
    done
    [ -n "$kanata_bin" ] || {
        echo "kanata binary not found — install it first (see README), then re-run" >&2
        exit 1
    }

    # config — validate before anything autostarts
    mkdir -p /etc/kanata
    curl -fsSL "$base/mac.kbd" -o /etc/kanata/mac.kbd
    "$kanata_bin" --cfg /etc/kanata/mac.kbd --check
    echo "installed /etc/kanata/mac.kbd"

    # VirtualHIDDevice daemon — skip if Karabiner-Elements (or a previous run) already manages it
    if launchctl print system 2>/dev/null | grep -q "Karabiner-VirtualHIDDevice-Daemon"; then
        echo "VirtualHIDDevice daemon already managed — skipping its LaunchDaemon"
    else
        curl -fsSL "$base/$vhid_plist" -o "$daemons/$vhid_plist"
        chown root:wheel "$daemons/$vhid_plist"
        launchctl bootstrap system "$daemons/$vhid_plist"
        echo "installed VirtualHIDDevice daemon"
    fi

    # kanata LaunchDaemon, pointed at the detected binary
    curl -fsSL "$base/$kanata_plist" -o "$daemons/$kanata_plist"
    sed -i '' "s|/usr/local/bin/kanata|$kanata_bin|" "$daemons/$kanata_plist"
    chown root:wheel "$daemons/$kanata_plist"
    launchctl bootout system/dev.kanata.kanata 2>/dev/null || true
    launchctl bootstrap system "$daemons/$kanata_plist"

    echo "done — test: hold left Cmd + k -> up arrow   (logs: /var/log/kanata.log)"
}

main "$@"
