# wins.kbd — Windows kanata config

A [kanata](https://github.com/jtroo/kanata) config for Windows with "timerless" home row mods: type as fast as you want with zero misfires and zero letter reordering, while keeping all four modifiers plus navigation, symbol, number, and function layers on the home position.

**The one rule:** while you're typing, the home row is just letters — mods only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold → press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J). Same-hand mod+letter never chords — use a one-shot or hold the mod a full 0.3 s first. (Exceptions: `d`/`k` keep their Shift hold and `f`/`j` their Ctrl hold even mid-burst.)

## Install

Needs `kanata.exe` (v1.10.1+, [releases](https://github.com/jtroo/kanata/releases)) on your PATH. Then:

```powershell
# config → %USERPROFILE%, launcher → Startup folder (starts kanata silently at every login)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/wins.kbd" -OutFile "$Home\wins.kbd"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/wins/katana.bat" -OutFile "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\kanata.bat"
```

Run the downloaded `kanata.bat` once (or log off/on), then test: hold left Alt + `c` → Ctrl+C (left Alt is Ctrl now), and hold `x` + `k` → ↑ (NAV).

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold left Alt (= Ctrl) + `c` / `v` / `x` / `z` |
| …or classic style | hold Caps (= Ctrl) + `c`/`v`/`x`/`z`/`w`… |
| Alt+Tab | hold right Alt + Tab, release to switch (it's a real Alt now) |
| Close window (Alt+F4) | hold `z` (FUN), tap `s` (one-shot Alt), tap `v` (F4) |
| Reopen tab (Ctrl+Shift+T) | NUM (hold left Win): tap `f`, tap `d`, release, press `t` |
| Move word left / right | `j`+`k` = Ctrl+← · `d`+`f` = Ctrl+→ |
| Emacs-style arrows | hold `x` / `.` (NAV): `n`/`p`/`f`/`b` = ↓/↑/→/← · `a`/`e` = Home/End |
| Vim-style arrows | hold `x` / `.` (NAV): `h`/`j`/`k`/`l` = ←/↓/↑/→ · `d`/`u` = PgDn/PgUp |
| Next / previous browser tab | hold `x` / `.` (NAV) + `r` / hold Caps + Shift, tap Tab |
| Browser back / forward | hold `x` / `.` (NAV) + `g` / `t` |
| Arrows, PgUp/PgDn, Home/End | hold `x` / `.` (NAV) |
| Switch input language | tap left Ctrl |
| Start menu | tap left Win |
| Win+E, Win+R, Win+D… | NUM: tap `a` (one-shot Win), release, press the letter |
| Screenshot (Win+Shift+S) | NUM: tap `a`, tap `d`, release, press `s` |
| Select text | hold real Shift + NAV arrows |
| Type ALL_CAPS | `d`+`k` together → Caps Word; Space or a digit ends it |
| Type a number / amount | `m`+`,`+`.` together → Num Word; Space types 0 and stays on |
| Esc / Tab / Enter / Backspace | combos `q·w` / `a·s` / `l·;` / `o·p` |
| F-keys | hold `z` / `/` (FUN): bottom row = F1–F10 |
| Caps Lock, actually | FUN layer + Space |
| Esc | tap Caps Lock |
| Normal keyboard (lend laptop, games) | `q`+`w`+`e`+`r` together = muggle mode; same to come back |
| Kill kanata entirely | hold physical `LCtrl + Space + Esc` |

## Layer maps

`os` = one-shot modifier (applies to the next key). `·` = nothing.

### DEF — base layer

```
tap:   q   w   e   r   t        y   u   i   o   p
       a   s   d   f   g        h   j   k   l   ;
       z   x   c   v   b        n   m   ,   .   /

hold:  ·   ·   ·   ·   ·        ·   ·   ·   ·   ·
       Win Alt Sft Ctl Hyp      Hyp Ctl Sft Alt Win
       FUN NAV NUM SYM ·        ·   SYM NUM NAV FUN

thumbs:  [Lang|Alt]  [Win|NUM] [Ctrl] [Space] [Alt]
         (LCtrl)     (LWin)    (LAlt)         (RAlt)
caps:    [Esc|Ctrl]
```

### NAV — hold `x` / `.`

```
Esc    Tab      End    Tab→   Fwd→        C-v    PgUp  Tab   Bksp  ↑
Home   C-s      PgDn   →      ←Back       ←      ↓     ↑     →     Enter
C-z    C-x      C-c    C-v    ←           ↓      Media Vol−  Vol+  Del
```

Reach NAV by holding `x` or `.` (the left-Alt thumb is plain Ctrl now). For Alt+Tab, hold the right-Alt thumb and tap Tab — it's a real Alt, so it works like stock Windows. `Media` tap-dance: 1 tap = play/pause, hold = mute, 2 taps = next, 3 = previous. Emacs-style nav: `n p f b a e` = ↓ ↑ → ← Home End, mirroring `C-n/p/f/b/a/e` — same keys, on NAV instead of with Ctrl. Vim-style too: `h j k l` = ← ↓ ↑ →, with `d`/`u` = PgDn/PgUp (like `C-d`/`C-u`).

### SYM — hold `v` / `m`

```
'      {      [      (      %         &     )     ]     }     "
-      ^      `      ~      $         #     osCtl osSft osAlt osWin
+      =      *      /      @         |     \     ?     !     :

                            Space = _
```

Reach SYM by holding `v` or `m` (the right-Alt thumb is plain Alt now); `v` is the comfortable side for the right-hand symbols and one-shot mods.

### NUM — hold left Win (or hold `c` / `,`)

```
(      )      ·      R$     ·         +     7     8     9     *
osWin  osAlt  osSft  osCtl  Bksp      -     4     5     6     /
·      osSft  ·      000    ,000      ,     1     2     3     .

                            Space = 0

thumbs:  [·] [·] [tap: exit | hold: NAV] [Space: 0] [tap: 0 | hold: SYM]
```

Ctrl+5 = `f` then `5`. `000`/`,000` are typing macros; `R$` types "R$ " — edit or delete in the config. In NUM, Space types **0** and never exits — leave NUM by releasing the hold (`c`, `,`, or left Win), tapping the NAV thumb, or pressing `m`+`,`+`.` again.

### FUN — hold `z` / `/`

```
1      2      3      4      5         6     7     8     9     0
osWin  osAlt  osSft  osCtl  F11       F12   osCtl osSft osAlt osWin
F1     F2     F3     F4     F5        F6    F7    F8    F9    F10

                        Space = Caps Lock
```

The config-reload combo `g`+`h` only works on this layer.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing.

| Combo | Result |
|---|---|
| `q w` | Esc |
| `a s` | Tab |
| `l ;` | Enter |
| `o p` | Backspace |
| `s d` / `k l` | Delete word back (Ctrl+Backspace) |
| `d k` | Caps Word on/off |
| `d f` / `j k` | Move word right / left (Ctrl+→ / Ctrl+←) |
| `z x` / `x c` / `c v` | Cut / Copy / Paste (Ctrl+`X` / `C` / `V`) |
| `m , .` | Num Word on/off |
| `f` / `s` / `d` + right Alt | `~` / `^` / `` ` `` |
| `q w e r` | Muggle mode on/off |
| `g h` (FUN layer only) | live-reload the config |

## One-shot mods

NUM, SYM (right hand), and FUN have the full `osWin osAlt osSft osCtl` home row; NAV keeps only `osAlt` on `s` (its `a`/`d`/`f` are now Home/PgDn/→). **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Win+E = NUM → tap `a` → release → `e`. Alt+F4 = hold `z` → tap `s` → tap `v`.

## Caps Word and Num Word

**Caps Word** (`d`+`k`): next letters come out capitalized, no Shift held. Ends on Space, Enter, a digit, or 5 s idle; survives apostrophes, Backspace, and the `~ ^ ` `` combos — for underscores, hold `d`/`k` instead.

**Num Word** (`m`+`,`+`.`): sticky NUM layer, no key held. Space types a **0** and stays on; tap the NAV thumb (or `m`+`,`+`.` again) to exit. The right-hand combos (`l·;` = Enter, `o·p` = Backspace) stay available.

## Quick start

Needs Windows 10/11 and **kanata v1.10.1+** ([releases](https://github.com/jtroo/kanata/releases)).

1. Validate: `kanata.exe --cfg wins.kbd --check`
2. Run: `kanata.exe --cfg wins.kbd` — **as administrator** if you want remaps inside elevated apps
3. Test: hold left Alt + `c` → Ctrl+C; hold `x` + `k` → ↑ (NAV); tap Caps Lock → Esc.

**Autostart:** covered by the [Install](#install) section's `kanata.bat`. If you want it elevated (remaps in admin apps) without a UAC prompt, use Task Scheduler instead: trigger "At log on", check "Run with highest privileges".

**After editing the config:** run `--check`, then restart kanata or live-reload: hold `z`/`/` (FUN) and press `g`+`h`. A failed reload keeps the previous good config running.

## What's remapped

Only 37 keys. Number row, F-row, Esc, Enter, Backspace, Shift, arrows, Delete, right Ctrl, and Fn are untouched. Tab is plain Tab everywhere (the old NAV Alt-Tab swapper is gone — use the right-Alt thumb for Alt+Tab).

| Physical key | Tap | Hold |
|---|---|---|
| Caps Lock | Esc | Ctrl |
| Left Ctrl | switch language (Win+Space) | **Alt** |
| Left Win | Win (Start menu) | **NUM** |
| Left Alt | (quick Ctrl) | **Ctrl** |
| Right Alt | (quick Alt) | **Alt** |
| `a s d f` / `j k l ;` | the letter | Win Alt Shift Ctrl / Ctrl Shift Alt Win |
| `g` / `h` | the letter | Hyper (Ctrl+Alt+Shift+Win) |
| `z` / `c` | the letter | **FUN** / **NUM** |
| `/` / `,` | the symbol | **FUN** / **NUM** |
| `x` / `.` | the letter / symbol | **NAV** |
| `v` / `m` | the letter | **SYM** |

## Troubleshooting

- **"Where did the layers on my Alt keys go?"** The Alt thumbs are plain modifiers now — **left Alt = Ctrl, right Alt = Alt**. The layers moved to letter-holds: NAV = hold `x`/`.`, SYM = hold `v`/`m`, FUN = hold `z`/`/`. Alt+Tab = hold right Alt + Tab.
- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Start menu pops up randomly."** You held `a` and released it with no other key — that's a Win tap. Press Esc.
- **"A weird Office thing opened."** Tapping `g`/`h`'s Hyper hold alone is Windows' "Office key". Harmless; change `@hyper` to `XX` if unused.
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

[urob's ZMK config](https://github.com/urob/zmk-config) (the timerless design), sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/), the macOS kanata config this was ported from, and [jtroo/kanata](https://github.com/jtroo/kanata) itself.
