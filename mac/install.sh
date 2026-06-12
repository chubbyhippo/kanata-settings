#!/bin/sh
# kanata mac setup — config + LaunchDaemons.
# Usage:  curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac/install.sh | sudo sh
#
# Prereqs (manual, see README.md): Karabiner driver v6.2.0 installed + activated,
# kanata binary installed, Input Monitoring + Accessibility granted.
# Idempotent: safe to re-run after editing the config or moving the binary.

set -eu                                       # -e: abort on the first failed command; -u: abort on undefined variables

main() {
    base="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac"   # raw-file root of this repo's mac folder
    daemons="/Library/LaunchDaemons"          # where macOS looks for system (root) services to start at boot
    kanata_plist="dev.kanata.kanata.plist"    # service definition that runs kanata
    vhid_plist="org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"   # service definition for the Karabiner virtual-keyboard daemon

    [ "$(id -u)" -eq 0 ] || {                 # id -u prints the numeric user id; 0 = root — everything below needs root
        echo "must run as root:  curl -fsSL $base/install.sh | sudo sh" >&2   # >&2 = print to stderr, not stdout
        exit 1                                # stop with a failure exit code
    }

    # ---- find the kanata binary ----
    kanata_bin=""                             # will hold the first location that matches
    for c in /opt/homebrew/bin/kanata /usr/local/bin/kanata; do   # Homebrew on Apple Silicon, then Homebrew-Intel / manual install
        if [ -x "$c" ]; then kanata_bin="$c"; break; fi           # -x = file exists and is executable; take it and stop looking
    done
    [ -n "$kanata_bin" ] || {                 # -n = string is non-empty; still empty means nothing was found
        echo "kanata binary not found — install it first (see README), then re-run" >&2
        exit 1
    }

    # ---- config: download, then validate before anything autostarts ----
    mkdir -p /etc/kanata                      # create the config dir; -p = no error if it already exists
    curl -fsSL "$base/mac.kbd" -o /etc/kanata/mac.kbd   # -f fail on HTTP errors, -sS quiet but show errors, -L follow redirects
    "$kanata_bin" --cfg /etc/kanata/mac.kbd --check     # parse-check the config; a broken config aborts the install right here
    echo "installed /etc/kanata/mac.kbd"

    # ---- VirtualHIDDevice daemon: skip if something already manages it ----
    if launchctl print system 2>/dev/null | grep -q "Karabiner-VirtualHIDDevice-Daemon"; then   # list loaded system services, search for the daemon
        echo "VirtualHIDDevice daemon already managed — skipping its LaunchDaemon"              # Karabiner-Elements (or a previous run) owns it
    else
        curl -fsSL "$base/$vhid_plist" -o "$daemons/$vhid_plist"   # install the daemon's service definition
        chown root:wheel "$daemons/$vhid_plist"                    # launchd refuses plists not owned by root:wheel
        launchctl bootstrap system "$daemons/$vhid_plist"          # load + start the service now (and at every boot)
        echo "installed VirtualHIDDevice daemon"
    fi

    # ---- kanata LaunchDaemon, pointed at the detected binary ----
    curl -fsSL "$base/$kanata_plist" -o "$daemons/$kanata_plist"            # install kanata's service definition
    sed -i '' "s|/usr/local/bin/kanata|$kanata_bin|" "$daemons/$kanata_plist"   # rewrite the binary path in place ('' = no backup file, BSD sed)
    chown root:wheel "$daemons/$kanata_plist"                               # same ownership rule as above
    launchctl bootout system/dev.kanata.kanata 2>/dev/null || true          # unload any previous install; '|| true' = fine if none was loaded
    launchctl bootstrap system "$daemons/$kanata_plist"                     # load + start kanata now (and at every boot)

    echo "done — test: hold left Cmd + k -> up arrow   (logs: /var/log/kanata.log)"
}

main "$@"   # everything above only *defines* main; calling it on the last line means a half-downloaded script executes nothing
