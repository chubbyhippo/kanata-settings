# kanata on macOS — install

Everything about the layout — shortcuts, layer maps, combos, tuning — lives
in the [main README](../README.md). This page is only how to get it running
on macOS. The config is this folder's [`kanata.kbd`](kanata.kbd) — the
macOS build of the shared design (46 remapped keys; the F-row carries the
printed Apple media row); `install.sh` deploys it to `/etc/kanata/mac.kbd`.

## Install

Needs **kanata v1.11.0+**
([releases](https://github.com/jtroo/kanata/releases)). One-time setup:

1. **kanata binary:** `brew install kanata`, or put the release binary at
   `/usr/local/bin/kanata` (`chmod +x` it).

2. **Everything else** — Karabiner driver, config, autostart:

   ```sh
   curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac/install.sh | sudo sh
   ```

   [`install.sh`](install.sh) downloads the [Karabiner driver **v6.2.0**](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/tag/v6.2.0)
   (the exact version kanata is built against), checksum-verifies and
   installs it, and activates the extension. Approving it is the one step
   Apple keeps manual: the script stops and points you to System Settings →
   General → Login Items & Extensions → Driver Extensions. Approve, re-run
   the same command, and it finishes — config at `/etc/kanata/mac.kbd`
   (validated first), both LaunchDaemons installed and pointed at your
   kanata binary, the `org.pqrs` daemon skipped if Karabiner-Elements
   already manages it. Idempotent — re-run any time.

3. **Permissions:** System Settings → Privacy & Security → add the kanata
   binary to **Input Monitoring** and **Accessibility**. Both are required:
   the Karabiner driver handles keyboard events, but mouse simulation
   (`movemouse-*`, clicks, scroll) goes through the macOS CoreGraphics API
   which needs Accessibility separately.

   **Finding the binary in the file picker** — the kanata binary lives in a
   system path that the macOS file picker hides by default. First, confirm
   the exact path your install uses:

   ```sh
   grep -A2 ProgramArguments /Library/LaunchDaemons/dev.kanata.kanata.plist
   ```

   It will be one of:
   - `/opt/homebrew/bin/kanata` — Apple Silicon (M1/M2/M3/M4)
   - `/usr/local/bin/kanata` — Intel

   Then add it to both **Input Monitoring** and **Accessibility** — do the
   following steps twice, once for each:

   1. System Settings → Privacy & Security → **Input Monitoring** (first
      pass) / **Accessibility** (second pass)
   2. Click the lock icon and enter your password
   3. Click **+**
   4. In the file picker, press **Cmd+Shift+G** to open the "Go to Folder"
      dialog
   5. Paste `/opt/homebrew/bin` (Apple Silicon) or `/usr/local/bin`
      (Intel) and press **Enter**
   6. Select `kanata` and click **Open**

   If kanata is already listed but the mouse layer still doesn't work,
   **toggle the switch off then on** — macOS sometimes silently breaks the
   permission after a binary update.

   7. Restart kanata to pick up the new permissions:
      ```sh
      sudo launchctl kickstart -k system/dev.kanata.kanata
      ```

Then test: hold the **right thumb** (RCmd) + `e` → ↑ (its tap = Enter,
hold = NAV).

## Running it by hand

1. Validate: `kanata --cfg kanata.kbd --check`
2. Run: `sudo kanata --cfg kanata.kbd` — kanata must run as root on macOS
3. Test: hold the right thumb + `e` → ↑ (NAV). Tap the LCmd thumb → Esc;
   tap the right thumb → Enter.

**Autostart:** covered by the [Install](#install) section's LaunchDaemons.

**After editing the config:** run `--check`, re-run `install.sh` (or copy
the file to `/etc/kanata/mac.kbd` yourself), then reload with
`sudo launchctl kickstart -k system/dev.kanata.kanata`.

## macOS-specific troubleshooting

- **"The right Cmd key doesn't send Cmd anymore."** Intended — it's now a
  layer thumb: **tap = Enter, hold = NAV**. Cmd lives on `a`/`;` (hold) and
  the one-shots; for Cmd+Tab hold NAV and tap `.` (the swapper).
- **"Left Opt does something unexpected."** The left Option thumb taps
  Spotlight (Cmd+Space); its hold does nothing (NUM is on the left Cmd
  thumb). Accents live on the untouched *right* Opt.
- **"Mouse layer enters but cursor doesn't move / clicks don't register."**
  Keyboard remapping goes through the Karabiner driver; mouse simulation
  uses the macOS CoreGraphics API and requires **Accessibility** permission
  for the kanata binary — Input Monitoring alone isn't enough. See step 3
  of [Install](#install).
- **"kanata dies instantly (`filesystem_error`)."** In order of likelihood:
  not running as root, driver not installed/approved, or another process
  (e.g. Karabiner-Elements) is grabbing the keyboard.
- **"`connect_failed asio.system:2` in a loop."** The VirtualHIDDevice
  daemon isn't running — bootstrap the `org.pqrs` LaunchDaemon from
  [Install](#install).
- **"Keys remap but nothing types."** Give the kanata binary Input
  Monitoring permission; after replacing the binary, toggle the permission
  off and on.
- Everything else (mods, combos, layers) is platform-independent — see the
  [main README's troubleshooting](../README.md#troubleshooting).

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
