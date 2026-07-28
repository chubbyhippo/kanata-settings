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
| Derivatives | See [Manjaro and other Arch derivatives](#manjaro-and-other-arch-derivatives) |
| Service | systemd user unit. On **Artix** or any other OpenRC host, use [`openrc/`](../openrc/README.md) — that folder is keyed to the init system, not the distro |

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

## Manjaro and other Arch derivatives

`install.sh` runs unchanged on Manjaro, EndeavourOS, Garuda and CachyOS —
they are all systemd, and the group/udev/config steps are identical. Two
things differ.

| Distro | Getting kanata | Desktop |
|---|---|---|
| Arch | `paru -S kanata-bin` | none by default — check your own |
| **Manjaro** | AUR support is **off by default** in `pamac`, and no `yay`/`paru` is preinstalled. Manjaro Stable also lags Arch by a week or two, so the source-built `kanata` AUR package can fail against an older Rust — prefer `kanata-bin`, or `cargo install kanata` | **KDE Plasma** is the flagship edition |
| EndeavourOS, Garuda, CachyOS | `paru -S kanata-bin` as on Arch | varies by edition |
| Artix | as Arch, but OpenRC/runit/s6 — see [`openrc/`](../openrc/README.md) | varies |

kanata is not in Manjaro's repos, because it is not in Arch's official
repos either — Manjaro's are built from Arch's. The installer's version gate
catches anything below v1.11.0 whichever route you take.

On the KDE Plasma edition, four aliases need the KDE values from
[DE-specific aliases](../README.md#de-specific-aliases). The root
[`setup.sh`](../setup.sh) detects Plasma and applies them for you; by hand
it is:

```sh
sed -i -e 's|^  overview lmet$|  overview M-w|' \
       -e 's|^  minimize M-h$|  minimize M-pgdn|' \
       -e 's|^  emoji C-\.$|  emoji M-.|' \
       -e 's|^  langtoggle M-spc$|  langtoggle M-A-k|' \
       kanata.kbd
```

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
