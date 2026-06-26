# wins.kbd — Windows kanata config

A [kanata](https://github.com/jtroo/kanata) config for Windows with "timerless" home row mods: type as fast as you want with zero misfires and zero letter reordering, while keeping all four modifiers plus navigation, symbol, number, and function layers on the home position.

**The one rule:** while you're typing, the home row is just letters — mods only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold → press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J). Same-hand mod+letter never chords — use a one-shot or hold the mod a full 0.3 s first. (Exceptions: `d`/`k` keep their Shift hold and `f`/`j` their Ctrl hold even mid-burst.)

## Install

Needs `kanata.exe` (v1.10.1+, [releases](https://github.com/jtroo/kanata/releases)) on your PATH. Then:

```powershell
# config → %USERPROFILE%
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/wins.kbd" -OutFile "$Home\wins.kbd"
```

```powershell
# launcher → Startup folder (starts kanata silently at every login)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/katana.bat" -OutFile "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\kanata.bat"
```

Run the downloaded `kanata.bat` once (or log off/on), then test: hold left Alt + `c` → Ctrl+C (left Alt is Ctrl now), and hold `x` + `k` → ↑ (NAV).

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold left Alt (= Ctrl) + `c` / `v` / `x` / `z` |
| Alt+Tab | hold right Alt + Tab, release to switch (it's a real Alt now) |
| Close window (Alt+F4) | hold `z` (FUN), tap `s` (one-shot Alt), tap `j` (F4) |
| Reopen tab (Ctrl+Shift+T) | NUM (hold `c`/`,`): tap `f`, tap `d`, release, press `t` |
| Move word left / right | `j`+`k` = Ctrl+← · `d`+`f` = Ctrl+→ |
| Select word left / right | `h`+`j` = Shift+Ctrl+← · `f`+`g` = Shift+Ctrl+→ |
| Delete word forward / back | `s`+`d` = Ctrl+Del · `k`+`l` = Ctrl+Bksp |
| Undo / Redo | `s`+`f` = Ctrl+Z · `j`+`l` = Ctrl+Shift+Z |
| Cut / Copy / Paste (combo) | `z`+`x` = Cut · `x`+`c` = Copy · `c`+`v` = Paste |
| Type + - * | `u`+`j` = + · `i`+`k` = - · `o`+`l` = * |
| Emacs-style arrows | hold `x` / `.` (NAV): `n`/`p`/`f`/`b` = ↓/↑/→/← · `a`/`e` = Home/End |
| Vim-style arrows | hold `x` / `.` (NAV): `h`/`j`/`k`/`l` = ←/↓/↑/→ · `d`/`u` = PgDn/PgUp |
| Next / previous browser tab | hold `x` / `.` (NAV) + `r` / hold `f` (Ctrl) + Shift, tap Tab |
| Browser back / forward | hold `x` / `.` (NAV) + `g` / `t` |
| Arrows, PgUp/PgDn, Home/End | hold `x` / `.` (NAV) |
| Start menu | tap left Win |
| Win+E, Win+R, Win+D… | NUM: tap `a` (one-shot Win), release, press the letter |
| Screenshot (Win+Shift+S) | FUN (hold `/`): `x`; or NUM: tap `a`, tap `d`, release, press `s` |
| Emoji picker | FUN (hold `/`): `z` (Win+.) |
| Select text | hold real Shift + NAV arrows |
| Type ALL_CAPS | `d`+`k` together → Caps Word; Space or a digit ends it |
| Type a number / amount | `m`+`,` → Num Word on; Space types 0; tap the Ctrl thumb to exit |
| Esc / Tab / Enter / Backspace / Delete | combos `q·w` / `a·s·d` / `l·;` / `u·i` / `r·t` |
| Save / Select all / Find | combos `w·s` / `q·a` / `r·f` |
| Media (audio) | FUN (hold `/`): `q` `w` `e` = prev · play/pause · next; `r` `t` = vol down · up; mute on `g` |
| F-keys | hold `z` (FUN): right hand = F1–F12, in the same spots as NUM's digits |
| Mouse | `x`+`v` toggles the mouse layer (`x`+`v` again or `q` exits): move `e s d f`, click `j`/`w`/`l`/`r` or Space, middle-click `,`/`t`, scroll `i`/`k` up/down · `u`/`o` left/right, back/forward `m`/`.`; double-click `p`, triple-click `/`; modifiers `y`/`h`/`n` = Ctrl/Shift/Alt; hold `a`/`;` = precision (slow) move |
| Caps Lock | the physical Caps Lock key, or FUN layer + Space |
| Esc | tap the left Alt thumb (or the `q`+`w` combo) |
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
|  FUN  |  NAV  |  NUM  |  SYM  |       |    |       |  SYM  |  NUM  |  NAV  |  FUN  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
  tap = top legend     hold = bottom legend

Thumbs:
+-------+-------+-------+-------+
|  Win  |  Esc  | Space |       |
|       |  Ctl  |       |  Alt  |
+-------+-------+-------+-------+
  LWin    LAlt    Space   RAlt  
```

### NAV — hold `x` / `.`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Esc  |  Tab  |  End  | Tab>  | Fwd>  |    | Paste | PgUp  |  Tab  | Bksp  |  Up   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Home  | Save  | PgDn  | Right | Back  |    | Left  | Down  |  Up   | Right | Enter |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Undo  |  Cut  | Copy  | Paste | Left  |    | Down  | Media | Vol-  | Vol+  |  Del  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Space
```

Reach NAV by holding `x` or `.`. For Alt+Tab, hold the right-Alt thumb and tap Tab (Tab = the `a`+`s`+`d` combo, or a physical Tab key where the board has one). `Media` tap-dance: 1 tap = play/pause, hold = mute, 2 taps = next, 3 = previous. Emacs-style nav: `n p f b a e` = ↓ ↑ → ← Home End, mirroring `C-n/p/f/b/a/e`. Vim-style too: `h j k l` = ← ↓ ↑ →, with `d`/`u` = PgDn/PgUp (like `C-d`/`C-u`).

### SYM — hold `v` / `m`

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

Every operator (`+ - * / =`) sits on the left top row and every bracket (`( ) [ ] { }`) on the right hand, so each group is one-handed: hold SYM with `m` to type operators with the left hand, or with `v` to type brackets with the right. One-shot mods are on the left home row (`a s d f`), matching NUM and FUN.

### NUM — hold `c` / `,`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   (   |   )   |       |       |       |    |   +   |   7   |   8   |   9   |   *   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osWin | osAlt | osSft | osCtl | Bksp  |    |   -   |   4   |   5   |   6   |   /   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|       | osSft |       |  000  | ,000  |    |   ,   |   1   |   2   |   3   |   .   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = 0     physical Left-Alt thumb (your Ctrl key):  tap = exit NUM  /  hold = NAV
```

Ctrl+5 = `f` then `5`. `000`/`,000` are typing macros. In NUM, Space types **0** and never exits — leave NUM by releasing the hold (`c` or `,`) or tapping the left-Alt thumb (your Ctrl thumb; it's the "tap: exit" key in the map above).

### FUN — hold `z` / `/`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prev  | Play  | Next  | Vol-  | Vol+  |    |       |  F7   |  F8   |  F9   |  F10  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osWin | osAlt | osSft | osCtl | Mute  |    |       |  F4   |  F5   |  F6   |  F11  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Emoji | Shot  |       |       |       |    |       |  F1   |  F2   |  F3   |  F12  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Caps Lock
```

F1–F12 sit on the right hand, on the same keys their digits occupy in NUM — F1 on `m`, F5 on `k`, F9 on `o`, with F10–F12 down the pinky column (`p` `;` `/`). The left hand is a media + system cluster — `q w e r t` = previous, play/pause, next, volume down, volume up, with mute on `g`, a region screenshot (Win+Shift+S) on `x`, and the emoji picker (Win+.) on `z`. So hold FUN with `z` for the right-hand F-keys, or with the right pinky (`/`) for left-hand media. The config-reload combo `g`+`h` only works on this layer.

### MOUSE — toggle with `x`+`v` (`x`+`v` again to exit)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Exit  | LClk  |  Up   | RClk  | MClk  |    | Ctrl  | ScrLt | ScrUp | ScrRt | DClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prec  | Left  | Down  | Right |       |    | Shift | LClk  | ScrDn | RClk  | Prec  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Win  |  Alt  | Shift | Ctrl  |       |    |  Alt  | Back  | MClk  | Fwd   | TClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
```

A sticky layer: press `x`+`v` to enter, `x`+`v` again to leave. Move the cursor with the **left hand** (ESDF): `e` up, `s` left, `d` down, `f` right — accelerates while held. The **right hand** clicks and scrolls: `j` left-click, `l` right-click, `i` scroll up, `k` scroll down, `u` scroll left, `o` scroll right. **Middle-click** is on `,`, with **browser back/forward** on `m`/`.`; **Space** is also left-click. Additional click aliases on the top row: `w` = left-click, `r` = right-click, `t` = middle-click. The right pinky has **`p` = double-click** and **`/` = triple-click** (each fires as one macro, so the OS always registers a real multi-click). The right-hand inner column **`y` `h` `n` = Ctrl, Shift, Alt** — hold one with the right hand while the left hand keeps moving on ESDF, then click with **Space** (right thumb) for modifier+drag, e.g. Shift-drag to select. The bottom-row keys **`z` `x` `c` `v` = Win, Alt, Shift, Ctrl** mirror the same modifiers on the left hand, and the thumbs add **Ctrl (left `LAlt`) / Alt (right `RAlt`)** — so you can Shift-click to extend a selection, Ctrl-click to multi-select, Alt-click, or Ctrl-scroll to zoom. **Hold `a`** (left pinky) or **`;`** (right pinky) for **precision mode**: the cursor crawls in 1px steps for fine positioning; release to restore normal speed. Tap **`q`** to exit the layer in one key (same as the `x`+`v` toggle). Every combo is disabled inside this layer (and in precision mode), so two-key presses never misfire.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing.

Each combo lives where your fingers already are — a pair (or row) of **touching keys**:

```
NEIGHBOUR COMBOS  —  press two (or more) touching keys

   Q     W     E     R     T             Y     U     I     O     P
   └─Esc─┘           └─Del─┘                   └─Bsp─┘
   └─────┴Plain┴─────┘                         └─────┴NoCmb┴─────┘

   A     S     D     F     G             H     J     K     L     ;
   └─Tab─┴─────┘     └sel→─┘             └sel←─┘     └dlw←─┘
         └dlw→─┘                               └wrd←─┘     └─Ent─┘
         └───Undo────┘                         └───Redo────┘
               └wrd→─┘

   Z     X     C     V     B             N     M     ,     .     /
   └─Cut─┘     └─Pst─┘                         └─Num─┘
         └Copy─┘
         └───Mous────┘


COLUMN COMBOS  —  press a key together with the one below it

   Q     W     E     R     T             Y     U     I     O     P
   │ SelA│ Save      │ Find                    │ +   │ -   │ *
   A     S     D     F     G             H     J     K     L     ;


CROSS-HAND / THUMB

   D + K  =  Caps Word          G + H  =  reload (FUN layer)
   F / S / D  +  Right-thumb  =  ~ / ^ / `
```

A `└─┘` spans the keys you press; an interior `┴` tick marks a middle key that's *also* part of the combo (so `Tab` = A·S·D), whereas a plain span skips its middle (`Undo` = S·F, not D).

`dlw` delete word · `wrd` move word · `sel` select word · `→`/`←` right / left · `Bsp` Backspace · `Ent` Enter · `Pst` Paste · `Num` Num Word · `Mous` Mouse toggle · `SelA` Select All · `Plain` plain mode · `NoCmb` all-combos toggle.

| Combo | Result |
|---|---|
| `q w` | Esc |
| `a s d` | Tab |
| `l ;` | Enter |
| `u i` | Backspace |
| `r t` | Forward delete |
| `s d` / `k l` | Delete word forward / back (Ctrl+Del / Ctrl+Bksp) |
| `d k` | Caps Word on/off |
| `d f` / `j k` | Move word right / left (Ctrl+→ / Ctrl+←) |
| `f g` / `h j` | Select word right / left (Shift+Ctrl+→ / ←) |
| `z x` / `x c` / `c v` | Cut / Copy / Paste (Ctrl+`X` / `C` / `V`) |
| `s f` / `j l` | Undo / Redo (Ctrl+Z / Ctrl+Shift+Z) |
| `w s` / `q a` / `r f` | Save / Select all / Find (Ctrl+S / A / F) |
| `m ,` | Num Word on (tap the Ctrl thumb to cancel) |
| `u j` / `i k` / `o l` | `+` / `-` / `*` (vertical, same-finger) |
| `f` / `s` / `d` + right Alt | `~` / `^` / `` ` `` |
| `q w e r` | Plain mode on/off |
| `u i o p` | All combos on/off |
| `g h` (FUN layer only) | live-reload the config |

**Master toggle:** `u`+`i`+`o`+`p` silences every combo above at once (press it again to bring them back) — handy for games or apps with their own chord shortcuts. Home row mods, layers, and one-shots keep working; only the two-key combos go quiet. It mirrors the `q`+`w`+`e`+`r` plain-mode toggle, and it's the one combo that stays live while combos are off, so you can always switch back. Under the hood it drops you into a `nocombo` layer (a clone of DEF that's listed in every combo's disabled-layers).

## One-shot mods

NUM, SYM, and FUN all have `osWin osAlt osSft osCtl` on the **left** home row (`a s d f`); NAV has none — its home row is navigation. **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Win+E = NUM → tap `a` → release → `e`. Alt+F4 = hold `z` → tap `s` → tap `j`.

## Caps Word and Num Word

**Caps Word** (`d`+`k`): next letters come out capitalized, no Shift held. Ends on Space, Enter, a digit, or 5 s idle; survives apostrophes, Backspace, and the `~ ^ ` `` combos — for underscores, hold `d`/`k` instead.

**Num Word** (`m`+`,`): sticky NUM layer, no key held. Space types a **0** and stays on; tap the left-Alt thumb (your Ctrl thumb) to cancel. The combo only turns it on (it's disabled inside NUM), so typing digits like 12 can't trip it. The right-hand combos (`l·;` = Enter, `u·i` = Backspace) stay available.

## Quick start

Needs Windows 10/11 and **kanata v1.10.1+** ([releases](https://github.com/jtroo/kanata/releases)).

1. Validate: `kanata.exe --cfg wins.kbd --check`
2. Run: `kanata.exe --cfg wins.kbd` — **as administrator** if you want remaps inside elevated apps
3. Test: hold left Alt + `c` → Ctrl+C; hold `x` + `k` → ↑ (NAV); tap the left Alt thumb → Esc.

**Autostart:** covered by the [Install](#install) section's `kanata.bat`. If you want it elevated (remaps in admin apps) without a UAC prompt, use Task Scheduler instead: trigger "At log on", check "Run with highest privileges".

**After editing the config:** run `--check`, then restart kanata or live-reload: hold `z`/`/` (FUN) and press `g`+`h`. A failed reload keeps the previous good config running.

## What's remapped

Only 34 keys. Number row, F-row, Tab, Caps Lock, Esc, Enter, Backspace, Shift, arrows, Delete, right Ctrl, and Fn are untouched.

| Physical key | Tap | Hold |
|---|---|---|
| Left Win | Win (Start menu) | (none) |
| Left Alt | **Esc** | **Ctrl** |
| Right Alt | (quick Alt) | **Alt** |
| `a s d f` / `j k l ;` | the letter | Win Alt Shift Ctrl / Ctrl Shift Alt Win |
| `z` / `c` | the letter | **FUN** / **NUM** |
| `/` / `,` | the symbol | **FUN** / **NUM** |
| `x` / `.` | the letter / symbol | **NAV** |
| `v` / `m` | the letter | **SYM** |

## Troubleshooting

- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Start menu pops up randomly."** You held `a` and released it with no other key — that's a Win tap. Press Esc.
- **"Remaps don't work in Task Manager / admin windows."** Run kanata as administrator.
- **"Config won't load after an edit."** `--check` tells you the line. A broken live-reload keeps the previous working config.

## Tuning knobs

In the `defvar` block:

- `tapping-term 300` — lower = mods trigger faster when held, slightly higher misfire risk
- `require-prior-idle 250` — how long a pause re-arms the mods
- `one-shot-timeout 60000` — how long one-shots stay armed
- `chords-v2-min-idle 350` — lower if combos need too long a pause
- Mod order: edit the ten `a`–`;` alias lines (and the `@osm @osa @oss @osc` rows in each layer)

## Credits

[urob's ZMK config](https://github.com/urob/zmk-config) (the timerless design), sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/), and [jtroo/kanata](https://github.com/jtroo/kanata) itself.
