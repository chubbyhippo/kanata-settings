# kanata-settings

A [kanata](https://github.com/jtroo/kanata) config with "timerless" home row
mods: type as fast as you want with zero misfires and zero letter reordering,
while keeping all four modifiers plus navigation, symbol, number, and
function layers on the home position. **One design, two configs** —
[`wins/kanata.kbd`](wins/kanata.kbd) for Windows (34 remapped keys) and
[`mac/kanata.kbd`](mac/kanata.kbd) for macOS (46 — its F-row carries the
printed Apple media functions). The layers, combos, and timings are
identical twins across the two files; this README documents the layout
once, with divergent cells annotated `win / mac`.

**The one rule:** while you're typing, the home row is just letters — mods
only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold
→ press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J).
Same-hand mod+letter never chords — use a one-shot or hold the mod a full
0.3 s first. (Exceptions: `d`/`k` keep their Shift hold and `f`/`j` their
Ctrl hold even mid-burst — Emacs C-n/C-p right after typing just works.)

**Reading this document.** Mod order is GASC — **Gui** Alt Shift Ctrl —
where *Gui* means the Win key on Windows and Cmd on macOS, and *Alt* means
Alt / Option. The three remapped thumbs are named by role:

| Thumb | Physical key (win / mac) | Tap | Hold |
|---|---|---|---|
| **outer-left** | LWin / LOpt | Start menu / Spotlight | (none) |
| **inner-left** | LAlt / LCmd | **Esc** | **NUM** |
| **right** | RAlt / RCmd | **Enter** | **NAV** |

Where a shortcut's underlying chord differs per OS it's written `win / mac`.

## Install

