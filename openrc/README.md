# kanata on OpenRC — install

Layout, layer maps, combos, and tuning: [main README](../README.md). This
page installs [`kanata.kbd`](kanata.kbd) — the Linux build of the shared
design, 34 remapped keys, F-row stock — to `~/.config/kanata/kanata.kbd`,
supervised by OpenRC.

This folder is keyed to the **init system, not the distro**: it serves
Artix, Alpine, Gentoo, Devuan, and any other OpenRC host regardless of
family. For a systemd host use [`debian/`](../debian/README.md),
[`fedora/`](../fedora/README.md) or [`arch/`](../arch/README.md) instead —
the `kanata.kbd` is byte-identical in all of them.

## Requirements

| Item | Value |
|---|---|
| kanata | v1.11.0+ ([releases](https://github.com/jtroo/kanata/releases)) |
| Init | OpenRC — `install.sh` refuses a host without `rc-update`/`rc-service` |
| Packaging | varies: Artix has `kanata-bin` in the AUR; Devuan inherits Debian's 1.9.0, which is **too old**; others may not package it. `cargo install kanata` or a release binary in `~/.local/bin` always works |
| Desktop | GNOME defaults — see [DE-specific aliases](../README.md#de-specific-aliases) |

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/openrc/install.sh | sh
```

Run it as your normal user — [`install.sh`](install.sh) sudos only the steps
that need root, and is idempotent.

| It does | Where |
|---|---|
| Verifies kanata is on PATH and is v1.11.0+ | — |
| Creates the `uinput` system group; adds you to `input` and `uinput` | — |
| Installs the udev rule, reloads and triggers udev when `udevadm` exists | `/etc/udev/rules.d/99-input.rules` |
| Installs the config, `--check`ed first | `~/.config/kanata/kanata.kbd` |
| Installs the init script and `rc-update add kanata default` | `/etc/init.d/kanata` |

| It substitutes into the init script | With |
|---|---|
| the `#!/sbin/openrc-run` shebang | the resolved `command -v openrc-run` |
| `command="/usr/bin/kanata"` | the resolved `command -v kanata` |
| `command_args=` config path | your `~/.config/kanata/kanata.kbd` |
| `command_user="user"` | your username |

If any placeholder survives, the script refuses to install rather than leave
a broken service behind.

| Service detail | Value |
|---|---|
| Runs as | you, not root — OpenRC's `start-stop-daemon` applies your supplementary groups, so `input` and `uinput` carry over |
| Supervision | `command_background=true` with `pidfile=/run/kanata.pid`; kanata runs in the foreground with `--no-wait` so it never blocks on exit |
| Ordering | `need localmount` (your `$HOME` must be mounted — the config lives there), `after udev` |
| Logs | `/var/log/kanata.log` |

Group membership needs a fresh login. When the script says so, log out and
back in, then:

```sh
sudo rc-service kanata start
```

| Test | Expect |
|---|---|
| inner-left thumb (LAlt) + `c` | Ctrl+C |
| right thumb (RAlt) + `e` | ↑ |

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
| Deploy to | `~/.config/kanata/kanata.kbd`, or re-run `install.sh` |
| Reload | `sudo rc-service kanata restart` |
| Status | `sudo rc-service kanata status` |
| Disable at boot | `sudo rc-update del kanata default` |
| Logs | `tail -f /var/log/kanata.log` |

Artix note: the AUR `kanata` package also installs a **systemd** unit, which
is inert under OpenRC — `kanata-bin` installs only the binaries. Neither
ships a udev rule, so this installer's is what grants `/dev/uinput`.

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
