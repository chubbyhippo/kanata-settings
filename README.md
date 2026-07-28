# kanata-settings

[kanata](https://github.com/jtroo/kanata) timerless home-row-mods layout —
one design, six configs. Requires kanata v1.11.0+.

| Config | Platform | Remapped keys | F-row |
|---|---|---|---|
| [`wins/kanata.kbd`](wins/kanata.kbd) | Windows | 34 | stock F1–F12 |
| [`mac/kanata.kbd`](mac/kanata.kbd) | macOS | 46 | printed Apple media functions |
| [`debian/kanata.kbd`](debian/kanata.kbd) | Debian family — incl. Ubuntu, Mint | 34 | stock F1–F12 |
| [`fedora/kanata.kbd`](fedora/kanata.kbd) | Fedora | 34 | stock F1–F12 |
| [`arch/kanata.kbd`](arch/kanata.kbd) | Arch | 34 | stock F1–F12 |
| [`guix/kanata.kbd`](guix/kanata.kbd) | Guix | 34 | stock F1–F12 |

The four Linux configs are byte-identical; only the install machinery beside
them differs. They assume GNOME — see
[DE-specific aliases](#de-specific-aliases).

## Install

One command anywhere — [`setup.sh`](setup.sh) detects the OS, distro family,
init system, and desktop, then does the right thing:

```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/setup.sh | sh
```

| Detected | What it does |
|---|---|
| macOS | delegates to `mac/install.sh` |
| WSL, or Windows under MSYS/Cygwin | installs the Windows config to `%USERPROFILE%` and the Startup launcher |
| Guix | prints the declarative service snippet — nothing imperative to run |
| Linux + systemd | groups, udev rule, config, systemd **user** unit |
| Linux + OpenRC | groups, udev rule, config, `/etc/init.d/kanata` |
| KDE or Cinnamon | patches the DE-dependent aliases — see [DE-specific aliases](#de-specific-aliases) |

| Flag | Effect |
|---|---|
| `--detect-only` | print what was detected, change nothing |
| `--dry-run` | print every action instead of performing it |
| `--platform` `--family` `--init` `--desktop` | override any part of the detection |

Or follow the per-platform guide by hand:

| OS | Guide |
|---|---|
| Windows | [wins/README.md](wins/README.md) |
| macOS | [mac/README.md](mac/README.md) |
| Debian, Ubuntu, Mint, derivatives | [debian/README.md](debian/README.md) |
| Any OpenRC host (Devuan, Artix, Alpine, Gentoo) | [debian/README.md](debian/README.md#openrc) — `install-openrc.sh` |
| Fedora | [fedora/README.md](fedora/README.md) |
| Arch | [arch/README.md](arch/README.md) |
| Guix | [guix/README.md](guix/README.md) |

## Notation

| Token | Meaning |
|---|---|
| Gui | Win (win) / Cmd (mac) / Super (linux) |
| Alt | Alt (win) / Opt (mac) / Alt (linux) |
| `win / mac` | the Windows value, then the macOS one |
| `linux:` | shown only where Linux differs from Windows; otherwise Linux matches the Windows value |
| `os…` | one-shot modifier — applies to the next keypress |
| `LAYER + key` | hold that layer's key (see its heading), then press `key` |
| keycap | tap = top legend, hold = bottom legend; blank = no-op |

## Thumbs

| Thumb | Physical key (win, linux / mac) | Tap | Hold |
|---|---|---|---|
| outer-left | LWin / LOpt | Start menu / Spotlight · linux: Activities overview | — |
| inner-left | LAlt / LCmd | Esc | NUM |
| Space | Space | Space | — |
| right | RAlt / RCmd | Enter | NAV |

## Rules

| Rule | Value |
|---|---|
| Home row mods arm after an idle pause | 250 ms |
| During a typing burst | the home row is letters only |
| Mid-burst exceptions (hold-taps at all times) | `d`/`k` = Shift, `f`/`j` = Ctrl |
| Cross-hand chord | pause, hold, press |
| Same-hand mod + letter | never chords — use a one-shot, or hold the mod 300 ms first |
| Hold time for a mod or layer | 300 ms |
| Combo idle gate / press window | 350 ms / 60 ms |
| One-shot armed for | 60 s; survives releasing the layer key |

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Undo / Cut / Copy / Paste | NUM + `z` / `x` / `c` / `v` |
| Ctrl chord (Emacs, terminal) | pause, hold `f`/`j`, press a cross-hand key |
| App switcher (Alt-Tab / Cmd-Tab) | NAV + `.` to cycle, `,` steps back; release NAV to commit |
| Minimize window | NAV + `c` — Win+Down / Cmd+M · linux: Super+H |
| Windows overview | NAV + `y` — Task View / Mission Control · linux: Activities overview |
| Enter | tap the right thumb · NAV + `h` · physical Enter |
| Close window | win: FUN + `s` then `j` (Alt+F4) · mac: NUM + `a`, release, `q` (Cmd+Q) |
| Reopen tab (Ctrl/Cmd+Shift+T) | NUM: tap `f` win / `a` mac, tap `d`, release, press `t` |
| Move word left / right | NAV + `a` / `g` |
| Delete word forward / back | combo `f`+`g` / `h`+`j` · NAV + `v` / `z` |
| Select word left / right | NAV: tap `j`+`k` win / `k`+`l` mac, then `s` / `f` |
| `(` `)` `[` `]` | SYM + `u` / `i` / `o` / `p` |
| Home / End | FUN + `h` / `e` |
| Line start / end | combo `v`+`b` / `m`+`n` |
| Arrows | NAV + `e` / `s` / `d` / `f` = ↑ ← ↓ → |
| Modified arrow (select, word-jump) | NAV: tap `j`/`k`/`l`/`;` (stacks), then an arrow |
| Page down / up | NAV + `i` / `o` |
| Next / previous tab | hold `f` (Ctrl) + Tab; add Shift for previous |
| Tab | combo `q`+`w` · NAV + `q` · FUN + `t` |
| Shift+Tab | NAV + `t` |
| Backspace | combo `y`+`u` · NAV + `b` · FUN + `b` |
| Forward delete | combo `r`+`t` · NAV + `p` |
| Start menu / Spotlight | tap the outer-left thumb |
| Gui + a left-hand key (Win+E, Cmd+Q) | NUM: tap `a`, release, press the letter |
| Screenshot | FUN + `x` — Win+Shift+S / Cmd+Shift+4 · linux: Print |
| Emoji picker | FUN + `z` — Win+. / Cmd+Ctrl+Space · linux: Ctrl+. |
| Search Everywhere / Run Anything (IntelliJ) | FUN + `c` (2×Shift) / `v` (2×Ctrl) |
| Switch input language | combo `b`+`n` — Win+Space / Ctrl+Space |
| Select text | hold physical Shift + NAV arrows |
| Accents (mac) | right Opt — untouched |
| Type an amount | combo `m`+`,`; Space = 0; inner-left thumb exits |
| Media | FUN + `q` mute · `w` prev · `g` play/pause · `n` next; Vol− / Vol+ on the left thumbs |
| F1–F12 | FUN + right hand (NUM's digit positions), or the physical F-row while FUN is held |
| mac F-row media | press the printed key |
| Caps Lock | physical Caps Lock · FUN + `y` |
| Esc | tap the inner-left thumb |
| Mouse | combo `z`+`x` enters, `q` exits |
| Plain keyboard (lend, games) | combo `q`+`w`+`e`+`r` toggles |
| All combos off / on | combo `u`+`i`+`o`+`p` toggles |
| Kill kanata | hold physical `LCtrl` + `Space` + `Esc` |

## Layer maps

### DEF — base layer

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   Q   |   W   |   E   |   R   |   T   |    |   Y   |   U   |   I   |   O   |   P   |
|       |       |       |       |       |    |       |       |       |       |       |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   A   |   S   |   D   |   F   |   G   |    |   H   |   J   |   K   |   L   |   ;   |
|  Gui  |  Alt  |  Sft  |  Ctl  |       |    |       |  Ctl  |  Sft  |  Alt  |  Gui  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   Z   |   X   |   C   |   V   |   B   |    |   N   |   M   |   ,   |   .   |   /   |
|  FUN  |  SYM  |       |       |       |    |       |       |       |  SYM  |  FUN  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Thumbs:
+-------+-------+-------+-------+
|   ★   |  Esc  | Space | Enter |
|       |  NUM  |       |  NAV  |
+-------+-------+-------+-------+
 outer   inner   Space   right
```

`★` = Start menu (win) / Spotlight (mac) / Activities overview (linux).

F-row:

| | F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 | F10 | F11 | F12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **mac, bare** | Bright− | Bright+ | Mission Control | Launchpad | Backlight− | Backlight+ | Prev | Play/Pause | Next | Mute | Vol− | Vol+ |
| **win & linux, or FUN held** | F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 | F10 | F11 | F12 |

### NAV — hold the right thumb

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Tab  | Home  |  Up   |  End  | S-Tab |    | Ovrvw | Paste | PgDn  | PgUp  |  Del  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Wrd←  | Left  | Down  | Right | Wrd→  |    | Enter | osCtl | osSft | osAlt | osGui |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Dlw←  |  M-x  |  Min  | Dlw→  | Bksp  |    | Menu  |  M-m  | Swp←  | Swp→  |  M-/  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Space; the other thumbs keep their DEF roles
```

| Label | Meaning |
|---|---|
| `Ovrvw` | Task View (Win+Tab) / Mission Control (Ctrl+↑) · linux: Activities overview (a bare Super tap) |
| `Wrd←` `Wrd→` | move word — Ctrl+arrow / Opt+arrow |
| `Dlw←` `Dlw→` | delete word — Ctrl+Bksp/Del / Opt+Bksp/Del |
| `Min` | minimize — Win+Down / Cmd+M · linux: Super+H |
| `Swp←` `Swp→` | app switcher — holds Alt / Cmd and taps (S-)Tab; releasing NAV commits |
| `Menu` | context-menu key (Shift+F10 win) |
| `M-x` `M-m` `M-/` | Alt+x / Alt+m / Alt+`/` (Emacs; kanata's `M-` here is Gui, so Meta is spelled `A-`) |

### SYM — hold `x` (right-hand keys) or `.` (left-hand keys)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   +   |   -   |   *   |   /   |   =   |    |   &   |   (   |   )   |   [   |   ]   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osGui | osAlt | osSft | osCtl |   $   |    |   #   |   {   |   }   |   '   |   "   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   `   |   ^   |   ~   |   %   |   @   |    |   |   |   \   |   ?   |   !   |   :   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = _
```

### NUM — hold the inner-left thumb

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   (   |   )   |   %   |   =   |   ^   |    |   +   |   7   |   8   |   9   |   *   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osGui | osAlt | osSft | osCtl | Bksp  |    |   -   |   4   |   5   |   6   |   /   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Undo  |  Cut  | Copy  | Paste | ,000  |    |   ,   |   1   |   2   |   3   |   .   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = 0 (never exits) · inner-left thumb: tap = exit NUM, hold = SYM
right thumb: tap = Enter, hold = NAV · outer-left thumb: dead
```

`,000` types a comma and three zeros. `Undo` `Cut` `Copy` `Paste` =
Ctrl+Z/X/C/V (win) / Cmd+Z/X/C/V (mac).

### FUN — hold `z` (right-hand keys) or `/` (left-hand keys)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Quiet | reWind|  End  | Return|  Tab  |    | shoutY|  F7   |  F8   |  F9   |  F10  |
| mute  | prev  |       | enter |       |    |  Caps |       |       |       |       |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osGui | osAlt | osSft | osCtl |  Go   |    |  Home |  F4   |  F5   |  F6   |  F11  |
|       |       |       |       |  play |    |       |       |       |       |       |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Emoji | Shot  | 2×Sft | 2×Ctl |  Bksp |    |  Next |  F1   |  F2   |  F3   |  F12  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Left thumbs = Vol− (inner-left) / Vol+ (Space) · physical F-row = plain F1–F12
```

| Label | Meaning |
|---|---|
| `Shot` | region screenshot — Win+Shift+S / Cmd+Shift+4 · linux: Print |
| `Emoji` | emoji picker — Win+. / Cmd+Ctrl+Space · linux: Ctrl+. |
| `2×Sft` `2×Ctl` | double-tap Shift / Ctrl — IntelliJ Search Everywhere / Run Anything |

### MOUSE — toggle with combo `z`+`x`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Exit  | LClk  |  Up   | RClk  | MClk  |    | Ctrl  | ScrLt | ScrUp | ScrRt | DClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prec  | Left  | Down  | Right |       |    | Shift | LClk  | ScrDn | RClk  | Prec  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Gui  |  Alt  | Shift | Ctrl  |       |    |  Alt  | Back  | MClk  | Fwd   | TClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Thumbs: inner-left = Ctrl · Space = LClk · right = Alt · outer-left = dead
```

| Label | Meaning |
|---|---|
| `Exit` | leave the layer (single key) |
| `Prec` | hold for 1 px precision movement |
| `DClk` `TClk` | double / triple click, each as one macro |
| Move keys | accelerate while held |
| Combos | all disabled inside this layer |

## Combos

```
NEIGHBOUR COMBOS  —  press two (or more) touching keys

   Q     W     E     R     T             Y     U     I     O     P
   └─Tab─┘           └─Del─┘             └─Bsp─┘
   └─────┴Plain┴─────┘                         └─────┴NoCmb┴─────┘

   A     S     D     F     G             H     J     K     L     ;
                     └DelF─┘             └DelB─┘

   Z     X     C     V     B             N     M     ,     .     /
   └Mouse┘           └Line←┘             └Line→┘
                           └────Lang─────┘     └─Num─┘
```

`└─┘` spans the keys pressed together; an interior `┴` marks a middle key
that is also part of the combo (`Plain` = Q·W·E·R, `NoCmb` = U·I·O·P).
`Lang` bridges the hand gap in the picture, but `b` and `n` are physical
neighbours — one index finger each.

| Combo | Result |
|---|---|
| `q w` | Tab |
| `r t` | Forward delete |
| `y u` | Backspace |
| `f g` / `h j` | Delete word forward / back — Ctrl+Del / Ctrl+Bksp (win), Opt+Del / Opt+Bksp (mac) |
| `v b` / `m n` | Line start / end — Home / End (win), Cmd+← / Cmd+→ (mac) |
| `b n` | Switch input language — Win+Space / Ctrl+Space |
| `m ,` | Num Word on |
| `z x` | Mouse layer on/off (`q` exits) |
| `q w e r` | Plain mode on/off — the one combo still live in plain |
| `u i o p` | All combos on/off — the one combo still live while combos are off |

Inside NUM every combo is off except `y`+`u`; inside the mouse layer all of
them are off; while combos are toggled off (a `nocombo` clone of DEF) only
`u`+`i`+`o`+`p` stays live.

## Num Word

| Item | Value |
|---|---|
| On | combo `m`+`,` (disabled inside NUM, so typing digits can't trip it) |
| Off | tap the inner-left thumb |
| Behavior | sticky NUM with no key held; Space types `0` |
| Combos inside | all off except `y`+`u` = Backspace |

## One-shot mods

| Layer | One-shot row |
|---|---|
| NUM, SYM, FUN | left home row `a` `s` `d` `f` = Gui Alt Shift Ctrl |
| NAV | right home row `j` `k` `l` `;` = Ctrl Shift Alt Gui |

Tap to arm for the next keypress; tap several to stack; hold to use as a
normal mod.

## What's remapped

| Platform | Keys | Untouched |
|---|---|---|
| win | 34 | F-row, number row, Tab, Caps Lock, Esc, Enter, Backspace, Shift, arrows, Delete, right Ctrl, Fn |
| mac | 46 — the 34 plus the F-row | number row, Tab, Caps Lock, Esc, Enter, Backspace, Shift, arrows, Delete, fn/Globe, right Opt |
| linux | 34 — the same set as win | F-row, number row, Tab, Caps Lock, Esc, Enter, Backspace, Shift, arrows, Delete, right Ctrl |

The 34 shared keys, identical on every platform:

| Physical key (win, linux / mac) | Tap | Hold |
|---|---|---|
| LWin / LOpt | Start menu / Spotlight · linux: Activities overview | — |
| LAlt / LCmd | Esc | NUM |
| RAlt / RCmd | Enter | NAV |
| `a s d f` / `j k l ;` | the letter | Gui Alt Shift Ctrl / Ctrl Shift Alt Gui |
| `z` / `/` | the letter / symbol | FUN |
| `x` / `.` | the letter / symbol | SYM |

## DE-specific aliases

The Linux configs assume **GNOME**. Four aliases are the only DE-dependent
lines — on another desktop, edit them in each distro's `kanata.kbd`.

| Alias | win | mac | linux (GNOME) | GNOME source |
|---|---|---|---|---|
| `overview` | `M-tab` | `C-up` | `lmet` — a bare Super tap opens the Activities overview | mutter `overlay-key` = `'Super'` |
| `minimize` | `M-down` | `M-m` | `M-h` | `org.gnome.desktop.wm.keybindings minimize` = `['<Super>h']` |
| `emoji` | `M-.` | `M-C-spc` | `C-.` | GTK `misc.insert-emoji` = Ctrl+period / Ctrl+semicolon |
| `screenshot` | `M-S-s` | `M-S-4` | `prnt` | `org.gnome.shell show-screenshot-ui` = `["Print"]` |

Every other alias matches the Windows file: `langtoggle` is `M-spc` on both
(GNOME `switch-input-source` = `['<Super>space']`), the swapper holds Alt
(GNOME `switch-applications` = `['<Super>Tab','<Alt>Tab']`), and the
Ctrl-based editing, word motion, and Home/End values are toolkit-level.

On **Cinnamon** (Linux Mint's default, and available on any of the four
distros) two of the four are unbound upstream — bind them yourself in
Keyboard settings, then point the alias at what you chose:

| Alias | GNOME | Cinnamon | Cinnamon source |
|---|---|---|---|
| `overview` | `lmet` | **unbound** — bind Expo or Scale | muffin `overlay-key` default `''` |
| `minimize` | `M-h` | **unbound** | cinnamon-desktop `minimize` default `[]` |
| `emoji` | `C-.` | `C-.` — works | GTK-level, not desktop-level |
| `screenshot` | `prnt` | `prnt` — works | cinnamon-desktop media-keys `screenshot` = `['Print']` |

Cinnamon's `switch-input-source` is also `['<Super>space']`, so `langtoggle`
needs no change.

On **KDE Plasma** (Manjaro's flagship, and available on any of the four
distros) four values differ — `setup.sh` applies these for you:

| Alias | GNOME | KDE Plasma | KDE source |
|---|---|---|---|
| `overview` | `lmet` | `M-w` — a bare Meta tap opens Kickoff, not an overview | KWin Overview effect = `Meta+W` |
| `minimize` | `M-h` | `M-pgdn` | KWin `Window Minimize` = `Meta+PgDown` |
| `emoji` | `C-.` | `M-.` — the Windows value | Emojier `X-KDE-Shortcuts=Meta+.` |
| `langtoggle` | `M-spc` | `M-A-k` | plasma-desktop layout switch = `Meta+Alt+K` |
| `screenshot` | `prnt` | `prnt` — works | Spectacle `X-KDE-Shortcuts=Print,Meta+Shift+S` |

`langtoggle` is a fifth alias that GNOME and Windows happen to share, so it
is absent from the four above — KDE is the case that breaks it, which also
takes the `b`+`n` combo with it until you change the line.

## After editing the config

Shared parts — layers, combos, templates, timings — change in ALL SIX files;
only the alias values, the `defsrc`/`plain` rows, and the mac F-row differ.
The four Linux files stay byte-identical to one another.

| Platform | Validate | Deploy to | Reload |
|---|---|---|---|
| win | `kanata.exe --cfg wins\kanata.kbd --check` | `%USERPROFILE%\kanata.kbd` | re-run `kanata.bat` |
| mac | `kanata --cfg mac/kanata.kbd --check` | `/etc/kanata/mac.kbd`, or re-run `mac/install.sh` | `sudo launchctl kickstart -k system/dev.kanata.kanata` |
| debian, fedora, arch | `kanata --cfg <distro>/kanata.kbd --check` | `~/.config/kanata/kanata.kbd`, or re-run that folder's `install.sh` | `systemctl --user restart kanata.service` |
| any OpenRC host | `kanata --cfg debian/kanata.kbd --check` | `~/.config/kanata/kanata.kbd`, or re-run `debian/install-openrc.sh` | `sudo rc-service kanata restart` |
| guix | `guix shell kanata -- kanata --cfg guix/kanata.kbd --check` | `sudo guix system reconfigure` | `sudo herd restart kanata-0` |

A config that fails `--check` never loads, so the running instance keeps
working.

## Tests

[shellspec](https://github.com/shellspec/shellspec) BDD specs cover every
script and the repo's own invariants — 155 examples.

```sh
curl -fsSL https://git.io/shellspec | sh -s -- --yes
shellspec
```

| Spec | Covers |
|---|---|
| `spec/setup_detection_spec.sh` | distro family from `ID`/`ID_LIKE` across 19 real identifiers, desktop from `XDG_CURRENT_DESKTOP`, WSL |
| `spec/setup_dispatch_spec.sh` | per-platform dispatch under `--dry-run`, and the KDE / Cinnamon alias patching |
| `spec/installers_spec.sh` | the version gate and `--version` parsing in all five installers, the OpenRC placeholder guard, the shipped unit and udev rule |
| `spec/config_spec.sh` | the four Linux configs are byte-identical, the win↔linux delta is exactly four aliases, every config passes `kanata --check` |
| `spec/policy_spec.sh` | GPL header on every file, license-only comments, LF against the CRLF launcher, executable bits, `sh -n` |

The `kanata --check` examples skip when no kanata binary is on `PATH`;
everything else runs anywhere. Scripts end with `${__SOURCED__:+return}` so
the specs can source them and test their functions without running `main`.

## Tuning knobs

Named `defvar`s at the top of each config — keep all six files in step.

| Knob | Controls |
|---|---|
| `tapping-term 300` | hold time that triggers a mod or layer |
| `require-prior-idle 250` | pause that re-arms the home row mods |
| `quick-tap-ms 200` | tap-then-hold repeat window |
| `one-shot-timeout 60000` | how long one-shots stay armed |
| `combo-timeout 60` | window for pressing a combo's keys together |
| `chords-v2-min-idle 350` (`defcfg`) | idle gate before combos fire |
| `mouse-*`, `wheel-*`, `slow-*` | pointer, scroll, and precision speeds |
| `double-tap-gap`, `multi-click-gap` | FUN double-mod and mouse multi-click macros |
| the ten `a`–`;` alias lines | mod order (plus each layer's `@osm @osa @oss @osc` row) |
| `macos-dev-names-include` (mac `defcfg`) | remap only specific keyboards |
| `linux-dev-names-include` (linux `defcfg`) | the same, on Linux — see also `linux-dev`, `linux-dev-names-exclude`, `linux-continue-if-no-devs-found` |

## Credits

- [urob's ZMK config](https://github.com/urob/zmk-config) — the timerless design
- sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/)
- [jtroo/kanata](https://github.com/jtroo/kanata)

## License

GPL-3.0-or-later. See [LICENSE](LICENSE) for the full text.
