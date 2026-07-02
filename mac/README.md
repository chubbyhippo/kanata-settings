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

Then test: hold `x` + `e` → ↑ (NAV), or hold the **right thumb** + `e` → ↑ (its tap = Enter, hold = NAV).

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold LCmd thumb (NUM) + `c` / `v` / `x` / `z` |
| Ctrl chords (Emacs, terminal) | pause, then hold `f`/`j` (Ctrl) + a cross-hand key |
| Cmd+Tab | hold NAV (`x` / right thumb), tap `.` — keep tapping to cycle, `,` steps back — release NAV to switch |
| Minimize window (Cmd+M) | hold NAV: `c` |
| Mission Control (all windows) | hold NAV: `y` (Ctrl+↑) |
| Enter | tap the right thumb · NAV `h` · or a physical Enter key |
| Quit / close (Cmd+Q / Cmd+W) | NUM (hold `c` / `,`): tap `a` (one-shot Cmd), release, press `q` / `w` |
| Reopen tab (Cmd+Shift+T) | NUM: tap `a`, tap `d`, release, press `t` |
| Move word left / right | NAV (hold `x`/`.`): `a` = ← · `g` = → (Opt+←/→) |
| Delete word forward / back | combo `f`+`g` = forward · `h`+`j` = back (Opt+Del / Opt+Bksp); or NAV (hold `x`/`.`): `v` / `z` |
| Select word left / right | NAV: tap `k`+`l` (Shift+Opt), then `s`/`f` (←/→) |
| Type ( ) [ ] | SYM (hold `v`): `u`/`i`/`o`/`p` = `(` `)` `[` `]` |
| Home / End | FUN (hold `z`/`/`): `y` = Home · `h` = End |
| Line start / end | `v`+`b` = Cmd+← · `m`+`n` = Cmd+→ |
| Arrows (left, ESDF) | hold NAV (`x`/`.`/right thumb): `e`/`s`/`d`/`f` = ↑/←/↓/→ · `w`/`r` = Home/End |
| Mods + arrow (select / word-jump) | hold NAV, tap `j`/`k`/`l`/`;` = Ctrl/Shift/Opt/Cmd, then an arrow (stacks); `i` = PgDn, `o` = PgUp |
| Next / previous tab | hold `f` (Ctrl), tap Tab — add Shift for previous |
| Tab / Backspace | hold NAV: `q` = Tab · `t` = Shift+Tab · `b` = Backspace |
| Arrows, PgUp/PgDn, Home/End | hold `x` / `.` / the **right thumb** (NAV) |
| Spotlight (Cmd+Space) | tap left Opt; or hold `a` (Cmd) + Space |
| Cmd + any left-hand key | NUM: tap `a` (one-shot Cmd), release, press the letter |
| Screenshot (Cmd+Shift+4) | FUN (hold `/`): `x`; or NUM: tap `a`, tap `d`, press `j` (= 4) |
| Emoji picker | FUN (hold `/`): `z` (Cmd+Ctrl+Space) |
| Switch input source (Thai ⇄ English) | combo `t`+`g` — one flat left-index press (Ctrl+Space) |
| Select text | hold real Shift + NAV arrows |
| Accents (é, ü, ñ…) | right Opt is untouched — use it as stock |
| Type a number / amount | `m`+`,` → Num Word on; Space types 0; tap the Left-Cmd thumb to exit |
| Backspace / Delete | combos `y·u` / `r·t` (Tab and Enter are physical keys) |
| Media (audio) | FUN (hold `/`): `q` `w` `e` = prev · play/pause · next; `r` `t` = vol down · up; mute on `g` |
| F-keys | hold `z` (FUN): right hand = F1–F12, in the same spots as NUM's digits |
| Mouse | `q`+`w` toggles the mouse layer (tap `q` to exit): move `e s d f`, click `j`/`w`/`l`/`r` or Space, middle-click `,`/`t`, scroll `i`/`k` up/down · `u`/`o` left/right, back/forward `m`/`.`; double-click `p`, triple-click `/`; modifiers `y`/`h`/`n` = Ctrl/Shift/Opt; hold `a`/`;` = precision (slow) move |
| Caps Lock | the physical Caps Lock key, or FUN layer + Space |
| Esc | tap the left Cmd thumb |
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
|  Tab  | Home  |  Up   |  End  | S-Tab |    | MsnCt | Paste | PgDn  | PgUp  |  Del  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Wrd←  | Left  | Down  | Right | Wrd→  |    | Enter | osCtl | osSft | osOpt | osCmd |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Dlw←  |  M-x  |  Min  | Dlw→  | Bksp  |    | Menu  |  M-m  | App←  | App→  |  M-/  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+

