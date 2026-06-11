# wins.kbd — Windows kanata config

A [kanata](https://github.com/jtroo/kanata) config for Windows with urob-style "timerless" home row mods: type as fast as you want with zero misfires and zero letter reordering, while keeping all four modifiers plus navigation, symbol, number, and function layers on the home position.

**The one rule:** while you're typing, the home row is just letters — mods only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold → press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J). Same-hand mod+letter never chords — use a one-shot or hold the mod a full 0.3 s first. (Exception: `d`/`k` keep their Shift hold even mid-burst.)

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold left Alt (NAV) + `c` / `v` / `x` / `z` |
| …or classic style | hold Caps (= Ctrl) + `c`/`v`/`x`/`z`/`w`… |
| Alt+Tab | hold left Alt (NAV), tap `w` repeatedly, release Alt to switch |
| Close window (Alt+F4) | hold `z` (FUN), tap `s` (one-shot Alt), tap `v` (F4) |
| Reopen tab (Ctrl+Shift+T) | NAV: tap `f`, tap `d`, release, press `t` |
| Next / previous browser tab | NAV + `r` / NAV + `e` |
| Browser back / forward | NAV + `g` / NAV + `t` |
| Arrows, PgUp/PgDn, Home/End | hold left Alt (NAV), right hand |
| Switch input language | tap left Ctrl |
| Start menu | tap left Win |
| Win+E, Win+R, Win+D… | NAV: tap `a` (one-shot Win), release NAV, press the letter |
| Screenshot (Win+Shift+S) | NAV: tap `a`, tap `d`, release NAV, press `s` |
| Select text | NAV: tap `d` (one-shot Shift), then arrows on NAV |
| Type ALL_CAPS | `d`+`k` together → Caps Word; Space or a digit ends it |
| Type a number / amount | `m`+`,`+`.` together → Num Word; Space exits automatically |
| Esc / Tab / Enter / Backspace | combos `w·e·r` / `w·r` / `s·d·f` / `s·f` (right hand: `u·i·o` / `u·o` / `j·k·l` / `j·l`) |
| F-keys | hold `z` or both Alts: bottom row = F1–F10 |
| Caps Lock, actually | FUN layer + Space |
| Esc | tap Caps Lock |
| Normal keyboard (lend laptop, games) | `q`+`w`+`e`+`r` together = muggle mode; same to come back |
| Kill kanata entirely | hold physical `LCtrl + Space + Esc` |

## Layer maps

`os◌` = one-shot modifier (applies to the next key). `·` = nothing.

### DEF — base layer

```
tap:   q   w   e   r   t        y   u   i   o   p
       a   s   d   f   g        h   j   k   l   ;   '
       z   x   c   v   b        n   m   ,   .   /

hold:  ·   ·   ·   ·   ·        ·   ·   ·   ·   ·
       Win Alt Sft Ctl Hyp      Hyp Ctl Sft Alt Win ·
       FUN ·   NUM ·   ·        ·   ·   ·   ·   ·

thumbs:  [Lang|Ctrl] [Win|NUM] [NAV] [Space] [SYM]
caps:    [Esc|Ctrl]
```

### NAV — hold left Alt

```
Tab    Swapper  Tab←   Tab→   Fwd→        PgUp   Home  ↑     End   Bksp
osWin  osAlt    osSft  osCtl  ←Back       PgDn   ←     ↓     →     Enter
C-z    C-x      C-c    C-v    F18         Media  F19   Vol−  Vol+  Del
```

`Media` tap-dance: 1 tap = play/pause, hold = mute, 2 taps = next, 3 = previous. `F18`/`F19` are spare keys for your own bindings.

### SYM — hold right Alt

```
Esc   {   [   (   %        &   )   ]   }   "
 -    ^   `   ~   $        #  osCtl osSft osAlt osWin
 +    =   *   /   @        |   \   ?   !   :
                      Space = _
```

### NUM — hold left Win (or hold `c`)

```
 (    )    ·    R$   ·        +   7   8   9   *
osWin osAlt osSft osCtl Bksp   -   4   5   6   /
 ·   osSft  ·   000  ,000     ,   1   2   3   .

thumbs:  [·] [·] [tap: exit | hold: NAV] [Space: exit / 0 while c held] [tap: 0 | hold: SYM]
```

Ctrl+5 = `f` then `5`. `000`/`,000` are typing macros; `R$` types "R$ " — edit or delete in the config. While NUM is held via `c`, Space types **0**; via left Win or Num Word, Space still exits.

### FUN — hold both Alts (or hold `z`)

```
 1    2    3    4    5         6    7    8    9    0
osWin osAlt osSft osCtl F11    F12 osCtl osSft osAlt osWin
 F1   F2   F3   F4   F5        F6   F7   F8   F9   F10

                Space = Caps Lock
```

The config-reload combo `g`+`h` only works on this layer.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing.

| Combo | Result |
|---|---|
| `w e r` / `u i o` | Esc |
| `w r` / `u o` | Tab |
| `s d f` / `j k l` | Enter |
| `s f` / `j l` | Backspace |
| `d k` | Caps Word on/off |
| `m , .` | Num Word on/off |
| `f` / `s` / `d` + right Alt | `~` / `^` / `` ` `` |
| `q w e r` | Muggle mode on/off |
| `g h` (FUN layer only) | live-reload the config |

## One-shot mods

Every layer's home row has `osWin osAlt osSft osCtl` (and mirrored on the right where shown). **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Win+E = NAV → tap `a` → release → `e`. Alt+F4 = hold `z` → tap `s` → tap `v`.

## Caps Word and Num Word

**Caps Word** (`d`+`k`): next letters come out capitalized, no Shift held. Ends on Space, Enter, a digit, or 5 s idle; survives apostrophes, Backspace, and the `~ ^ ` `` combos — for underscores, hold `d`/`k` instead.

**Num Word** (`m`+`,`+`.`): sticky NUM layer, no key held. Space exits and types the space; tap the NAV thumb to exit silently. The right-hand combos (`u·o` = Tab, `j·l` = Backspace) stay available.

## Quick start

Needs Windows 10/11 and **kanata v1.10.1+** ([releases](https://github.com/jtroo/kanata/releases)).

1. Validate: `kanata.exe --cfg wins.kbd --check`
2. Run: `kanata.exe --cfg wins.kbd` — **as administrator** if you want remaps inside elevated apps
3. Test: hold left Alt + `i` → ↑. Tap Caps Lock → Esc.

**Autostart:** `Win+R` → `shell:startup` → drop in a shortcut with target `C:\path\to\kanata.exe --cfg C:\path\to\wins.kbd`. For elevated without UAC prompts, use Task Scheduler ("At log on", "Run with highest privileges").

**After editing the config:** run `--check`, then restart kanata or live-reload: hold both Alts (FUN) and press `g`+`h`. A failed reload keeps the previous good config running.

## What's remapped

Only 37 keys. Number row, F-row, Esc, Tab, Enter, Backspace, Shift, arrows, Delete, right Ctrl, and Fn are untouched.

| Physical key | Tap | Hold |
|---|---|---|
| Caps Lock | Esc | Ctrl |
| Left Ctrl | switch language (Win+Space) | Ctrl |
| Left Win | Win (Start menu) | **NUM** |
| Left Alt | — | **NAV** |
| Right Alt | — | **SYM** |
| Both Alts | — | **FUN** |
| `a s d f` / `j k l ;` | the letter | Win Alt Shift Ctrl / Ctrl Shift Alt Win |
| `g` / `h` | the letter | Hyper (Ctrl+Alt+Shift+Win) |
| `z` / `c` | the letter | **FUN** / **NUM** |

## Troubleshooting

- **"My Alt key doesn't work."** It's a layer key now: left = NAV, right = SYM, both = FUN. The Alt *modifier* is on `s`/`l`; Alt+Tab is NAV+`w`.
- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot.
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
