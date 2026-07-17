# kanata on Windows — install

Everything about the layout — shortcuts, layer maps, combos, tuning — lives
in the [main README](../README.md). This page is only how to get it running
on Windows. The config itself is the shared [`kanata.kbd`](../kanata.kbd).

## Install

Needs Windows 10/11 and `kanata.exe` (**v1.11.0+**,
[releases](https://github.com/jtroo/kanata/releases)) on your PATH. Then:

```powershell
# config → %USERPROFILE%
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/kanata.kbd" -OutFile "$Home\kanata.kbd"
```

```powershell
# launcher → Startup folder (starts kanata silently at every login)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/katana.bat" -OutFile "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\kanata.bat"
```

Run the downloaded `kanata.bat` once (or log off/on) — it validates the
config with `--check` first (a broken config shows a visible error instead
of failing silently), then starts kanata hidden. Test: hold the inner-left
thumb (LAlt) + `c` → Ctrl+C (NUM), and hold the **right thumb** (RAlt) +
`e` → ↑ (its tap = Enter, hold = NAV).

## Running it by hand

1. Validate: `kanata.exe --cfg kanata.kbd --check`
2. Run: `kanata.exe --cfg kanata.kbd` — **as administrator** if you want
   remaps inside elevated apps
3. Test: hold LAlt + `c` → Ctrl+C; hold the right thumb + `e` → ↑ (NAV);
   tap the LAlt thumb → Esc, the right thumb → Enter.

**Elevated autostart:** the Startup-folder `kanata.bat` runs unelevated. If
you want remaps in admin apps without a UAC prompt, use Task Scheduler
instead: trigger "At log on", check "Run with highest privileges".

**After editing the config:** run `--check`, put the edited file at
`%USERPROFILE%\kanata.kbd` (the copy `kanata.bat` launches), then restart
kanata to apply (stop it and re-run `kanata.bat`, or end the process and
relaunch).

## Windows-specific troubleshooting

- **"Remaps don't work in Task Manager / admin windows."** Run kanata as
  administrator (see elevated autostart above).
- Everything else (mods, combos, layers) is platform-independent — see the
  [main README's troubleshooting](../README.md#troubleshooting).

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
