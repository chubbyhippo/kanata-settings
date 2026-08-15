# kanata on macOS — install

Layout, layer maps, combos, and tuning: [main README](../README.md). This
page installs [`kanata.kbd`](kanata.kbd) — 46 remapped keys, the F-row
carrying the printed Apple media functions — to `/etc/kanata/mac.kbd`.

## Requirements

| Item | Value |
|---|---|
| kanata | v1.11.0+ ([releases](https://github.com/jtroo/kanata/releases)) — `brew install kanata`, or the release binary at `/usr/local/bin/kanata` (`chmod +x` it) |
| Driver | [Karabiner-DriverKit-VirtualHIDDevice v6.2.0](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/tag/v6.2.0) — the exact version kanata is built against; installed and checksum-verified by `install.sh` |

## 1. Driver, config, autostart

```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac/install.sh | sudo sh
```

[`install.sh`](install.sh) is idempotent — re-run it any time. It stops once
for the step Apple keeps manual: System Settings → General → Login Items &
Extensions → Driver Extensions → enable
Karabiner-DriverKit-VirtualHIDDevice. Approve it, re-run the same command,
and it finishes.

| It installs | Where |
|---|---|
| Config, validated first | `/etc/kanata/mac.kbd` |
| kanata LaunchDaemon, pointed at your binary | `/Library/LaunchDaemons/dev.kanata.kanata.plist` |
| VirtualHIDDevice LaunchDaemon, skipped when Karabiner-Elements already manages it | `/Library/LaunchDaemons/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist` |

## 2. Permissions

`install.sh` reads the system TCC database after install. If Input Monitoring
or Accessibility is missing, it prints the paths to add and how to grant them.
Add the kanata binary to **both** lists under System Settings → Privacy &
Security — the Homebrew symlink **and** the real Cellar file. Confirm the
path launchd will run:

```sh
grep -A2 ProgramArguments /Library/LaunchDaemons/dev.kanata.kanata.plist
```

| CPU | Path |
|---|---|
| Apple Silicon | `/opt/homebrew/bin/kanata` |
| Intel | `/usr/local/bin/kanata` |

For each of the two lists: unlock → **+** → **Cmd+Shift+G** → paste the
directory → Enter → select `kanata` → Open. Then reload:

```sh
sudo launchctl kickstart -k system/dev.kanata.kanata
```

| Test | Expect |
|---|---|
| right thumb (RCmd) + `e` | ↑ |
| tap the LCmd thumb | Esc |
| tap the right thumb | Enter |

## Running it by hand

| Step | Command |
|---|---|
| Validate | `kanata --cfg kanata.kbd --check` |
| Run | `sudo kanata --cfg kanata.kbd` — root is required on macOS |

## After editing the config

| Step | Command / path |
|---|---|
| Validate | `kanata --cfg kanata.kbd --check` |
| Deploy to | `/etc/kanata/mac.kbd`, or re-run `install.sh` |
| Reload | `sudo launchctl kickstart -k system/dev.kanata.kanata` |

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
