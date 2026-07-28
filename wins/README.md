# kanata on Windows — install

Layout, layer maps, combos, and tuning: [main README](../README.md). This
page installs [`kanata.kbd`](kanata.kbd) — 34 remapped keys, F-row stock.

## Requirements

| Item | Value |
|---|---|
| OS | Windows 10 / 11 |
| Binary | `kanata.exe` v1.11.0+ on PATH ([releases](https://github.com/jtroo/kanata/releases)) |

## Install

```powershell
# config → %USERPROFILE%
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/kanata.kbd" -OutFile "$Home\kanata.kbd"
```

```powershell
# launcher → Startup folder (starts kanata silently at every login)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/katana.bat" -OutFile "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\kanata.bat"
```

Run the downloaded `kanata.bat` once, or log off and on. It runs `--check`
first, then starts kanata hidden.

| Test | Expect |
|---|---|
| inner-left thumb (LAlt) + `c` | Ctrl+C |
| right thumb (RAlt) + `e` | ↑ |

## Running it by hand

| Step | Command |
|---|---|
| Validate | `kanata.exe --cfg kanata.kbd --check` |
| Run | `kanata.exe --cfg kanata.kbd` — as administrator for remaps inside elevated apps |

## Elevated autostart

The Startup-folder `kanata.bat` runs unelevated. For remaps in admin apps
without a UAC prompt, use Task Scheduler instead: trigger "At log on", check
"Run with highest privileges".

## After editing the config

| Step | Command / path |
|---|---|
| Validate | `kanata.exe --cfg kanata.kbd --check` |
| Deploy to | `%USERPROFILE%\kanata.kbd` |
| Reload | stop kanata, re-run `kanata.bat` |

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
