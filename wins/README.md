# kanata — Windows setup (config: ../kanata.kbd, shared with macOS)

A [kanata](https://github.com/jtroo/kanata) config for Windows with "timerless" home row mods: type as fast as you want with zero misfires and zero letter reordering, while keeping all four modifiers plus navigation, symbol, number, and function layers on the home position.

**The one rule:** while you're typing, the home row is just letters — mods only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold → press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J). Same-hand mod+letter never chords — use a one-shot or hold the mod a full 0.3 s first. (Exceptions: `d`/`k` keep their Shift hold and `f`/`j` their Ctrl hold even mid-burst.)

## Install

Needs `kanata.exe` (v1.11.0+, [releases](https://github.com/jtroo/kanata/releases)) on your PATH. Then:

```powershell
# config → %USERPROFILE%
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/kanata.kbd" -OutFile "$Home\kanata.kbd"
```

```powershell
# launcher → Startup folder (starts kanata silently at every login)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/katana.bat" -OutFile "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\kanata.bat"
```

Run the downloaded `kanata.bat` once (or log off/on), then test: hold left Alt + `c` → Ctrl+C (NUM), and hold the **right thumb** + `e` → ↑ (its tap = Enter, hold = NAV).

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold LAlt thumb (NUM) + `c` / `v` / `x` / `z` |
| Alt+Tab | hold NAV (right thumb), tap `.` — keep tapping to cycle, `,` steps back — release NAV to switch |
| Minimize window | hold NAV: `c` (Win+Down — a maximized window restores first, tap twice) |
| Task View (all windows) | hold NAV: `y` (Win+Tab), then arrows + `h` to pick |
| Enter | tap the right thumb · NAV `h` · or a physical Enter key |
| Close window (Alt+F4) | hold `z` (FUN), tap `s` (one-shot Alt), tap `j` (F4) |
| Reopen tab (Ctrl+Shift+T) | NUM (hold the left Alt thumb): tap `f`, tap `d`, release, press `t` |
| Move word left / right | NAV (hold the right thumb): `a` = ← · `g` = → (Ctrl+←/→) |
| Delete word forward / back | combo `f`+`g` = forward · `h`+`j` = back (Ctrl+Del / Ctrl+Bksp); or NAV: `v` / `z` |
| Select word left / right | NAV: tap `j`+`k` (Ctrl+Shift), then `s`/`f` (←/→) |
| Type ( ) [ ] | SYM (hold `x`): `u`/`i`/`o`/`p` = `(` `)` `[` `]` |
| Home / End | `v`+`b` = Home · `m`+`n` = End · FUN (hold `z`/`/`): `h` = Home, `e` = End |
| Arrows (left, ESDF) | hold NAV (right thumb): `e`/`s`/`d`/`f` = ↑/←/↓/→ · `w`/`r` = Home/End |
| Mods + arrow (select / word-jump) | hold NAV, tap `j`/`k`/`l`/`;` = Ctrl/Shift/Alt/Win, then an arrow (stacks); `i` = PgDn, `o` = PgUp |
| Next / previous tab | hold `f` (Ctrl), tap Tab — add Shift for previous |
| Tab / Backspace | hold NAV: `q` = Tab · `t` = Shift+Tab · `b` = Backspace; FUN (hold `/`): `t` = Tab · `b` = Backspace |
| Arrows, PgUp/PgDn, Home/End | hold the **right thumb** (NAV) |
| Start menu | tap left Win |
| Win+E, Win+R, Win+D… | NUM: tap `a` (one-shot Win), release, press the letter |
| Screenshot (Win+Shift+S) | FUN (hold `/`): `x`; or NUM: tap `a`, tap `d`, release, press `s` |
| Emoji picker | FUN (hold `/`): `z` (Win+.) |
| Search Everywhere / Run Anything (IntelliJ) | FUN (hold `/`): `c` = double Shift · `v` = double Ctrl |
| Switch input language (Thai ⇄ English) | combo `t`+`g` — one flat left-index press (Win+Space) |
| Select text | hold real Shift + NAV arrows |
| Type a number / amount | `m`+`,` → Num Word on; Space types 0; tap the left Alt thumb to exit |
| Backspace / Delete | combos `y·u` / `r·t`, or FUN `b` (Tab and Enter are physical keys) |
| Media (audio) | FUN (hold `/`): `w` = reWind (prev) · `g` = Go (play/pause) · `n` = Next · `q` = Quiet (mute); vol down / up on the left thumbs |
| F-keys | hold `z` (FUN): right hand = F1–F12, in the same spots as NUM's digits |
| Mouse | `q`+`w` toggles the mouse layer (tap `q` to exit): move `e s d f`, click `j`/`w`/`l`/`r` or Space, middle-click `,`/`t`, scroll `i`/`k` up/down · `u`/`o` left/right, back/forward `m`/`.`; double-click `p`, triple-click `/`; modifiers `y`/`h`/`n` = Ctrl/Shift/Alt; hold `a`/`;` = precision (slow) move |
| Caps Lock | the physical Caps Lock key, or FUN `y` (shoutY) |
| Esc | tap the left Alt thumb |
| Normal keyboard (lend laptop, games) | `q`+`w`+`e`+`r` together = plain mode; same to come back |
| Turn all combos off / on | `u`+`i`+`o`+`p` together = combos off (typing, mods, and layers still work); same to turn back on |
| Kill kanata entirely | hold physical `LCtrl + Space + Esc` |

## Layer maps

`os` = one-shot modifier (applies to the next key). On every keycap below, **tap = top legend, hold = bottom legend**; a blank keycap does nothing on that layer.

### DEF — base layer

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   Q   |   W   |   E   |   R   |   T   |    |   Y   |   U   |   I   |   O   |   P   |
|       |       |       |       |       |    |       |       |       |       |       |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   A   |   S   |   D   |   F   |   G   |    |   H   |   J   |   K   |   L   |   ;   |
|  Win  |  Alt  |  Sft  |  Ctl  |       |    |       |  Ctl  |  Sft  |  Alt  |  Win  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   Z   |   X   |   C   |   V   |   B   |    |   N   |   M   |   ,   |   .   |   /   |
|  FUN  |  SYM  |       |       |       |    |       |       |       |  SYM  |  FUN  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
  tap = top legend     hold = bottom legend

Thumbs:
+-------+-------+-------+-------+
|  Win  |  Esc  | Space | Enter |
|       |  NUM  |       |  NAV  |
+-------+-------+-------+-------+
  LWin    LAlt    Space   RAlt  
```

### NAV — hold the right thumb

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Tab  | Home  |  Up   |  End  | S-Tab |    | TskVw | Paste | PgDn  | PgUp  |  Del  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Wrd←  | Left  | Down  | Right | Wrd→  |    | Enter | osCtl | osSft | osAlt | osWin |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Dlw←  |  M-x  |  Min  | Dlw→  | Bksp  |    | Menu  |  M-m  | Win←  | Win→  |  M-/  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Space
```

Reach NAV by holding the **right thumb** (tap = Enter, hold = NAV). The **left hand is an ESDF arrow cluster** — `e`/`s`/`d`/`f` = ↑ ← ↓ →, with `w` = Home and `r` = End. The **right home row is one-shot mods** — `j`/`k`/`l`/`;` = Ctrl / Shift / Alt / Win; tap one (they stack), then an ESDF arrow — e.g. `k` then `f` = Shift+→ to select, `j` then `s` = Ctrl+← to jump a word left. `i` = PgDn, `o` = PgUp, `u` = Paste, `p` = Del; `y` = Task View (Win+Tab) — the all-windows overview, and since NAV stays held you can walk it with the ESDF arrows and land with `h` (Enter); `h` = Enter (the thumb that usually taps Enter is busy holding NAV). `c` = minimize the window (Win+Down — a maximized window restores on the first tap, so tap twice), `z` / `v` = delete word back / forward (Ctrl+Bksp / Ctrl+Del), Paste is on `u` (for copy use NUM `c`, or the `j` one-shot then `c`); `a` / `g` = move word left / right (Ctrl+← / Ctrl+→); `q` = Tab, `t` = Shift+Tab, `b` = Backspace (left side); Esc is on the left thumb. `x` / `m` / `/` send Emacs **M-x** / **M-m** / **M-/** (dabbrev autocomplete) — i.e. Alt+x / Alt+m / Alt+`/` (kanata's `M-` is Win in this config, so Emacs Meta uses `A-`). `.` is the window swapper: kanata holds Alt for you and taps Tab, so keep tapping `.` to walk the Alt-Tab switcher, tap `,` to step back (Alt+Shift+Tab), and release NAV to drop Alt and land in the chosen window. Volume is on FUN (the two left thumbs). `n` = Menu (the context-menu / Application key — same as Shift+F10).

### SYM — hold `x` / `.`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   +   |   -   |   *   |   /   |   =   |    |   &   |   (   |   )   |   [   |   ]   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osWin | osAlt | osSft | osCtl |   $   |    |   #   |   {   |   }   |   '   |   "   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   `   |   ^   |   ~   |   %   |   @   |    |   |   |   \   |   ?   |   !   |   :   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = _  (underscore)
```

Every operator (`+ - * / =`) sits on the left top row and every bracket (`( ) [ ] { }`) on the right hand, so each group is one-handed: hold SYM with `.` to type operators with the left hand, or with `x` to type brackets with the right. One-shot mods are on the left home row (`a s d f`), matching NUM and FUN.

### NUM — hold the left Alt thumb

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   (   |   )   |   %   |   =   |   ^   |    |   +   |   7   |   8   |   9   |   *   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osWin | osAlt | osSft | osCtl | Bksp  |    |   -   |   4   |   5   |   6   |   /   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Undo  |  Cut  | Copy  | Paste | ,000  |    |   ,   |   1   |   2   |   3   |   .   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = 0     left Alt thumb:  tap = exit NUM  /  hold = SYM     right thumb:  tap = Enter  /  hold = NAV, as always
```

Ctrl+5 = `f` then `5`. `,000` is a typing macro. `z x c v` = Undo / Cut / Copy / Paste (Ctrl+Z/X/C/V). Space types **0** and never exits. The right thumb keeps its everyday job — tap Enter, hold NAV — so you can type an amount, hit Enter, and arrow to the next field without ever leaving NUM. The left Alt thumb turns into the way out: tap to leave NUM, or hold it for a stray symbol (SYM). Those left-thumb roles matter when NUM is sticky from Num Word — if you're holding that thumb *for* NUM, it's busy; just let go.

### FUN — hold `z` / `/`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Quiet | reWind|  End  | Return|  Tab  |    | shoutY|  F7   |  F8   |  F9   |  F10  |
| mute  | prev  |       | enter |       |    |  Caps |       |       |       |       |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osWin | osAlt | osSft | osCtl |  Go   |    |  Home |  F4   |  F5   |  F6   |  F11  |
|       |       |       |       |  play |    |       |       |       |       |       |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Emoji | Shot  | 2×Sft | 2×Ctl |  Bksp |    |  Next |  F1   |  F2   |  F3   |  F12  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Left thumbs = Vol− / Vol+   (Esc thumb / Space)
```

The left hand is the mnemonic cluster — `q` = **Q**uiet (mute), `w` = re**W**ind (previous track), `e` = **E**nd, `r` = **R**eturn (Enter), `t` = **T**ab, `g` = **G**o (play/pause), `b` = **B**ackspace — with volume down / up on the two left thumbs (the Esc thumb and Space). The free right-hand keys join in: `y` = shout**Y** (Caps Lock), `h` = **H**ome, `n` = **N**ext track. F1–F12 sit on the right hand, on the same keys their digits occupy in NUM — F1 on `m`, F5 on `k`, F9 on `o`, with F10–F12 down the pinky column (`p` `;` `/`). A region screenshot (Win+Shift+S) is on `x`, the emoji picker (Win+.) on `z`, and `c` / `v` tap Shift / Ctrl twice for you — IntelliJ's Search Everywhere and Run Anything. So hold FUN with `z` for the right-hand F-keys, or with the right pinky (`/`) for the left-hand mnemonics.

### MOUSE — toggle with `q`+`w` (tap `q` to exit)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Exit  | LClk  |  Up   | RClk  | MClk  |    | Ctrl  | ScrLt | ScrUp | ScrRt | DClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prec  | Left  | Down  | Right |       |    | Shift | LClk  | ScrDn | RClk  | Prec  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Win  |  Alt  | Shift | Ctrl  |       |    |  Alt  | Back  | MClk  | Fwd   | TClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
```

A sticky layer: press `q`+`w` to enter; tap `q` to leave. Move the cursor with the **left hand** (ESDF): `e` up, `s` left, `d` down, `f` right — accelerates while held. The **right hand** clicks and scrolls: `j` left-click, `l` right-click, `i` scroll up, `k` scroll down, `u` scroll left, `o` scroll right. **Middle-click** is on `,`, with **browser back/forward** on `m`/`.`; **Space** is also left-click. Additional click aliases on the top row: `w` = left-click, `r` = right-click, `t` = middle-click. The right pinky has **`p` = double-click** and **`/` = triple-click** (each fires as one macro, so the OS always registers a real multi-click). The right-hand inner column **`y` `h` `n` = Ctrl, Shift, Alt** — hold one with the right hand while the left hand keeps moving on ESDF, then click with **Space** (right thumb) for modifier+drag, e.g. Shift-drag to select. The bottom-row keys **`z` `x` `c` `v` = Win, Alt, Shift, Ctrl** mirror the same modifiers on the left hand, and the thumbs add **Ctrl (left `LAlt`) / Alt (right `RAlt`)** — so you can Shift-click to extend a selection, Ctrl-click to multi-select, Alt-click, or Ctrl-scroll to zoom. **Hold `a`** (left pinky) or **`;`** (right pinky) for **precision mode**: the cursor crawls in 1px steps for fine positioning; release to restore normal speed. Tap **`q`** to exit the layer in one key. Every combo is disabled inside this layer (and in precision mode), so two-key presses never misfire.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing. Inside the NUM layer every combo is off except `y·u` = Backspace, so typing numbers never misfires.

The home row (`a`–`;`) is otherwise mods-only, but its two index-finger pairs now carry the delete-word combos — `f`+`g` and `h`+`j` (same-finger, so misfire-proof). The rest live on the top and bottom rows — plus one *vertical* pair, `t`+`g` (top+home, one flat left-index press), for switching the input language:

```
NEIGHBOUR COMBOS  —  press two (or more) touching keys

   Q     W     E     R     T             Y     U     I     O     P
   └Mouse┘           └─Del─┘             └─Bsp─┘
   └─────┴Plain┴─────┘                         └─────┴NoCmb┴─────┘
                           │Lang
   A     S     D     F     G             H     J     K     L     ;
                     └DelF─┘             └DelB─┘

   Z     X     C     V     B             N     M     ,     .     /
                     └Home─┘             └─End─┘
                                               └─Num─┘
```

A `└─┘` spans the keys you press; an interior `┴` tick marks a middle key that's *also* part of the combo (so `Plain` = Q·W·E·R and `NoCmb` = U·I·O·P); every other span is just its two neighbouring keys. The `│` between T and G marks the one vertical pair — both keys under the same finger, pressed together flat.

`Mouse` mouse layer · `Del` forward delete · `Bsp` Backspace · `Lang` switch input language (Win+Space) · `DelF`/`DelB` delete word forward / back · `Home`/`End` Home / End · `Num` Num Word · `Plain` plain mode · `NoCmb` all-combos toggle.

| Combo | Result |
|---|---|
| `q w` | Mouse layer on/off (tap `q` to exit) |
| `r t` | Forward delete (same-finger) |
| `y u` | Backspace (same-finger; also active in NUM) |
| `f g` / `h j` | Delete word forward / back — Ctrl+Del / Ctrl+Bksp (home row, same-finger) |
| `t g` | Switch input language — Win+Space (vertical same-finger pair, left index) |
| `v b` / `m n` | Home / End (bottom row, same-finger) |
| `m ,` | Num Word on (tap the left Alt thumb to cancel) |
| `q w e r` | Plain mode on/off (the one combo still live in plain) |
| `u i o p` | All combos on/off |

**Master toggle:** `u`+`i`+`o`+`p` silences every combo above at once (press it again to bring them back) — handy for games or apps with their own chord shortcuts. Home row mods, layers, and one-shots keep working; only the two-key combos go quiet. It mirrors the `q`+`w`+`e`+`r` plain-mode toggle, and it's the one combo that stays live while combos are off, so you can always switch back. Under the hood it drops you into a `nocombo` layer (a clone of DEF that's listed in every combo's disabled-layers).

## One-shot mods

NUM, SYM, and FUN all have `osWin osAlt osSft osCtl` on the **left** home row (`a s d f`); NAV mirrors them on the **right** home row instead (`j k l ;` = Ctrl Shift Alt Win), since its left hand is the arrow cluster. **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Win+E = NUM → tap `a` → release → `e`. Alt+F4 = hold `z` → tap `s` → tap `j`.

## Num Word

**Num Word** (`m`+`,`): sticky NUM layer, no key held. Space types a **0** and stays on; tap the left Alt thumb to cancel. The combo only turns it on (it's disabled inside NUM), so typing digits like 12 can't trip it. Inside NUM, every combo is disabled **except `y·u` = Backspace**, so you can fix typos while entering numbers.

## Quick start

Needs Windows 10/11 and **kanata v1.11.0+** ([releases](https://github.com/jtroo/kanata/releases)).

1. Validate: `kanata.exe --cfg kanata.kbd --check`
2. Run: `kanata.exe --cfg kanata.kbd` — **as administrator** if you want remaps inside elevated apps
3. Test: hold left Alt + `c` → Ctrl+C; hold the **right thumb** + `e` → ↑ (NAV); tap the left Alt thumb → Esc, the right thumb → Enter.

**Autostart:** covered by the [Install](#install) section's `kanata.bat`. If you want it elevated (remaps in admin apps) without a UAC prompt, use Task Scheduler instead: trigger "At log on", check "Run with highest privileges".

**After editing the config:** run `--check`, then restart kanata to apply (stop it and re-run `kanata.bat`, or end the process and relaunch). A config that fails `--check` won't load, so the previous good one keeps running.

## What's remapped

Only 34 keys. Number row, F-row, Tab, Caps Lock, Esc, Enter, Backspace, Shift, arrows, Delete, right Ctrl, and Fn are untouched.

| Physical key | Tap | Hold |
|---|---|---|
| Left Win | Win (Start menu) | (none) |
| Left Alt | **Esc** | **NUM** |
| Right Alt | **Enter** | **NAV** |
| `a s d f` / `j k l ;` | the letter | Win Alt Shift Ctrl / Ctrl Shift Alt Win |
| `z` / `/` | the letter / symbol | **FUN** |
| `x` / `.` | the letter / symbol | **SYM** |

## Troubleshooting

- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Start menu pops up randomly."** You held `a` and released it with no other key — that's a Win tap. Press Esc.
- **"How do I Alt+Tab?"** Hold NAV (the right thumb) and tap `.` — kanata holds Alt for you, every tap is another Tab, `,` steps back, and releasing NAV commits. Holding `s` (Alt) + a physical Tab still works too.
- **"Remaps don't work in Task Manager / admin windows."** Run kanata as administrator.
- **"Config won't load after an edit."** `--check` tells you the line. A config that fails the check won't start, so the previously running instance keeps working until you restart.

## Tuning knobs

In the `defvar` block:

- `tapping-term 300` — lower = mods trigger faster when held, slightly higher misfire risk
- `require-prior-idle 250` — how long a pause re-arms the mods
- `one-shot-timeout 60000` — how long one-shots stay armed
- `chords-v2-min-idle 350` — lower if combos need too long a pause
- Mod order: edit the ten `a`–`;` alias lines (and the `@osm @osa @oss @osc` rows in each layer)

## Credits

[urob's ZMK config](https://github.com/urob/zmk-config) (the timerless design), sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/), and [jtroo/kanata](https://github.com/jtroo/kanata) itself.
