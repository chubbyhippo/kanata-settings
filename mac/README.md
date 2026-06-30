# mac.kbd — macOS kanata config

A [kanata](https://github.com/jtroo/kanata) config for macOS with "timerless" home row mods: type as fast as you want with zero misfires and zero letter reordering, while keeping all four modifiers plus navigation, symbol, number, and function layers on the home position. Mod order is GASC — Ctrl on the index finger, Cmd on `a`/`;` — so Emacs muscle memory carries over.

**The one rule:** while you're typing, the home row is just letters — mods only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold → press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J). Same-hand mod+letter never chords — use a one-shot or hold the mod a full 0.3 s first. (Exceptions: `d`/`k` keep their Shift hold and `f`/`j` their Ctrl hold even mid-burst — C-n/C-p right after typing just works.)

## Install

Needs **kanata v1.10.1+** ([releases](https://github.com/jtroo/kanata/releases)). One-time setup:

1. **kanata binary:** `brew install kanata`, or put the release binary at `/usr/local/bin/kanata` (`chmod +x` it).

2. **Everything else** — Karabiner driver, config, autostart:

   ```sh
   curl -fsSL https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac/install.sh | sudo sh
   ```

   [`install.sh`](install.sh) downloads the [Karabiner driver **v6.2.0**](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/tag/v6.2.0) (the exact version kanata is built against), checksum-verifies and installs it, and activates the extension. Approving it is the one step Apple keeps manual: the script stops and points you to System Settings → General → Login Items & Extensions → Driver Extensions. Approve, re-run the same command, and it finishes — config at `/etc/kanata/mac.kbd` (validated first), both LaunchDaemons installed and pointed at your kanata binary, the `org.pqrs` daemon skipped if Karabiner-Elements already manages it. Idempotent — re-run any time.

3. **Permissions:** System Settings → Privacy & Security → add the kanata binary to **Input Monitoring** and **Accessibility**. Both are required: the Karabiner driver handles keyboard events, but mouse simulation (`movemouse-*`, clicks, scroll) goes through the macOS CoreGraphics API which needs Accessibility separately.

   **Finding the binary in the file picker** — the kanata binary lives in a system path that the macOS file picker hides by default. First, confirm the exact path your install uses:

   ```sh
   grep -A2 ProgramArguments /Library/LaunchDaemons/dev.kanata.kanata.plist
   ```

   It will be one of:
   - `/opt/homebrew/bin/kanata` — Apple Silicon (M1/M2/M3/M4)
   - `/usr/local/bin/kanata` — Intel

   Then add it to both **Input Monitoring** and **Accessibility** — do the following steps twice, once for each:

   1. System Settings → Privacy & Security → **Input Monitoring** (first pass) / **Accessibility** (second pass)
   2. Click the lock icon and enter your password
   3. Click **+**
   4. In the file picker, press **Cmd+Shift+G** to open the "Go to Folder" dialog
   5. Paste `/opt/homebrew/bin` (Apple Silicon) or `/usr/local/bin` (Intel) and press **Enter**
   6. Select `kanata` and click **Open**

   If kanata is already listed but the mouse layer still doesn't work, **toggle the switch off then on** — macOS sometimes silently breaks the permission after a binary update.

   7. Restart kanata to pick up the new permissions:
      ```sh
      sudo launchctl kickstart -k system/dev.kanata.kanata
      ```

Then test: hold `x` + `k` → ↑ (NAV), or hold the **right thumb** + `k` → ↑ (its tap = Enter, hold = NAV).

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold LCmd thumb (NUM) + `x` / `v` / `c` / `z` · or combos `x·c` / `c·v` / `z·x` / `s·f` |
| Ctrl chords (Emacs, terminal) | pause, then hold `f`/`j` (Ctrl) + a cross-hand key |
| Cmd+Tab | hold `a` (Cmd) + Tab (the `a`+`s`+`d` combo or a physical Tab key) |
| Enter | tap the right thumb · or the `l`+`;` combo |
| Quit / close (Cmd+Q / Cmd+W) | NUM (hold `c` / `,`): tap `a` (one-shot Cmd), release, press `q` / `w` |
| Reopen tab (Cmd+Shift+T) | NUM: tap `a`, tap `d`, release, press `t` |
| Move word left / right | `j`+`k` = Opt+← · `d`+`f` = Opt+→ |
| Select word left / right | `h`+`j` = Shift+Opt+← · `f`+`g` = Shift+Opt+→ |
| Delete word forward / back | `s`+`d` = Opt+Del · `k`+`l` = Opt+Bksp |
| Undo / Redo | `s`+`f` = Cmd+Z · `j`+`l` = Cmd+Shift+Z |
| Cut / Copy / Paste (combo) | `z`+`x` = Cut · `x`+`c` = Copy · `c`+`v` = Paste |
| Type ( ) [ ] | `u`+`j` = ( · `i`+`k` = ) · `o`+`l` = [ · `p`+`;` = ] |
| Home / End | `t`+`g` = Home · `y`+`h` = End · FUN (hold `z`/`/`): `y` = Home, `h` = End |
| Line start / end | `v`+`b` = Cmd+← · `m`+`n` = Cmd+→ |
| Arrows (left, ESDF) | hold NAV (`x`/`.`/right thumb): `e`/`s`/`d`/`f` = ↑/←/↓/→ · `w`/`r` = Home/End |
| Arrows (right, vim) | hold NAV: `h`/`j`/`k`/`l` = ←/↓/↑/→ · `u` = PgUp |
| Next / previous tab | hold `f` (Ctrl), tap Tab — add Shift for previous |
| Browser back / forward | hold `x` / `.` (NAV) + `g` / `t` (Cmd+[ / Cmd+]) |
| Arrows, PgUp, Home/End | hold `x` / `.` / the **right thumb** (NAV) |
| Spotlight (Cmd+Space) | tap left Opt; or hold `a` (Cmd) + Space |
| Cmd + any left-hand key | NUM: tap `a` (one-shot Cmd), release, press the letter |
| Screenshot (Cmd+Shift+4) | FUN (hold `/`): `x`; or NUM: tap `a`, tap `d`, press `j` (= 4) |
| Emoji picker | FUN (hold `/`): `z` (Cmd+Ctrl+Space) |
| Select text | hold real Shift + NAV arrows |
| Accents (é, ü, ñ…) | right Opt is untouched — use it as stock |
| Type ALL_CAPS | `d`+`k` together → Caps Word; Space or a digit ends it |
| Type a number / amount | `m`+`,` → Num Word on; Space types 0; tap the Left-Cmd thumb to exit |
| Esc / Tab / Enter / Backspace / Delete | combos `q·w` / `a·s·d` / `l·;` / `y·u` / `r·t` |
| Save / Select all / Find / Duplicate | combos `w·s` / `q·a` / `r·f` / `e·d` |
| Media (audio) | FUN (hold `/`): `q` `w` `e` = prev · play/pause · next; `r` `t` = vol down · up; mute on `g` |
| F-keys | hold `z` (FUN): right hand = F1–F12, in the same spots as NUM's digits |
| Mouse | `x`+`v` toggles the mouse layer (`x`+`v` again or `q` exits): move `e s d f`, click `j`/`w`/`l`/`r` or Space, middle-click `,`/`t`, scroll `i`/`k` up/down · `u`/`o` left/right, back/forward `m`/`.`; double-click `p`, triple-click `/`; modifiers `y`/`h`/`n` = Ctrl/Shift/Opt; hold `a`/`;` = precision (slow) move |
| Caps Lock | the physical Caps Lock key, or FUN layer + Space |
| Esc | tap the left Cmd thumb (or the `q`+`w` combo) |
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
|  Cmd  |  Opt  |  Sft  |  Ctl  |       |    |       |  Ctl  |  Sft  |  Opt  |  Cmd  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   Z   |   X   |   C   |   V   |   B   |    |   N   |   M   |   ,   |   .   |   /   |
|  FUN  |  NAV  |  NUM  |  SYM  |       |    |       |  SYM  |  NUM  |  NAV  |  FUN  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
  tap = top legend     hold = bottom legend

Thumbs:
+-------+-------+-------+-------+
| Spot  |  Esc  | Space | Enter |
|       |  NUM  |       |  NAV  |
+-------+-------+-------+-------+
  LOpt    LCmd    Space   RCmd  
```

### NAV — hold `x` / `.`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Esc  | Home  |  Up   |  End  | Fwd>  |    | Paste | PgUp  |  Tab  | Bksp  |  Up   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Home  | Left  | Down  | Right | Back  |    | Left  | Down  |  Up   | Right | Enter |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Undo  |  M-x  | Copy  | Paste | Left  |    | Down  |  M-m  | Vol-  | Vol+  |  Del  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Space
```

Reach NAV by holding `x`, `.`, or the **right thumb** (tap = Enter, hold = NAV). The **left hand is an ESDF arrow cluster** — `e`/`s`/`d`/`f` = ↑ ← ↓ →, with `w` = Home and `r` = End. The **right hand keeps vim arrows** `h j k l` = ← ↓ ↑ →, plus `u` = PgUp, `i` = Tab, `o` = Bksp, `;` = Enter, `/` = Del; `a` also = Home and `b` also = Left. `z` / `c` / `v` = Undo / Copy / Paste, and `g` / `t` = browser Back / Forward (Cmd+[ / Cmd+]). `x` sends Emacs **M-x** and `m` sends **M-m** — i.e. Alt+x / Alt+m (kanata's `M-` is Cmd in this config, so Emacs Meta uses `A-`). For Cmd+Tab, hold `a` (Cmd) + Tab (the `a`+`s`+`d` combo, or a physical Tab key). `,` / `.` = volume down / up.

### SYM — hold `v` / `m`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   +   |   -   |   *   |   /   |   =   |    |   &   |   (   |   )   |   [   |   ]   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osCmd | osOpt | osSft | osCtl |   $   |    |   #   |   {   |   }   |   '   |   "   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   `   |   ^   |   ~   |   %   |   @   |    |   |   |   \   |   ?   |   !   |   :   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = _  (underscore)
```

Every operator (`+ - * / =`) sits on the left top row and every bracket (`( ) [ ] { }`) on the right hand, so each group is one-handed: hold SYM with `m` to type operators with the left hand, or with `v` to type brackets with the right. One-shot mods are on the left home row (`a s d f`), matching NUM and FUN.

### NUM — hold `c` / `,`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|   (   |   )   |   %   |   =   |   ^   |    |   +   |   7   |   8   |   9   |   *   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osCmd | osOpt | osSft | osCtl | Bksp  |    |   -   |   4   |   5   |   6   |   /   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Undo  |  Cut  | Copy  | Paste | ,000  |    |   ,   |   1   |   2   |   3   |   .   |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = 0     Left-Cmd thumb:  tap = exit NUM  /  hold = NAV
```

Ctrl+5 = `f` then `5`. `,000` is a typing macro. `z x c v` = Undo / Cut / Copy / Paste (Cmd+Z/X/C/V). In NUM, Space types **0** and never exits — leave NUM by releasing the hold (`c` / `,` / Left-Cmd thumb) or tapping the Left-Cmd thumb.

### FUN — hold `z` / `/`

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prev  | Play  | Next  | Vol-  | Vol+  |    | Home  |  F7   |  F8   |  F9   |  F10  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| osCmd | osOpt | osSft | osCtl | Mute  |    |  End  |  F4   |  F5   |  F6   |  F11  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Emoji | Shot  |       |       |       |    |       |  F1   |  F2   |  F3   |  F12  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Caps Lock
```

F1–F12 sit on the right hand, on the same keys their digits occupy in NUM — F1 on `m`, F5 on `k`, F9 on `o`, with F10–F12 down the pinky column (`p` `;` `/`). `y` = Home, `h` = End. The left hand is a media + system cluster — `q w e r t` = previous, play/pause, next, volume down, volume up, with mute on `g`, a region screenshot (Cmd+Shift+4) on `x`, and the emoji picker (Cmd+Ctrl+Space) on `z`. So hold FUN with `z` for the right-hand F-keys, or with the right pinky (`/`) for left-hand media. The config-reload combo `g`+`h` only works on this layer. The physical fn/Globe key is untouched, so fn-row media functions still work.

### MOUSE — toggle with `x`+`v` (`x`+`v` again to exit)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Exit  | LClk  |  Up   | RClk  | MClk  |    | Ctrl  | ScrLt | ScrUp | ScrRt | DClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prec  | Left  | Down  | Right |       |    | Shift | LClk  | ScrDn | RClk  | Prec  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Cmd  |  Opt  | Shift | Ctrl  |       |    |  Opt  | Back  | MClk  | Fwd   | TClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
```

A sticky layer: press `x`+`v` to enter, `x`+`v` again to leave. Move the cursor with the **left hand** (ESDF): `e` up, `s` left, `d` down, `f` right — accelerates while held. The **right hand** clicks and scrolls: `j` left-click, `l` right-click, `i` scroll up, `k` scroll down, `u` scroll left, `o` scroll right. **Middle-click** is on `,`, with **browser back/forward** on `m`/`.`; **Space** is also left-click. Additional click aliases on the top row: `w` = left-click, `r` = right-click, `t` = middle-click. The right pinky has **`p` = double-click** and **`/` = triple-click** (each fires as one macro, so the OS always registers a real multi-click). The right-hand inner column **`y` `h` `n` = Ctrl, Shift, Opt** — hold one with the right hand while the left hand keeps moving on ESDF, then click with **Space** (right thumb) for modifier+drag, e.g. Shift-drag to select. The bottom-row keys **`z` `x` `c` `v` = Cmd, Opt, Shift, Ctrl** mirror the same modifiers on the left hand, and the thumbs add **Ctrl (left `LCmd`) / Opt (right `RCmd`)** — so you can Shift-click to extend a selection, Cmd-click to multi-select, Opt-click, or Ctrl-scroll to zoom. **Hold `a`** (left pinky) or **`;`** (right pinky) for **precision mode**: the cursor crawls in 1px steps for fine positioning; release to restore normal speed. Tap **`q`** to exit the layer in one key (same as the `x`+`v` toggle). Every combo is disabled inside this layer (and in precision mode), so two-key presses never misfire.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing. Inside the NUM layer every combo is off except `l·;` = Enter and `y·u` = Backspace, so typing numbers never misfires.

Each combo lives where your fingers already are — a pair (or row) of **touching keys**:

```
NEIGHBOUR COMBOS  —  press two (or more) touching keys

   Q     W     E     R     T             Y     U     I     O     P
   └─Esc─┘           └─Del─┘             └─Bsp─┘
   └─────┴Plain┴─────┘                         └─────┴NoCmb┴─────┘

   A     S     D     F     G             H     J     K     L     ;
   └─Tab─┴─────┘     └sel→─┘             └sel←─┘     └dlw←─┘
         └dlw→─┘                               └wrd←─┘     └─Ent─┘
         └───Undo────┘                         └───Redo────┘
               └wrd→─┘

   Z     X     C     V     B             N     M     ,     .     /
   └─Cut─┘     └─Pst─┘                         └─Num─┘
         └Copy─┘     └⌘←───┘             └──⌘→─┘
         └───Mouse───┘


COLUMN COMBOS  —  press a key together with the one below it

   Q     W     E     R     T             Y     U     I     O     P
   │ SelA│ Save│ Dup │ Find│ Home        │ End │ (   │ )   │ [   │ ]
   A     S     D     F     G             H     J     K     L     ;


CROSS-HAND / THUMB

   D + K  =  Caps Word          G + H  =  reload (FUN layer)
   F / S / D  +  Right-thumb  =  ~ / ^ / `
```

A `└─┘` spans the keys you press; an interior `┴` tick marks a middle key that's *also* part of the combo (so `Tab` = A·S·D), whereas a plain span skips its middle (`Undo` = S·F, not D).

`dlw` delete word · `wrd` move word · `sel` select word · `→`/`←` right / left · `Bsp` Backspace · `Ent` Enter · `Pst` Paste · `Num` Num Word · `SelA` Select All · `Plain` plain mode · `NoCmb` all-combos toggle.

| Combo | Result |
|---|---|
| `q w` | Esc |
| `a s d` | Tab |
| `l ;` | Enter |
| `r t` | Forward delete (same-finger) |
| `y u` | Backspace (same-finger; also active in NUM) |
| `s d` / `k l` | Delete word forward / back (Opt+Del / Opt+Bksp) |
| `d k` | Caps Word on/off |
| `d f` / `j k` | Move word right / left (Opt+→ / Opt+←) |
| `f g` / `h j` | Select word right / left (Shift+Opt+→ / ←) |
| `z x` / `x c` / `c v` | Cut / Copy / Paste (Cmd+`X` / `C` / `V`) |
| `s f` / `j l` | Undo / Redo (Cmd+Z / Cmd+Shift+Z) |
| `w s` / `q a` / `r f` / `e d` | Save / Select all / Find / Duplicate (Cmd+S / A / F / D) |
| `m ,` | Num Word on (tap the Left-Cmd thumb to cancel) |
| `u j` / `i k` / `o l` / `p ;` | `(` / `)` / `[` / `]` (vertical, same-finger) |
| `t g` / `y h` | Home / End (vertical, same-finger) |
| `v b` / `m n` | Cmd+← / Cmd+→ — line start / end (bottom row, same-finger) |
| `f` / `s` / `d` + right Cmd | `~` / `^` / `` ` `` |
| `q w e r` | Plain mode on/off |
| `u i o p` | All combos on/off |
| `g h` (FUN layer only) | live-reload the config |

**Master toggle:** `u`+`i`+`o`+`p` silences every combo above at once (press it again to bring them back) — handy for games or apps with their own chord shortcuts. Home row mods, layers, and one-shots keep working; only the two-key combos go quiet. It mirrors the `q`+`w`+`e`+`r` plain-mode toggle, and it's the one combo that stays live while combos are off, so you can always switch back. Under the hood it drops you into a `nocombo` layer (a clone of DEF that's listed in every combo's disabled-layers).

## One-shot mods

NUM, SYM, and FUN all have `osCmd osOpt osSft osCtl` on the **left** home row (`a s d f`); NAV doesn't (its home row is navigation). **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Cmd+Q = NUM → tap `a` → release → `q`. Cmd+Shift+4 = NUM → tap `a`, tap `d`, press `j` (= 4).

## Caps Word and Num Word

**Caps Word** (`d`+`k`): next letters come out capitalized, no Shift held. Ends on Space, Enter, a digit, or 5 s idle; survives apostrophes, Backspace, and the `~ ^ ` `` combos — for underscores, hold `d`/`k` instead.

**Num Word** (`m`+`,`): sticky NUM layer, no key held. Space types a **0** and stays on; tap the Left-Cmd thumb to cancel. The combo only turns it on (it's disabled inside NUM), so typing digits like 12 can't trip it. Inside NUM, every combo is disabled **except `l·;` = Enter and `y·u` = Backspace**, so you can submit and fix typos while entering numbers.

## Quick start

Needs macOS 11+, **kanata v1.10.1+**, and the Karabiner driver from [Install](#install).

1. Validate: `kanata --cfg mac.kbd --check`
2. Run: `sudo kanata --cfg mac.kbd` — kanata must run as root on macOS
3. Test: hold `x` + `k` → ↑ (NAV), or hold the **right thumb** + `k` → ↑. Tap the left Cmd thumb → Esc; tap the right thumb → Enter.

**Autostart:** covered by the [Install](#install) section's LaunchDaemons. After changing the config there, reload with `sudo launchctl kickstart -k system/dev.kanata.kanata`.

**After editing the config:** run `--check`, then restart kanata or live-reload: hold `z` / `/` (FUN) and press `g`+`h`. A failed reload keeps the previous good config running.

## What's remapped

Only 34 keys. Number row, F-row, fn/Globe, Tab, Caps Lock, Esc, Enter, Backspace, Shift, arrows, Delete, and right Opt are untouched.

| Physical key | Tap | Hold |
|---|---|---|
| Left Opt | Spotlight (Cmd+Space) | (none) |
| Left Cmd | **Esc** | **NUM** |
| Right Cmd | **Enter** | **NAV** |
| `a s d f` / `j k l ;` | the letter | Cmd Opt Shift Ctrl / Ctrl Shift Opt Cmd |
| `z` / `c` | the letter | **FUN** / **NUM** |
| `/` / `,` | the symbol | **FUN** / **NUM** |
| `x` / `.` | the letter / symbol | **NAV** |
| `v` / `m` | the letter | **SYM** |

## Troubleshooting

- **"The right Cmd thumb doesn't send Opt anymore."** Intended — it's now a layer thumb: **tap = Enter, hold = NAV**. Opt still lives on `s` (hold) and the `@osa` one-shot, and the physical *right Option* key is untouched for accents. Cmd is on `a`/`;`; Cmd+Tab = hold `a` (Cmd) + Tab (the `a`+`s`+`d` combo).
- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Left Opt does something unexpected."** The left Option thumb taps Spotlight (Cmd+Space); its hold does nothing now (NUM is on `c`/`,`). Accents live on the untouched *right* Opt.
- **"Mouse layer enters but cursor doesn't move / clicks don't register."** Keyboard remapping goes through the Karabiner driver; mouse simulation uses the macOS CoreGraphics API and requires **Accessibility** permission for the kanata binary — Input Monitoring alone isn't enough. See step 3 of [Install](#install) for how to find and add the binary in the macOS file picker.
- **"kanata dies instantly (`filesystem_error`)."** In order of likelihood: not running as root, driver not installed/approved, or another process (e.g. Karabiner-Elements) is grabbing the keyboard.
- **"`connect_failed asio.system:2` in a loop."** The VirtualHIDDevice daemon isn't running — bootstrap the `org.pqrs` LaunchDaemon from [Install](#install).
- **"Keys remap but nothing types."** Give the kanata binary Input Monitoring permission; after replacing the binary, toggle the permission off and on.
- **"Config won't load after an edit."** `--check` tells you the line. A broken live-reload keeps the previous working config.

## Tuning knobs

In the `defvar` block:

- `tapping-term 300` — lower = mods trigger faster when held, slightly higher misfire risk
- `require-prior-idle 250` — how long a pause re-arms the mods
- `one-shot-timeout 60000` — how long one-shots stay armed
- `chords-v2-min-idle 350` — lower if combos need too long a pause
- Mod order: edit the ten `a`–`;` alias lines (and the `@osm @osa @oss @osc` rows in each layer)
- Only remap some keyboards: uncomment `macos-dev-names-include` in `defcfg`

## Credits

[urob's ZMK config](https://github.com/urob/zmk-config) (the timerless design), sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/), and [jtroo/kanata](https://github.com/jtroo/kanata) itself.