| OS | Guide |
|---|---|
| Windows | [wins/README.md](wins/README.md) — `kanata.kbd` + `katana.bat` into place, autostart, admin notes |
| macOS | [mac/README.md](mac/README.md) — Karabiner driver, `install.sh`, LaunchDaemons, permissions |

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold the inner-left thumb (NUM) + `c` / `v` / `x` / `z` |
| Ctrl chords (Emacs, terminal) | pause, then hold `f`/`j` (Ctrl) + a cross-hand key |
| App switcher (Alt-Tab / Cmd-Tab) | hold NAV (right thumb), tap `.` — keep tapping to cycle, `,` steps back — release NAV to switch |
| Minimize window | hold NAV: `c` (Win+Down — restores a maximized window first, tap twice / Cmd+M) |
| Windows overview (Task View / Mission Control) | hold NAV: `y` — on win, arrows + `h` then drive it |
| Enter | tap the right thumb · NAV `h` · or a physical Enter key |
| Close (Alt+F4 / Cmd+Q) | win: hold `z` (FUN), tap `s`, tap `j` (F4) · mac: NUM, tap `a` (one-shot Gui), release, `q` |
| Reopen tab (Ctrl/Cmd+Shift+T) | NUM (hold the inner-left thumb): tap `f` win / `a` mac, tap `d`, release, press `t` |
| Move word left / right | NAV: `a` = ← · `g` = → (Ctrl+←/→ / Opt+←/→) |
| Delete word forward / back | combo `f`+`g` = forward · `h`+`j` = back; or NAV: `v` / `z` |
| Select word left / right | NAV: tap `j`+`k` (Ctrl+Shift) win / `k`+`l` (Shift+Opt) mac, then `s`/`f` (←/→) |
| Type ( ) [ ] | SYM (hold `x`): `u`/`i`/`o`/`p` = `(` `)` `[` `]` |
| Home / End | FUN (hold `z`/`/`): `h` = Home · `e` = End |
| Line start / end | `v`+`b` / `m`+`n` (Home/End on win, ⌘←/⌘→ on mac) |
| Arrows (left, ESDF) | hold NAV (right thumb): `e`/`s`/`d`/`f` = ↑/←/↓/→ · `w`/`r` = Home/End |
| Mods + arrow (select / word-jump) | hold NAV, tap `j`/`k`/`l`/`;` = Ctrl/Shift/Alt/Gui, then an arrow (stacks); `i` = PgDn, `o` = PgUp |
| Next / previous tab | hold `f` (Ctrl), tap Tab — add Shift for previous |
| Tab / Backspace | combo `q`+`w` = Tab; hold NAV: `q` = Tab · `t` = Shift+Tab · `b` = Backspace; FUN (hold `/`): `t` = Tab · `b` = Backspace |
| Start menu / Spotlight | tap the outer-left thumb |
| Gui + any left-hand key (Win+E, Cmd+Q, …) | NUM: tap `a` (one-shot Gui), release, press the letter |
| Screenshot (Win+Shift+S / Cmd+Shift+4) | FUN (hold `/`): `x` |
| Emoji picker (Win+. / Cmd+Ctrl+Space) | FUN (hold `/`): `z` |
| Search Everywhere / Run Anything (IntelliJ) | FUN (hold `/`): `c` = double Shift · `v` = double Ctrl |
| Switch input language (Thai ⇄ English) | combo `b`+`n` — both index fingers together (Win+Space / Ctrl+Space) |
| Select text | hold real Shift + NAV arrows |
| Accents (é, ü, ñ…) — mac | right Opt is untouched — use it as stock |
| Type a number / amount | `m`+`,` → Num Word on; Space types 0; tap the inner-left thumb to exit |
| Backspace / Delete | combos `y·u` / `r·t`, or FUN `b` (Enter stays a physical key; Tab has `q·w`) |
| Media (audio) | FUN (hold `/`): `w` = reWind (prev) · `g` = Go (play/pause) · `n` = Next · `q` = Quiet (mute); vol down / up on the left thumbs |
| F-row media — brightness, Mission Control, keyboard backlight, volume (mac) | just press the printed key: the F-row keeps its Apple meanings (the config re-emits them — see the DEF map) |
| F-keys | hold `z` (FUN): right hand = F1–F12, in the same spots as NUM's digits — or the physical F-row, which types plain F1–F12 while FUN is held (on win it does bare, too) |
| Mouse | `z`+`x` toggles the mouse layer (tap `q` to exit): move `e s d f`, click `j`/`w`/`l`/`r` or Space, middle-click `,`/`t`, scroll `i`/`k` up/down · `u`/`o` left/right, back/forward `m`/`.`; double-click `p`, triple-click `/`; modifiers `y`/`h`/`n` = Ctrl/Shift/Alt; hold `a`/`;` = precision (slow) move |
| Caps Lock | the physical Caps Lock key, or FUN `y` (shoutY) |
| Esc | tap the inner-left thumb |
| Normal keyboard (lend laptop, games) | `q`+`w`+`e`+`r` together = plain mode; same to come back |
| Turn all combos off / on | `u`+`i`+`o`+`p` together = combos off (typing, mods, and layers still work); same to turn back on |
| Kill kanata entirely | hold physical `LCtrl + Space + Esc` |

## Layer maps

`os` = one-shot modifier (applies to the next key). On every keycap below,
**tap = top legend, hold = bottom legend**; a blank keycap does nothing on
that layer. *Gui* = Win / Cmd, *Alt* = Alt / Opt throughout.

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
  tap = top legend     hold = bottom legend

Thumbs:
+-------+-------+-------+-------+
|   ★   |  Esc  | Space | Enter |
|       |  NUM  |       |  NAV  |
+-------+-------+-------+-------+
 outer   inner   Space   right
