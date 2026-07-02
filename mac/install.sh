#!/bin/sh
# kanata mac setup — Karabiner driver + config + LaunchDaemons.
# Usage:  curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac/install.sh | sudo sh
#
# Prereqs (manual, see README.md): kanata binary installed, Input Monitoring +
# Accessibility granted. Approving the driver extension is the one step Apple
# keeps manual — the script stops and tells you when.
# Idempotent: safe to re-run; it skips whatever is already done.

set -eu                                       # -e: abort on the first failed command; -u: abort on undefined variables

main() {
    base="https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac"   # raw-file root of this repo's mac folder
    daemons="/Library/LaunchDaemons"          # where macOS looks for system (root) services to start at boot
    kanata_plist="dev.kanata.kanata.plist"    # service definition that runs kanata
    vhid_plist="org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist"   # service definition for the Karabiner virtual-keyboard daemon
    driver_ver="6.2.0"                        # kanata is built against this exact driver release — do not bump casually
    driver_sha="9e8c46239f0748161241e42444857901224e5c82f5b58a1731df4c70bf0736a8"   # sha256 of the official v6.2.0 pkg
    manager="/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"   # CLI that (de)activates the driver

    [ "$(id -u)" -eq 0 ] || {                 # id -u prints the numeric user id; 0 = root — everything below needs root
        echo "must run as root:  curl -fsSL $base/install.sh | sudo sh" >&2   # >&2 = print to stderr, not stdout
        exit 1                                # stop with a failure exit code
    }

    # ---- Karabiner driver: download, install, activate (approval itself can't be scripted) ----
    if systemextensionsctl list 2>/dev/null | grep "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice" | grep -q "activated enabled"; then   # is the extension already live?
        echo "Karabiner driver already activated"
    else
        if [ ! -x "$manager" ]; then          # no manager app = the driver pkg was never installed
            pkg="/tmp/Karabiner-DriverKit-VirtualHIDDevice-$driver_ver.pkg"   # where to put the download
            curl -fsSL "https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v$driver_ver/Karabiner-DriverKit-VirtualHIDDevice-$driver_ver.pkg" -o "$pkg"   # fetch the official pkg
            echo "$driver_sha  $pkg" | shasum -a 256 -c - >/dev/null   # verify the checksum; a corrupt or tampered download aborts here
            installer -pkg "$pkg" -target /   # Apple's CLI installer; -target / = install onto the boot volume
            rm -f "$pkg"                      # tidy up the download
        fi
        "$manager" forceActivate              # ask macOS to load the system extension (harmless if already pending)
        echo ""
        echo "driver installed — one manual step Apple requires:"
        echo "  System Settings -> General -> Login Items & Extensions -> Driver Extensions -> enable Karabiner-DriverKit-VirtualHIDDevice"
        echo "then re-run this script to finish:  curl -fsSL $base/install.sh | sudo sh"
        exit 0                                # stop here; the rest is pointless until the extension is approved
    fi

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

    echo "done — test: hold x + e -> up arrow (NAV)   (logs: /var/log/kanata.log)"
}

main "$@"   # everything above only *defines* main; calling it on the last line means a half-downloaded script executes nothing