Space = Space
```

Reach NAV by holding `x`, `.`, or the **right thumb** (tap = Enter, hold = NAV). The **left hand is an ESDF arrow cluster** — `e`/`s`/`d`/`f` = ↑ ← ↓ →, with `w` = Home and `r` = End. The **right home row is one-shot mods** — `j`/`k`/`l`/`;` = Ctrl / Shift / Opt / Cmd; tap one (they stack), then an ESDF arrow — e.g. `k` then `f` = Shift+→ to select, `l` then `s` = Opt+← to jump a word left. `i` = PgDn, `o` = PgUp, `u` = Paste, `p` = Del; `y` = Mission Control (Ctrl+↑) — the all-windows overview (macOS gives it little keyboard control, so pick with the pointer or a swipe); `h` = Enter (also on the right thumb). `c` = minimize the window (Cmd+M), `z` / `v` = delete word back / forward (Opt+Bksp / Opt+Del), Paste is on `u` (for copy use NUM `c`, or the `;` one-shot then `c`); `a` / `g` = move word left / right (Opt+← / Opt+→); `q` = Tab, `t` = Shift+Tab, `b` = Backspace (left side); Esc is on the left thumb. `x` / `m` / `/` send Emacs **M-x** / **M-m** / **M-/** (dabbrev autocomplete) — i.e. Alt+x / Alt+m / Alt+`/` (kanata's `M-` is Cmd in this config, so Emacs Meta uses `A-`). `.` is the app swapper: kanata holds Cmd for you and taps Tab, so keep tapping `.` to walk the Cmd-Tab switcher, tap `,` to step back (Cmd+Shift+Tab), and release NAV to drop Cmd and land in the chosen app. (Holding `.` itself for NAV keeps that key busy — drive the swapper from the thumb or `x`.) Volume is on FUN (`r` / `t`). `n` = Menu (the PC context-menu / Application key — largely inert on stock macOS, kept for parity with the Windows config).

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

Space = 0     Left-Cmd thumb:  tap = exit NUM  /  hold = SYM     right thumb:  tap = Enter  /  hold = NAV, as always
```

Ctrl+5 = `f` then `5`. `,000` is a typing macro. `z x c v` = Undo / Cut / Copy / Paste (Cmd+Z/X/C/V). Space types **0** and never exits. The right thumb keeps its everyday job — tap Enter, hold NAV — so you can type an amount, hit Enter, and arrow to the next field without ever leaving NUM. The Left-Cmd thumb turns into the way out: tap to leave NUM, or hold it for a stray symbol (SYM). Those left-thumb roles matter when NUM came from `c` / `,` or Num Word — if you're holding that thumb *for* NUM, it's busy; just let go.

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

F1–F12 sit on the right hand, on the same keys their digits occupy in NUM — F1 on `m`, F5 on `k`, F9 on `o`, with F10–F12 down the pinky column (`p` `;` `/`). `y` = Home, `h` = End. The left hand is a media + system cluster — `q w e r t` = previous, play/pause, next, volume down, volume up, with mute on `g`, a region screenshot (Cmd+Shift+4) on `x`, and the emoji picker (Cmd+Ctrl+Space) on `z`. So hold FUN with `z` for the right-hand F-keys, or with the right pinky (`/`) for left-hand media. The physical fn/Globe key is untouched, so fn-row media functions still work.

