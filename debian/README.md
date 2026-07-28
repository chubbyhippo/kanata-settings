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
| Service | systemd user unit, or an OpenRC service — see [Derivatives](#derivatives) and [OpenRC](#openrc) |

## Derivatives

Two things vary across the family: the **init system** — `install.sh`
installs a systemd user unit, [`install-openrc.sh`](#openrc) installs an
OpenRC service — and the **desktop**, which decides whether the four
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
| Devuan, antiX, MX running **OpenRC** | varies | Use [`install-openrc.sh`](install-openrc.sh) instead — see [OpenRC](#openrc) |
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

For hosts running OpenRC instead of systemd. Same config, same group and
udev steps — only the service differs.

```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/debian/install-openrc.sh | sh
```

Run it as your normal user; [`install-openrc.sh`](install-openrc.sh) is
idempotent and refuses to run on a host without `rc-update`/`rc-service`.
It does everything `install.sh` does, then installs
[`kanata.openrc`](kanata.openrc) as `/etc/init.d/kanata` and
`rc-update add kanata default`.

| It substitutes into the init script | With |
|---|---|
| the `#!/sbin/openrc-run` shebang | the resolved `command -v openrc-run` |
| `command="/usr/bin/kanata"` | the resolved `command -v kanata` |
| `command_args=` config path | your `~/.config/kanata/kanata.kbd` |
| `command_user="user"` | your username |

If any placeholder survives, the script refuses to install rather than
leave a broken service behind.

| Service detail | Value |
|---|---|
| Runs as | you, not root — OpenRC's `start-stop-daemon` applies your supplementary groups, so `input` and `uinput` carry over |
| Supervision | `command_background=true` with `pidfile=/run/kanata.pid`; kanata runs in the foreground with `--no-wait` so it never blocks on exit |
| Ordering | `need localmount` (your `$HOME` must be mounted — the config lives there), `after udev` |
| Logs | `/var/log/kanata.log` |

| Step | Command |
|---|---|
| Status | `sudo rc-service kanata status` |
| Restart after editing the config | `sudo rc-service kanata restart` |
| Disable at boot | `sudo rc-update del kanata default` |

The init script is tied to OpenRC, not to Debian — the same two files work
on Artix, Alpine, or Gentoo. Only the "install kanata itself" advice in the
script's error message is Debian-family wording.

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
| Reload (systemd) | `systemctl --user restart kanata.service` |
| Reload (OpenRC) | `sudo rc-service kanata restart` |
| Logs | `journalctl --user -u kanata -f` · OpenRC: `/var/log/kanata.log` |

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