```

`★` = Start menu (win) / Spotlight (mac). Physical thumbs: win
LWin·LAlt·Space·RAlt, mac LOpt·LCmd·Space·RCmd.

**F-row.** On win the F-row types F1–F12, exactly as stock. On mac it
carries its printed Apple functions — `F1`/`F2` brightness, `F3` Mission
Control, `F4` Launchpad, `F5`/`F6` keyboard backlight, `F7`–`F9`
previous / play-pause / next, `F10`–`F12` mute / vol− / vol+. kanata has to
re-emit these itself: its exclusive device grab sits below Apple's fn
translation, so an unmapped F-row would reach macOS as bare F1–F12 and the
media functions would be lost — this also means fn+F can't swap meanings
while kanata runs; hold FUN for plain F-keys instead. On a newer Mac whose
F4–F6 keycaps read Spotlight / Dictation / Do Not Disturb, swap
`lpad bldn blup` for `sls dtn dnd` in `mac/kanata.kbd`'s `fk4`–`fk6`
alias lines.

### NAV — hold the right thumb

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Tab  | Home  |  Up   |  End  | S-Tab |    | Ovrvw | Paste | PgDn  | PgUp  |  Del  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Wrd←  | Left  | Down  | Right | Wrd→  |    | Enter | osCtl | osSft | osAlt | osGui |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Dlw←  |  M-x  |  Min  | Dlw→  | Bksp  |    | Menu  |  M-m  | Swp←  | Swp→  |  M-/  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Space
```