### MOUSE — toggle with `q`+`w` (tap `q` to exit)

```
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Exit  | LClk  |  Up   | RClk  | MClk  |    | Ctrl  | ScrLt | ScrUp | ScrRt | DClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
| Prec  | Left  | Down  | Right |       |    | Shift | LClk  | ScrDn | RClk  | Prec  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
|  Cmd  |  Opt  | Shift | Ctrl  |       |    |  Opt  | Back  | MClk  | Fwd   | TClk  |
+-------+-------+-------+-------+-------+    +-------+-------+-------+-------+-------+
```

A sticky layer: press `q`+`w` to enter; tap `q` to leave. Move the cursor with the **left hand** (ESDF): `e` up, `s` left, `d` down, `f` right — accelerates while held. The **right hand** clicks and scrolls: `j` left-click, `l` right-click, `i` scroll up, `k` scroll down, `u` scroll left, `o` scroll right. **Middle-click** is on `,`, with **browser back/forward** on `m`/`.`; **Space** is also left-click. Additional click aliases on the top row: `w` = left-click, `r` = right-click, `t` = middle-click. The right pinky has **`p` = double-click** and **`/` = triple-click** (each fires as one macro, so the OS always registers a real multi-click). The right-hand inner column **`y` `h` `n` = Ctrl, Shift, Opt** — hold one with the right hand while the left hand keeps moving on ESDF, then click with **Space** (right thumb) for modifier+drag, e.g. Shift-drag to select. The bottom-row keys **`z` `x` `c` `v` = Cmd, Opt, Shift, Ctrl** mirror the same modifiers on the left hand, and the thumbs add **Ctrl (left `LCmd`) / Opt (right `RCmd`)** — so you can Shift-click to extend a selection, Cmd-click to multi-select, Opt-click, or Ctrl-scroll to zoom. **Hold `a`** (left pinky) or **`;`** (right pinky) for **precision mode**: the cursor crawls in 1px steps for fine positioning; release to restore normal speed. Tap **`q`** to exit the layer in one key. Every combo is disabled inside this layer (and in precision mode), so two-key presses never misfire.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing. Inside the NUM layer every combo is off except `y·u` = Backspace, so typing numbers never misfires.

The home row (`a`–`;`) is otherwise mods-only, but its two index-finger pairs now carry the delete-word combos — `f`+`g` and `h`+`j` (same-finger, so misfire-proof). The rest live on the top and bottom rows — plus one *vertical* pair, `t`+`g` (top+home, one flat left-index press), for switching the input source:

```
NEIGHBOUR COMBOS  —  press two (or more) touching keys

   Q     W     E     R     T             Y     U     I     O     P
   └Mouse┘           └─Del─┘             └─Bsp─┘
   └─────┴Plain┴─────┘                         └─────┴NoCmb┴─────┘
                           │Lang
   A     S     D     F     G             H     J     K     L     ;
                     └DelF─┘             └DelB─┘

   Z     X     C     V     B             N     M     ,     .     /
                     └⌘←───┘             └──⌘→─┘
                                               └─Num─┘
```

A `└─┘` spans the keys you press; an interior `┴` tick marks a middle key that's *also* part of the combo (so `Plain` = Q·W·E·R and `NoCmb` = U·I·O·P); every other span is just its two neighbouring keys. The `│` between T and G marks the one vertical pair — both keys under the same finger, pressed together flat.

`Mouse` mouse layer · `Del` forward delete · `Bsp` Backspace · `Lang` switch input source (Ctrl+Space) · `⌘←`/`⌘→` line start / end · `DelF`/`DelB` delete word forward / back · `Num` Num Word · `Plain` plain mode · `NoCmb` all-combos toggle.

