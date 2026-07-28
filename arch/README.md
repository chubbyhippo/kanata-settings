# kanata on Arch — install

Layout, layer maps, combos, and tuning: [main README](../README.md). This
page installs [`kanata.kbd`](kanata.kbd) — the Linux build of the shared
design, 34 remapped keys, F-row stock — to `~/.config/kanata/kanata.kbd`.

## Requirements

| Item | Value |
|---|---|
| kanata | v1.11.0+ ([releases](https://github.com/jtroo/kanata/releases)) |
| Packaging | AUR, not the official repos: [`kanata-bin`](https://aur.archlinux.org/packages/kanata-bin) (prebuilt), [`kanata`](https://aur.archlinux.org/packages/kanata) (from source), [`kanata-git`](https://aur.archlinux.org/packages/kanata-git). Both tagged packages are at 1.12.0-1, so either satisfies the version floor |
| Install it with | `paru -S kanata-bin`, or `cargo install kanata` |
| Desktop | GNOME defaults — see [DE-specific aliases](../README.md#de-specific-aliases) |
| Service | systemd user unit |

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/arch/install.sh | sh
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

Neither AUR package ships a udev rule, so this installer's is what grants
`/dev/uinput` access. `kanata-bin` installs only the binaries;
`kanata` also installs a **system** unit at
`/usr/lib/systemd/system/kanata.service`. This installer uses a **user**
unit — if you enabled the system one, disable it so the two don't both grab
the keyboard.

Group membership needs a fresh login. When the script says so, log out and
back in, then:

```sh
systemctl --user start kanata.service
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
| Reload | `systemctl --user restart kanata.service` |
| Logs | `journalctl --user -u kanata -f` |

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
