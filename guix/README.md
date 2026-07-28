# kanata on Guix — install

Layout, layer maps, combos, and tuning: [main README](../README.md). This
page wires [`kanata.kbd`](kanata.kbd) — the Linux build of the shared
design, 34 remapped keys, F-row stock — into a Guix system declaration.

Guix is the one platform here with no installer script. kanata is packaged,
and `(gnu services desktop)` exports a native `kanata-service-type` that
creates the daemon user, the groups, the udev rule, and the Shepherd
service, so the whole setup is declarative.

## Requirements

| Item | Value |
|---|---|
| kanata | `kanata` 1.11.0, `gnu/packages/rust-apps.scm` — nothing to install by hand |
| Service | `kanata-service-type` from `(gnu services desktop)` |
| Guix | new enough to export it — check below, and `guix pull` if it errors |
| Desktop | GNOME defaults — see [DE-specific aliases](../README.md#de-specific-aliases) |

```sh
guix repl -c '(begin (use-modules (gnu services desktop)) (display kanata-service-type))'
```

## What the service type handles

| Concern | Provided by `kanata-service-type` |
|---|---|
| Daemon account | system user `kanata`, supplementary groups `input` and `uinput` |
| udev | `99-kanata.rules` — `KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"` |
| Shepherd | one service per keymap: `kanata -c <keymap> --no-wait`, `Restart` handled by Shepherd |
| Naming | first keymap is service `kanata-0`, logging to `/var/log/kanata-0.log` |

## Install

Add the service to your `operating-system`, pointing `local-file` at this
folder's config with an absolute path (or keep a copy beside `config.scm`):

```scheme
(use-modules (gnu services desktop)
             (guix gexp))

(operating-system
  ;; ...
  (services
   (cons* (service kanata-service-type
                   (kanata-configuration
                    (keymaps (list (local-file "/path/to/kanata-settings/guix/kanata.kbd")))))
          %desktop-services)))
```

Or use this folder's ready-made module, which already points at its own
`kanata.kbd`:

```scheme
(use-modules (kanata-service))

(operating-system
  ;; ...
  (services (cons* kanata-meow-service %desktop-services)))
```

```sh
sudo guix system reconfigure -L /path/to/kanata-settings/guix /etc/config.scm
```

| Test | Expect |
|---|---|
| inner-left thumb (LAlt) + `c` | Ctrl+C |
| right thumb (RAlt) + `e` | ↑ |

## After editing the config

| Step | Command |
|---|---|
| Validate | `guix shell kanata -- kanata --cfg kanata.kbd --check` |
| Apply | `sudo guix system reconfigure /etc/config.scm` |
| Restart | `sudo herd restart kanata-0` |
| Logs | `sudo tail -f /var/log/kanata-0.log` |

## License

GPL-3.0-or-later. See [LICENSE](../LICENSE) for the full text.