Reach NAV by holding the **right thumb** (tap = Enter, hold = NAV). The
**left hand is an ESDF arrow cluster** — `e`/`s`/`d`/`f` = ↑ ← ↓ →, with
`w` = Home and `r` = End. The **right home row is one-shot mods** —
`j`/`k`/`l`/`;` = Ctrl / Shift / Alt / Gui; tap one (they stack), then an
ESDF arrow — e.g. `k` then `f` = Shift+→ to select. `i` = PgDn, `o` = PgUp,
`u` = Paste, `p` = Del; `y` = the windows overview (`Ovrvw`) — Task View
(Win+Tab) on win, where the ESDF arrows + `h` (Enter) then drive it, or
Mission Control (Ctrl+↑) on mac (which gives it little keyboard control —
pick with the pointer or a swipe); `h` = Enter (the thumb that usually taps
Enter is busy holding NAV). `c` = minimize the window (Win+Down — a
maximized window restores on the first tap, so tap twice / Cmd+M),
`z` / `v` = delete word back / forward (`Dlw`), `a` / `g` = move word
left / right (`Wrd`) — Ctrl+arrows on win, Opt+arrows on mac; `q` = Tab,
`t` = Shift+Tab, `b` = Backspace (left side); Esc is on the inner-left
thumb. `x` / `m` / `/` send Emacs **M-x** / **M-m** / **M-/** (dabbrev
autocomplete) — i.e. Alt+x / Alt+m / Alt+`/` (kanata's `M-` prefix is the
Gui key in this config, so Emacs Meta is spelled `A-`). `.` is the swapper
(`Swp`): kanata holds Alt (win) / Cmd (mac) for you and taps Tab, so keep
tapping `.` to walk the app switcher, tap `,` to step back, and release NAV
to drop the mod and land in the chosen window. Volume is on FUN (the two
left thumbs). `n` = Menu (the context-menu / Application key — Shift+F10 on
win; largely inert on stock macOS, kept for parity).

### SYM — hold `x` / `.`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   +   |   -   |   *   |   /   |   =   |    |   &   |   (   |   )   |   [   |   ]   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osGui | osAlt | osSft | osCtl |   $   |    |   #   |   {   |   }   |   '   |   "   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   `   |   ^   |   ~   |   %   |   @   |    |   |   |   \   |   ?   |   !   |   :   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = _  (underscore)
```

Every operator (`+ - * / =`) sits on the left top row and every bracket
(`( ) [ ] { }`) on the right hand, so each group is one-handed: hold SYM
with `.` to type operators with the left hand, or with `x` to type brackets
with the right. One-shot mods are on the left home row (`a s d f`),
matching NUM and FUN.

### NUM — hold the inner-left thumb

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   (   |   )   |   %   |   =   |   ^   |    |   +   |   7   |   8   |   9   |   *   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osGui | osAlt | osSft | osCtl | Bksp  |    |   -   |   4   |   5   |   6   |   /   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Undo  |  Cut  | Copy  | Paste | ,000  |    |   ,   |   1   |   2   |   3   |   .   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = 0     inner-left thumb:  tap = exit NUM  /  hold = SYM     right thumb:  tap = Enter  /  hold = NAV, as always
```

Ctrl+5 = `f` then `5`. `,000` is a typing macro. `z x c v` = Undo / Cut /
Copy / Paste (Ctrl+Z/X/C/V win, Cmd+Z/X/C/V mac). Space types **0** and
never exits. The right thumb keeps its everyday job — tap Enter, hold NAV —
so you can type an amount, hit Enter, and arrow to the next field without
ever leaving NUM. The inner-left thumb turns into the way out: tap to leave
NUM, or hold it for a stray symbol (SYM). Those left-thumb roles matter
when NUM is sticky from Num Word — if you're holding that thumb *for* NUM,
it's busy; just let go.

### FUN — hold `z` / `/`

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

Left thumbs = Vol− / Vol+   (Esc thumb / Space)
```

The left hand is the mnemonic cluster — `q` = **Q**uiet (mute), `w` =
re**W**ind (previous track), `e` = **E**nd, `r` = **R**eturn (Enter), `t` =
**T**ab, `g` = **G**o (play/pause), `b` = **B**ackspace — with volume
down / up on the two left thumbs (the Esc thumb and Space). The free
right-hand keys join in: `y` = shout**Y** (Caps Lock), `h` = **H**ome,
`n` = **N**ext track. F1–F12 sit on the right hand, on the same keys their
digits occupy in NUM — F1 on `m`, F5 on `k`, F9 on `o`, with F10–F12 down
the pinky column (`p` `;` `/`). A region screenshot (Win+Shift+S /
Cmd+Shift+4) is on `x`, the emoji picker (Win+. / Cmd+Ctrl+Space) on `z`,
and `c` / `v` tap Shift / Ctrl twice for you — IntelliJ's Search Everywhere
and Run Anything. So hold FUN with `z` for the right-hand F-keys, or with
the right pinky (`/`) for the left-hand mnemonics. While FUN is held, the
physical F-row also types plain F1–F12 — on mac that's the way to reach
real F-keys, since the bare F-row carries the Apple media functions (see
the DEF map) and fn+F can't swap meanings under kanata (the fn/Globe key
itself stays untouched).

### MOUSE — toggle with `z`+`x` (tap `q` to exit)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Exit  | LClk  |  Up   | RClk  | MClk  |    | Ctrl  | ScrLt | ScrUp | ScrRt | DClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prec  | Left  | Down  | Right |       |    | Shift | LClk  | ScrDn | RClk  | Prec  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Gui  |  Alt  | Shift | Ctrl  |       |    |  Alt  | Back  | MClk  | Fwd   | TClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
```

A sticky layer: press `z`+`x` to enter; tap `q` to leave. Move the cursor
with the **left hand** (ESDF): `e` up, `s` left, `d` down, `f` right —
accelerates while held. The **right hand** clicks and scrolls: `j`
left-click, `l` right-click, `i` scroll up, `k` scroll down, `u` scroll
left, `o` scroll right. **Middle-click** is on `,`, with **browser
back/forward** on `m`/`.`; **Space** is also left-click. Additional click
aliases on the top row: `w` = left-click, `r` = right-click, `t` =
middle-click. The right pinky has **`p` = double-click** and **`/` =
triple-click** (each fires as one macro, so the OS always registers a real
multi-click). The right-hand inner column **`y` `h` `n` = Ctrl, Shift,
Alt** — hold one with the right hand while the left hand keeps moving on
ESDF, then click with **Space** (right thumb) for modifier+drag, e.g.
Shift-drag to select. The bottom-row keys **`z` `x` `c` `v` = Gui, Alt,
Shift, Ctrl** mirror the same modifiers on the left hand, and the thumbs
add **Ctrl (inner-left) / Alt (right)** — so you can Shift-click to extend
a selection, Ctrl/Cmd-click to multi-select, or Ctrl-scroll to zoom.
**Hold `a`** (left pinky) or **`;`** (right pinky) for **precision mode**:
the cursor crawls in slow constant steps for fine positioning; release to
restore normal speed. Tap **`q`** to exit the layer in one key. Every combo
is disabled inside this layer (and in precision mode), so two-key presses
never misfire.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are
disabled during fast typing. Inside the NUM layer every combo is off except
`y·u` = Backspace, so typing numbers never misfires.

The home row (`a`–`;`) is otherwise mods-only, but its two index-finger
pairs carry the delete-word combos — `f`+`g` and `h`+`j` (same-finger, so
misfire-proof). The rest live on the top and bottom rows — including the
one *cross-hand* pair, `b`+`n` (the two center bottom-row keys, one index
finger each), for switching the input language:

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

A `└─┘` spans the keys you press; an interior `┴` tick marks a middle key
that's *also* part of the combo (so `Plain` = Q·W·E·R and `NoCmb` =
U·I·O·P); every other span is just its two neighbouring keys. `Lang`
bridges the hand gap in the picture, but `b` and `n` are physical
neighbours — one index finger each, pressed together.

`Tab` Tab · `Del` forward delete · `Bsp` Backspace · `Mouse` mouse layer ·
`Lang` switch input language (Win+Space / Ctrl+Space) · `Line←`/`Line→`
line start / end (Home/End win, ⌘←/⌘→ mac) · `DelF`/`DelB` delete word
forward / back · `Num` Num Word · `Plain` plain mode · `NoCmb` all-combos
toggle.

| Combo | Result |
|---|---|
| `q w` | Tab |
| `r t` | Forward delete (same-finger) |
| `y u` | Backspace (same-finger; also active in NUM) |
| `f g` / `h j` | Delete word forward / back — Ctrl+Del / Ctrl+Bksp (win), Opt+Del / Opt+Bksp (mac) |
| `v b` / `m n` | Line start / end — Home / End (win), ⌘← / ⌘→ (mac) |
| `b n` | Switch input language — Win+Space / Ctrl+Space (cross-hand pair, one index finger each) |
| `m ,` | Num Word on (tap the inner-left thumb to cancel) |
| `z x` | Mouse layer on/off (tap `q` to exit) |
| `q w e r` | Plain mode on/off (the one combo still live in plain) |
| `u i o p` | All combos on/off |

**Master toggle:** `u`+`i`+`o`+`p` silences every combo above at once
(press it again to bring them back) — handy for games or apps with their
own chord shortcuts. Home row mods, layers, and one-shots keep working;
only the two-key combos go quiet. It mirrors the `q`+`w`+`e`+`r` plain-mode
toggle, and it's the one combo that stays live while combos are off, so you
can always switch back. Under the hood it drops you into a `nocombo` layer
(a clone of DEF that's listed in every combo's disabled-layers).

## One-shot mods

NUM, SYM, and FUN all have `osGui osAlt osSft osCtl` on the **left** home
row (`a s d f`); NAV mirrors them on the **right** home row instead
(`j k l ;` = Ctrl Shift Alt Gui), since its left hand is the arrow cluster.
**Tap** one → applies to your next keypress only; tap several to stack;
hold to use as a normal mod. Armed up to 60 s, and they survive releasing
the layer key. This is the answer to every "mod + same-hand key": Win+E /
Cmd+Q = NUM → tap `a` → release → the letter. Alt+F4 (win) = hold `z` →
tap `s` → tap `j`. Cmd+Shift+4 (mac) = NUM → tap `a`, tap `d`, press `j`.

## Num Word

**Num Word** (`m`+`,`): sticky NUM layer, no key held. Space types a **0**
and stays on; tap the inner-left thumb to cancel. The combo only turns it
on (it's disabled inside NUM), so typing digits like 12 can't trip it.
Inside NUM, every combo is disabled **except `y·u` = Backspace**, so you
can fix typos while entering numbers.

## What's remapped

win remaps **34 keys**, mac **46** — the same 34 plus the F-row.

### win — 34 keys

The F-row, number row, Tab, Caps Lock, Esc, Enter, Backspace, Shift,
arrows, and Delete are untouched — plus right Ctrl and Fn. The F-row
types F1–F12 exactly as stock (it's mapped straight through), and the
laptop's own Fn media combos keep working — they're handled below the
keyboard stream kanata hooks.

### mac — 46 keys

The 34 shared keys plus the twelve F-row keys, remapped to their printed
Apple functions — brightness, Mission Control, Launchpad, keyboard
backlight, transport, mute/volume (see the DEF map; hold FUN for plain
F1–F12). Number row, Tab, Caps Lock, Esc, Enter, Backspace, Shift,
arrows, and Delete are untouched — plus fn/Globe and right Opt (accents).

The 34 shared keys, identical on both platforms:

| Physical key (win / mac) | Tap | Hold |
|---|---|---|
| LWin / LOpt | Start menu / Spotlight | (none) |
| LAlt / LCmd | **Esc** | **NUM** |
| RAlt / RCmd | **Enter** | **NAV** |
| `a s d f` / `j k l ;` | the letter | Gui Alt Shift Ctrl / Ctrl Shift Alt Gui |
| `z` / `/` | the letter / symbol | **FUN** |
| `x` / `.` | the letter / symbol | **SYM** |

## After editing the config

Edit the platform's file — `wins/kanata.kbd` or `mac/kanata.kbd` — and run
`kanata --cfg <file> --check` first: a config that fails the check won't
load, so the running instance keeps working. Then copy the file to where
the launcher reads it — `%USERPROFILE%\kanata.kbd` (win) or
`/etc/kanata/mac.kbd` (mac) — and restart kanata to apply: re-run
`kanata.bat` (win) or
`sudo launchctl kickstart -k system/dev.kanata.kanata` (mac). The two files
share one design — a change to the layers, combos, templates, or timings
lands in BOTH, kept line-comparable on purpose; only the alias values, the
`defsrc`/`plain` rows, and the mac F-row differ.

## Troubleshooting

- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold.
  Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and
  Ctrl on `f`/`j` work even without the pause.)
- **"The Start menu / Spotlight pops up randomly."** You held `a` and
  released it with no other key — that's a Gui tap. Press Esc.
- **"How do I Alt-Tab / Cmd-Tab?"** Hold NAV (the right thumb) and tap
  `.` — kanata holds the mod for you, every tap is another Tab, `,` steps
  back, and releasing NAV commits. Holding the home-row mod + a physical
  Tab still works too.
- **"Config won't load after an edit."** `--check` tells you the line. A
  config that fails the check won't start, so the previously running
  instance keeps working until you restart.
- Platform-specific issues (admin windows, the Karabiner driver, macOS
  permissions) live in the [install guides](#install).

## Tuning knobs

Everything tunable is a named `defvar` at the top of each config
(`wins/kanata.kbd`, `mac/kanata.kbd` — keep the two in step):

- `tapping-term 300` — lower = mods trigger faster when held, slightly
  higher misfire risk
- `require-prior-idle 250` — how long a pause re-arms the mods
- `one-shot-timeout 60000` — how long one-shots stay armed
- `chords-v2-min-idle 350` — lower if combos need too long a pause
- `mouse-*`, `wheel-*`, `slow-*` — pointer/scroll speeds; `double-tap-gap`,
  `multi-click-gap` — the FUN double-mods and mouse multi-click macros
- Mod order: edit the ten `a`–`;` alias lines (and the `@osm @osa @oss
  @osc` rows in each layer)
- mac: remap only specific keyboards by adding
  `macos-dev-names-include` to `mac/kanata.kbd`'s `defcfg`

## Credits

[urob's ZMK config](https://github.com/urob/zmk-config) (the timerless
design), sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/),
and [jtroo/kanata](https://github.com/jtroo/kanata) itself.

## License

GPL-3.0-or-later. See [LICENSE](LICENSE) for the full text.
