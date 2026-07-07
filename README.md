# kanata-settings

A [kanata](https://github.com/jtroo/kanata) config with "timerless" home row
mods (urob-style: mods only arm after a 250 ms typing pause, so fast typing
never misfires or reorders letters), plus NAV / SYM / NUM / FUN layers,
neighbour-key combos, a mouse layer, Num Word, and a plain mode for lending
the keyboard.

**One config for both OSes**: [`kanata.kbd`](kanata.kbd) serves Windows and
macOS — the platform differences (thumb keys, Ctrl-vs-Cmd shortcuts, the
app swapper's mod) live in `(platform ...)` blocks that kanata resolves at
load, and everything else is shared, edited once. Per-OS install lives in
its folder:

| Path | What | Docs |
|---|---|---|
| [`kanata.kbd`](kanata.kbd) | THE config — GASC home row (Win/Cmd Alt/Opt Shift Ctrl), all layers and combos | — |
| [`wins/`](wins/) | Windows install: `katana.bat` launcher (validates with `--check`, then starts hidden) | [wins/README.md](wins/README.md) |
| [`mac/`](mac/) | macOS install: Karabiner driver + LaunchDaemons installer (`install.sh`) | [mac/README.md](mac/README.md) |

Each README documents its platform's install steps, layer maps, combos, and
troubleshooting.