| Combo | Result |
|---|---|
| `q w` | Mouse layer on/off (tap `q` to exit) |
| `r t` | Forward delete (same-finger) |
| `y u` | Backspace (same-finger; also active in NUM) |
| `f g` / `h j` | Delete word forward / back — Opt+Del / Opt+Bksp (home row, same-finger) |
| `t g` | Switch input source — Ctrl+Space (vertical same-finger pair, left index) |
| `v b` / `m n` | Cmd+← / Cmd+→ — line start / end (bottom row, same-finger) |
| `m ,` | Num Word on (tap the Left-Cmd thumb to cancel) |
| `q w e r` | Plain mode on/off |
| `u i o p` | All combos on/off |

**Master toggle:** `u`+`i`+`o`+`p` silences every combo above at once (press it again to bring them back) — handy for games or apps with their own chord shortcuts. Home row mods, layers, and one-shots keep working; only the two-key combos go quiet. It mirrors the `q`+`w`+`e`+`r` plain-mode toggle, and it's the one combo that stays live while combos are off, so you can always switch back. Under the hood it drops you into a `nocombo` layer (a clone of DEF that's listed in every combo's disabled-layers).

## One-shot mods

NUM, SYM, and FUN all have `osCmd osOpt osSft osCtl` on the **left** home row (`a s d f`); NAV mirrors them on the **right** home row instead (`j k l ;` = Ctrl Shift Opt Cmd), since its left hand is the arrow cluster. **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Cmd+Q = NUM → tap `a` → release → `q`. Cmd+Shift+4 = NUM → tap `a`, tap `d`, press `j` (= 4).

## Num Word

**Num Word** (`m`+`,`): sticky NUM layer, no key held. Space types a **0** and stays on; tap the Left-Cmd thumb to cancel. The combo only turns it on (it's disabled inside NUM), so typing digits like 12 can't trip it. Inside NUM, every combo is disabled **except `y·u` = Backspace**, so you can fix typos while entering numbers.

## Quick start

Needs macOS 11+, **kanata v1.10.1+**, and the Karabiner driver from [Install](#install).

1. Validate: `kanata --cfg mac.kbd --check`
2. Run: `sudo kanata --cfg mac.kbd` — kanata must run as root on macOS
3. Test: hold `x` + `e` → ↑ (NAV), or hold the **right thumb** + `e` → ↑. Tap the left Cmd thumb → Esc; tap the right thumb → Enter.

**Autostart:** covered by the [Install](#install) section's LaunchDaemons. After changing the config there, reload with `sudo launchctl kickstart -k system/dev.kanata.kanata`.

**After editing the config:** run `--check`, then restart kanata to apply: `sudo launchctl kickstart -k system/dev.kanata.kanata`. A config that fails `--check` won't load, so the previous good one keeps running.

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

- **"The right Cmd thumb doesn't send Opt anymore."** Intended — it's now a layer thumb: **tap = Enter, hold = NAV**. Opt still lives on `s` (hold) and the `@osa` one-shot, and the physical *right Option* key is untouched for accents. Cmd is on `a`/`;`; for Cmd+Tab hold NAV and tap `.` (the swapper), or hold `a` (Cmd) + a physical Tab.
- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Left Opt does something unexpected."** The left Option thumb taps Spotlight (Cmd+Space); its hold does nothing now (NUM is on `c`/`,`). Accents live on the untouched *right* Opt.
- **"Mouse layer enters but cursor doesn't move / clicks don't register."** Keyboard remapping goes through the Karabiner driver; mouse simulation uses the macOS CoreGraphics API and requires **Accessibility** permission for the kanata binary — Input Monitoring alone isn't enough. See step 3 of [Install](#install) for how to find and add the binary in the macOS file picker.
- **"kanata dies instantly (`filesystem_error`)."** In order of likelihood: not running as root, driver not installed/approved, or another process (e.g. Karabiner-Elements) is grabbing the keyboard.
- **"`connect_failed asio.system:2` in a loop."** The VirtualHIDDevice daemon isn't running — bootstrap the `org.pqrs` LaunchDaemon from [Install](#install).
- **"Keys remap but nothing types."** Give the kanata binary Input Monitoring permission; after replacing the binary, toggle the permission off and on.
- **"Config won't load after an edit."** `--check` tells you the line. A config that fails the check won't start, so the previously running instance keeps working until you restart.

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
