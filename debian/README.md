# kanata on Debian and derivatives — install

Layout, layer maps, combos, and tuning: [main README](../README.md). This
page installs [`kanata.kbd`](kanata.kbd) — the Linux build of the shared
design, 34 remapped keys, F-row stock — to `~/.config/kanata/kanata.kbd`.

This folder serves the whole Debian family — Debian, Ubuntu, Linux Mint,
Pop!_OS and the rest. Nothing in `install.sh` is Debian-specific; see
[Derivatives](#derivatives) for the two things that do vary.

## Requirements

| Item | Value |
|---|---|
| kanata | v1.11.0+ ([releases](https://github.com/jtroo/kanata/releases)) |
| **Not** from your distro's archive | Debian ships **1.9.0-12** (sid/forky only, absent from trixie) — older than the chords-v2 and virtualkey features this config needs, and `install.sh` refuses it. Ubuntu publishes **no** kanata package at all, and neither does Mint |
| Install it with | `cargo install kanata`, or a release binary in `~/.local/bin` (`chmod +x`) |
| Desktop | GNOME defaults — see [DE-specific aliases](../README.md#de-specific-aliases) |
| Service | systemd user unit. On an OpenRC host use [`openrc/`](../openrc/README.md) instead |

## Derivatives

Two things vary across the family: the **init system** — `install.sh`
installs a systemd user unit, [`openrc/install.sh`](../openrc/README.md)
installs an OpenRC service — and the **desktop**, which decides whether the four
[DE-specific aliases](../README.md#de-specific-aliases) are right. Nothing
else: the group, udev, and config steps are identical everywhere, and both
installers share them.

| Distro | Desktop | Verdict |
|---|---|---|
| Debian | GNOME | Use as-is |
| Ubuntu | GNOME | Use as-is |
| Pop!_OS, Zorin, other GNOME-based | GNOME | Use as-is; spot-check `overview` and `minimize` if the shell is customised |
| **Linux Mint** | **Cinnamon** | Install works; **`overview` and `minimize` are unbound on Cinnamon** — see the table below |
| Mint MATE / Xfce editions, Kali, elementary | MATE, Xfce, Pantheon | Install works; review all four aliases against your desktop's own defaults |
| Devuan, antiX, MX running **OpenRC** | varies | Use [`openrc/`](../openrc/README.md) instead |
| antiX, MX running **plain sysvinit** | varies | Neither installer applies. Do the group/udev steps by hand from kanata's `docs/setup-linux.md`, then start kanata from your own init script |

On Cinnamon, two of the four aliases are unbound **upstream**, so they do
nothing until you bind them yourself in Keyboard settings and point the
alias at whatever you chose:

| Alias | GNOME | Cinnamon |
|---|---|---|
| `overview` | `lmet` — Super tap opens Activities | **unbound** — muffin's `overlay-key` default is `''`; bind Expo or Scale, then use that |
| `minimize` | `M-h` | **unbound** — Cinnamon's `minimize` default is `[]` |
| `emoji` | `C-.` | `C-.` — works, it is GTK-level not desktop-level |
| `screenshot` | `prnt` | `prnt` — works, Cinnamon's `screenshot` is `['Print']` |

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/debian/install.sh | sh
```

Run it as your normal user — [`install.sh`](install.sh) sudos only the steps
that need root, and is idempotent.

| It does | Where |
|---|---|
| Verifies kanata is on PATH and is v1.11.0+ | — |
| Creates the `uinput` system group; adds you to `input` and `uinput` | — |
| Installs the udev rule, reloads and triggers udev | `/etc/udev/rules.d/99-input.rules` |
| Installs the config, `--check`ed first | `~/.config/kanata/kanata.kbd` |
| Installs and enables the unit, with the resolved kanata path substituted | `~/.config/systemd/user/kanata.service` |

Group membership needs a fresh login. When the script says so, log out and
back in, then:

```sh
systemctl --user start kanata.service
```

| Test | Expect |
|---|---|
| inner-left thumb (LAlt) + `c` | Ctrl+C |
| right thumb (RAlt) + `e` | ↑ |

## OpenRC

Not here — OpenRC is keyed to the init system, not the distro, so it lives
in [`openrc/`](../openrc/README.md) and serves Artix, Alpine and Gentoo too.
Devuan, antiX and MX running OpenRC should use that folder; the `kanata.kbd`
is byte-identical to this one.

## Running it by hand

| Step | Command |
|---|---|
| Validate | `kanata --cfg kanata.kbd --check` |
| Run | `kanata --cfg kanata.kbd` |
| Run before the group change is active | `newgrp uinput -c "kanata --cfg kanata.kbd"` |

## After editing the config

| Step | Command / path |
|---|---|
| Validate | `kanata --cfg kanata.kbd --check` |
| Deploy to | `~/.config/kanata/kanata.kbd`, or re-run the installer |
| Reload | `systemctl --user restart kanata.service` |
| Logs | `journalctl --user -u kanata -f` |

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
