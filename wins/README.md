# wins.kbd — Windows kanata config manual

A [kanata](https://github.com/jtroo/kanata) configuration for Windows implementing **urob-style "timerless" home row mods**: type as fast as you want with zero misfires and zero letter reordering, while still getting all four modifiers on your home row, plus navigation, symbol, number, and function layers — all without moving your hands.

Ported and adapted from a macOS config (credits at the bottom). The headline fix over the previous version of this config: letters can no longer come out in the wrong order (the old `"os"` → `"so"` bug), because every key is now sequenced through kanata and home row mods are disarmed while you're actively typing.

---

## Contents

1. [Requirements](#requirements)
2. [Quick start](#quick-start)
3. [Emergency controls](#emergency-controls)
4. [The layout at a glance](#the-layout-at-a-glance)
5. [The one core concept](#the-one-core-concept-type-fast--letters-pause--mods)
6. [Layer maps](#layer-maps)
7. [Everyday shortcuts cheat sheet](#everyday-shortcuts-cheat-sheet)
8. [Combos](#combos)
9. [One-shot mods](#one-shot-mods)
10. [Caps Word and Num Word](#caps-word-and-num-word)
11. [The Alt-Tab swapper](#the-alt-tab-swapper)
12. [Muggle mode](#muggle-mode)
13. [Troubleshooting & FAQ](#troubleshooting--faq)
14. [Tuning knobs](#tuning-knobs)
15. [The config, line by line](#the-config-line-by-line)
16. [Credits](#credits)

---

## Requirements

- Windows 10/11
- **kanata v1.10.1 or newer** (this config uses `tap-hold-release-tap-keys-release` and `chords-v2-min-idle`, which older versions don't know; it was validated against v1.11.0)
- A standard keyboard. The bottom row this config expects is: `Ctrl  Fn  Win  Alt  Space  Alt  Ctrl` — the common laptop layout. `Fn` is hardware and invisible to software; it keeps working as always. Right `Ctrl` is deliberately left untouched as an always-normal Ctrl.

## Quick start

1. Download `kanata.exe` from the [kanata releases page](https://github.com/jtroo/kanata/releases) (the `kanata_gui.exe` variant adds a tray icon, if you prefer that).
2. Put `wins.kbd` somewhere permanent (e.g. next to `kanata.exe`).
3. Validate the config:

   ```
   kanata.exe --cfg wins.kbd --check
   ```

4. Run it:

   ```
   kanata.exe --cfg wins.kbd
   ```

   Run the terminal **as administrator** if you want the remaps to work inside elevated apps (Task Manager, admin terminals, installers).

5. Sanity test: hold the **left Alt** key and press `i` — you should get an arrow key (↑). Tap **Caps Lock** — you should get Esc.

**Start automatically at login:** press `Win+R`, type `shell:startup`, Enter — then put a shortcut to `kanata.exe` in that folder and set the shortcut's target to:

```
C:\path\to\kanata.exe --cfg C:\path\to\wins.kbd
```

If you want it elevated without a UAC prompt at every login, use Task Scheduler instead: create a task triggered "At log on", check "Run with highest privileges", action = start `kanata.exe` with the `--cfg` argument.

**Editing the config later:** edit `wins.kbd`, run `--check`, then either restart kanata or use the live-reload combo: hold **both Alt keys** (FUN layer) and press `g`+`h` together. If a reload fails to parse, kanata keeps running with the previous good config.

## Emergency controls

- **Panic exit (built into kanata):** press and hold physical `Left Ctrl + Space + Esc` together — kanata terminates and your keyboard is instantly back to stock. If that ever doesn't respond, close kanata's window or kill it from Task Manager (which is one reason to know it: `Ctrl+Shift+Esc` still works via the physical right Ctrl + Caps... or just use the mouse).
- **Hand the laptop to someone else:** press `q+w+e+r` together — *muggle mode*, a completely normal keyboard. Same combo to come back.

---

## The layout at a glance

Only **37 keys** are remapped. Everything else — the number row, F-row, Esc, Tab, Enter, Backspace, Shift, arrows, Delete, right Ctrl, your Fn key — is completely normal.

| Physical key | Tap | Hold |
|---|---|---|
| Caps Lock | Esc | Ctrl |
| Left Ctrl | switch language (Win+Space) | Ctrl |
| Left Win | Win (Start menu) | **NUM** layer |
| Left Alt | — | **NAV** layer |
| Space | space | — |
| Right Alt | — | **SYM** layer |
| Left Alt + Right Alt | — | **FUN** layer |
| Right Ctrl | Ctrl (untouched) | Ctrl |
| `a s d f` / `j k l ;` | the letter | Win Alt Shift Ctrl / Ctrl Shift Alt Win |
| `g` / `h` | the letter | Hyper (Ctrl+Alt+Shift+Win) |
| `z` | z | **FUN** layer |
| `c` | c | **NUM** layer |

## The one core concept: type fast = letters, pause = mods

Everything about this config flows from one rule:

> **While you are actively typing, the home row is just letters. Modifiers only "arm" after you stop for 250 ms.**

Every keystroke silently flips the keyboard onto a mod-free layer (`nomods`) and starts a 250 ms timer; while you keep typing, the timer keeps resetting. This is why nothing can misfire and nothing can come out in the wrong order mid-word — there is literally no tap-hold logic running during a burst of typing. (Exception: `d` and `k` keep their Shift hold even mid-burst, so you can capitalize without pausing.)

So the rhythm for using a modifier is: **tiny pause → hold → press**. A quarter second is shorter than it sounds — it's the natural pause before most deliberate shortcuts anyway.

Two more rules worth internalizing:

- **Cross-hand chords are instant.** Pause, then press `f`+`j` together at natural speed → Ctrl+J. No waiting for timers — releasing the second key resolves it.
- **Same-hand combos need patience or one-shots.** Pressing a normal letter on the *same hand* as a pending mod always produces letters (that's the anti-misfire protection). To get Win+E (both left hand): either hold `a` for a full 0.3 s *then* press `e`, or — much nicer — use a one-shot: hold NAV, tap `a`, release, press `e`. See [One-shot mods](#one-shot-mods).

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

Arrows under your right hand (`j k l` row), Backspace/Enter/Delete on the pinky column, PgUp/PgDn/Home/End around them. Left hand: `Tab`, the [Alt-Tab swapper](#the-alt-tab-swapper) on `w`, previous/next browser tab on `e`/`r`, browser back/forward on `g`/`t`, undo–cut–copy–paste on `z x c v`, one-shot mods on the home row. `Media` is a tap-dance: 1 tap = play/pause, hold = mute, 2 taps = next track, 3 = previous. `F18`/`F19` are spare keys — bind them to anything (PowerToys, AutoHotkey, app shortcuts).

### SYM — hold right Alt

```
Esc   {   [   (   %        &   )   ]   }   "
 -    ^   `   ~   $        #  osCtl osSft osAlt osWin
 +    =   *   /   @        |   \   ?   !   :
                      Space = _
```

Openers under the left hand, closers mirrored on the right. Space types underscore — `snake_case` without leaving the layer.

### NUM — hold left Win (or hold `c`)

```
 (    )    ·    R$   ·        +   7   8   9   *
osWin osAlt osSft osCtl Bksp   -   4   5   6   /
 ·   osSft  ·   000  ,00       ,   1   2   3   .

thumbs:  [·] [·] [tap: exit | hold: NAV] [Space: exit] [tap: 0 | hold: SYM]
```

A numpad under your right hand. One-shot mods on the left home row mean Ctrl+5 is just `f` then `5`. `000` and `,00` are typing macros; `R$` types "R$ " (the original author's currency — edit or delete it in the config). This layer is also what **Num Word** activates — see below.

### FUN — hold both Alts (or hold `z`)

```
 1    2    3    4    5         6    7    8    9    0
osWin osAlt osSft osCtl F11    F12 osCtl osSft osAlt osWin
 F1   F2   F3   F4   F5        F6   F7   F8   F9   F10

                Space = Caps Lock
```

The real number row on top, F1–F10 on the bottom row, F11/F12 inboard. One-shots on both home rows make Alt+F4 or Shift+F5 one-handed. Space here is the only remaining true Caps Lock. The config-reload combo `g`+`h` only works on this layer.

## Everyday shortcuts cheat sheet

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold left Alt (NAV) + `c` / `v` / `x` / `z` — single-finger, no Ctrl needed |
| …or classic style | hold Caps + `c`/`v`/`x`/`z`, or pause-hold `j` (Ctrl) + key cross-hand |
| Alt+Tab | hold left Alt (NAV), tap `w` repeatedly, release Alt to switch |
| Close window (Alt+F4) | hold `z` (FUN), tap `s` (one-shot Alt), tap `v` (F4) |
| Close tab (Ctrl+W) | hold Caps + `w` |
| Reopen tab (Ctrl+Shift+T) | hold Caps, hold `k` (Shift), tap `t` — or NAV: tap `f`, tap `d`, release, press `t` |
| Next / previous browser tab | NAV + `r` / NAV + `e` |
| Browser back / forward | NAV + `g` / NAV + `t` |
| Switch input language | tap left Ctrl |
| Start menu | tap left Win |
| Win+E, Win+R, Win+D… | NAV: tap `a` (one-shot Win), release NAV, press the letter |
| Screenshot (Win+Shift+S) | NAV: tap `a`, tap `d`, release NAV, press `s` |
| Select text by character/word | NAV: tap `d` (one-shot Shift) — or hold `d` after a pause — then arrows on NAV |
| Type ALL_CAPS_LIKE_THIS | `d`+`k` together → Caps Word (Space ends it; `_` via SYM doesn't… see note below) |
| Type a number or amount | `m`+`,`+`.` together → Num Word; type `4,99` then Space exits automatically |
| Esc / Tab / Enter / Backspace without reaching | combos: `w·e·r` / `w·r` / `s·d·f` / `s·f` (and mirrored on the right hand) |
| F-keys | hold `z` or both Alts, bottom row = F1–F10 |
| Caps Lock, actually | FUN layer + Space |

> Caps Word note: it survives letters, `'`, `` ` ``, Backspace, and the `~ ^ ` `` combos, but a Space or digit ends it. For constants with underscores, type the words and add underscores after, or just hold `d`/`k`.

## Combos

Press the listed keys **together** (within 60 ms). To prevent accidents, combos only fire if the keyboard was idle for ≥350 ms first, and they're disabled entirely while the fast-typing protection (`nomods`) is active.

| Combo | Result |
|---|---|
| `w e r` | Esc |
| `w r` | Tab |
| `s d f` | Enter |
| `s f` | Backspace |
| `u i o` | Esc (right hand) |
| `u o` | Tab (right hand) |
| `j k l` | Enter (right hand) |
| `j l` | Backspace (right hand) |
| `d k` | Caps Word on/off |
| `m , .` | Num Word on/off |
| `f` + right Alt | `~` |
| `s` + right Alt | `^` |
| `d` + right Alt | `` ` `` |
| `q w e r` | Muggle mode on/off |
| `g h` (FUN layer only) | live-reload the config |

The right-hand Esc/Tab/Enter/Backspace mirrors are especially nice during Num Word, when your left hand is free.

## One-shot mods

On every layer's home row you'll find `osWin osAlt osSft osCtl` (left hand, pinky→index) and the mirror on the right where shown. **Tap** one and it applies to your *next* keypress only; tap several and they stack; hold one and it behaves like a regular modifier. They stay armed for up to 60 s or until used, and they survive releasing the layer key — that's deliberate.

This is the answer to every "mod + same-hand key" situation:

- Win+E: NAV → tap `a` → release → `e`
- Ctrl+Shift+P: NAV → tap `f`, tap `d` → release → `p`
- Alt+F4: FUN (hold `z`) → tap `s` → tap `v`

No timing, no holding, no misfires.

## Caps Word and Num Word

**Caps Word** (`d`+`k`): the next letters come out capitalized, no Shift held. Auto-ends on Space, Enter, a digit, or 5 s of inactivity; survives apostrophes, Backspace, and the `~ ^ ` `` combos. Perfect for SCREAMING_SNAKE… up to the underscore, anyway.

**Num Word** (`m`+`,`+`.`): switches to the NUM layer *sticky* — no key held. Type your number; **Space exits and types the space**, or tap the NAV thumb to exit silently, or `m , .` again to toggle off. While in it, the right-hand combos (`u·o` = Tab, `j·l` = Backspace) keep your flow.

## The Alt-Tab swapper

Hold left Alt (NAV) and tap `w`: the Windows app switcher opens. Each further tap of `w` advances one window. Release left Alt → you land on the selected window. Under the hood kanata holds a *virtual* Alt for you and taps Tab on every press — one finger, proper Alt-Tab semantics.

(Plain old Alt+Tab as a chord doesn't exist anymore, since both Alt keys are layer thumbs. The swapper replaces it; Alt itself lives on `s`/`l`.)

## Muggle mode

`q+w+e+r` together toggles a 100% stock keyboard — every key literal, no layers, no mods, no combos (except the same four keys to come back). For lending your machine or for games that hate remappers. Note Caps Lock is also literal here, and the `d+k`/`g+h` combos technically remain live, faithful to the original config.

---

## Troubleshooting & FAQ

**"My Alt key doesn't work."**
It does — it's a layer key now. Holding left Alt is NAV (try Alt+`i` → ↑), right Alt is SYM (try it with `f` → `(` ), both together is FUN. The Alt *modifier* moved to the home row: pause, then hold `s` or `l`. Alt+Tab is NAV+`w`. One genuinely lost behavior: *tapping* Alt to focus an app's menu bar — ask and it's a two-line change to bring back (tap = Alt, hold = NAV).

**"Home row mods don't trigger / I get letters instead of shortcuts."**
You're not pausing first. Mods arm 250 ms after your last keystroke — stop, then hold. If it still types letters: you're probably combining a mod with a *same-hand* letter (e.g. `a`+`e` for Win+E); that's the anti-misfire rule. Use a one-shot (NAV → tap `a` → `e`) or hold the mod a full 0.3 s first.

**"Letters still come out swapped."**
They shouldn't — this is exactly what the config fixes. If it happens, kanata is probably not running, or running an old config. Check the console window, run `--check`, confirm you launched with `--cfg wins.kbd`.

**"The Start menu pops up randomly."**
You held `a` past the tapping term and released it without pressing another key — that's a Win-tap. It's the classic cost of Win-on-pinky. Mitigations: press Esc, or get used to it, or swap the mod order in the config (see [Tuning knobs](#tuning-knobs)).

**"A weird Office thing opened."**
You tapped `g` or `h`'s hold (Hyper = Ctrl+Alt+Shift+Win) with no other key; Windows treats that chord alone as the "Office key". Harmless. If you never use Hyper, change `@hyper` to `XX` on those two lines, or bind Hyper to useful things via PowerToys/AutoHotkey so it earns its keep.

**"I need AltGr for my second language."**
Right Alt is currently the SYM thumb, so AltGr is consumed. Say the word and the SYM thumb can move (e.g. to right Ctrl or the menu key) — one `defsrc` + layer-row edit.

**"Remaps don't work in Task Manager / admin windows."**
Run kanata as administrator (see Quick start).

**"I edited the config and now it won't load."**
`kanata.exe --cfg wins.kbd --check` tells you the line and reason. If you live-reloaded a broken config, kanata keeps the previous working one in memory — fix and reload again.

**"How do I turn it all off for a second?"**
`q w e r` for muggle mode, or `LCtrl+Space+Esc` to kill kanata entirely.

## Tuning knobs

All in the `defvar` block unless noted:

- `tapping-term 300` — lower (e.g. 250/200) = mods trigger faster when held, at slightly higher misfire risk.
- `require-prior-idle 250` — lower = mods re-arm sooner after typing; raise if you ever get a mod when you wanted a letter at the start of a burst.
- `one-shot-timeout 60000` — how long one-shots stay armed.
- `chords-v2-min-idle 350` — lower if combos feel like they need too long a pause.
- Mod order: edit the ten `a`–`;` alias lines (and mirror the `@osm @osa @oss @osc` rows in each layer) to swap GASC for another arrangement.
- `r$` macro: author's "R$ " — change to your currency or delete it (and its spot in the NUM layer).

---

## The config, line by line

### How to read kanata syntax (30 seconds)

- Everything is `(parentheses lists)`. `;;` starts a comment that runs to the end of the line.
- `defcfg` = global settings, `defvar` = variables, `deftemplate` = reusable snippets, `defalias` = named actions, `defsrc` = which physical keys kanata takes over, `deflayer` = what those keys do, `defchordsv2` = combos, `defvirtualkeys` = invisible helper keys.
- `@name` uses an alias. `$name` uses a variable. `(t! template args)` expands a template.
- In a layer: `_` = transparent (falls through to the `def` layer, because of `delegate-to-first-layer`), `XX` = do nothing.
- Prefixes on keys: `S-` Shift, `C-` Ctrl, `A-` Alt, `M-` Meta/Win. So `S-9` = `(`, `C-tab` = Ctrl+Tab, `M-spc` = Win+Space.
- Key names: `grv` = `` ` ``, `lbrc`/`rbrc` = `[` `]`, `bspc` = Backspace, `lmet`/`rmet` = left/right Win, `lsft`/`rsft` = Shift, `nop0`…`nop9` = keys that output nothing (used as invisible markers).

### Header

```lisp
;; kanata config — Windows port of the urob-style "timerless" home row mods setup
;; Adapted from a macOS config; Windows-specific changes are marked with [win].
;;
;; Run:    kanata.exe --cfg wins.kbd          (run terminal as admin for elevated apps)
;; Check:  kanata.exe --cfg wins.kbd --check  (validate after any edit)
```

Just comments. The `--check` flag parses the config and reports errors without remapping anything — run it after every edit.

### defcfg — global settings

```lisp
(defcfg
  process-unmapped-keys yes
```
**This is the line that fixes the "os" → "so" bug.** With `no` (the old config), keys not listed in `defsrc` bypassed kanata and reached Windows instantly, while home-row keys sat in kanata's queue waiting for a tap-vs-hold decision — so a later key could overtake an earlier one. With `yes`, every key goes through kanata's queue, so output order always matches press order.

```lisp
  block-unmapped-keys no
```
With `yes`, keys not in `defsrc` would be silenced entirely. `no` lets them work normally (F-keys, arrows, Enter, etc.).

```lisp
  log-layer-changes no
```
Don't spam the console on every layer change. Cosmetic.

```lisp
  concurrent-tap-hold yes
```
Lets multiple tap-hold keys be "in flight" at once. Required for the `defchordsv2` combos to coexist with home-row mods, and for chording two mods (e.g. `f`+`d` for Ctrl+Shift).

```lisp
  delegate-to-first-layer yes
```
Defines what `_` (transparent) means: fall through to the **first layer** (`def`), not to the raw physical key. So `_` on the Caps position in any layer still gives tap-Esc/hold-Ctrl, not raw Caps Lock.

```lisp
  chords-v2-min-idle 350
)
```
Combos only fire if the keyboard was idle ≥350 ms beforehand — ZMK's `require-prior-idle`, but for combos. It's why typing "wer" fast never triggers the w+e+r = Esc combo.

### defvar — variables

```lisp
(defvar
  one-shot-timeout 60000
```
One-shot mods stay armed up to 60 seconds. Bonkers, as the original author said, but harmless: a one-shot is consumed by your next keypress anyway.

```lisp
  tapping-term 300
```
Hold a home-row key 300 ms with nothing else deciding the outcome → it becomes a modifier. Generous on purpose: the positional rules decide long before 300 ms in normal typing, and a long term means fewer accidental holds.

```lisp
  quick-tap-ms 200
```
Tap a home-row key, then press it **again within 200 ms** → it repeats the letter instead of becoming a mod. This keeps key autorepeat ("ssssss") on mod keys.

```lisp
  require-prior-idle 250
```
After any keypress, home-row mods stay disarmed until you've paused 250 ms. The heart of the misfire/reordering fix — see the `tap` alias.

```lisp
  combo-timeout 60
```
All keys of a combo must go down within 60 ms of each other.

```lisp
  left-side-keys   (q w e r t x c v b)
  right-side-keys  (y u i o p n m , . / ')
```
The "instant tap" lists. While a left-hand home-row key is undecided, pressing any `left-side-keys` key instantly resolves it as a **letter** (same on the right). Translation: a same-hand roll like `s`→`t` can never become Alt+T. (Consequence: chording a mod with a same-hand letter from these lists requires holding past 300 ms first — or a one-shot.)

```lisp
  home-row-left-keys  (a s d f g z)
  home-row-right-keys (h j k l ;)
)
```
The "decide by release order" lists — the other home-row mod keys on the same hand. Roll `a`→`s` and release in order → you typed "as". Press `s` and it goes down **and up while you're still holding** `a` → deliberate chord → Win+S. This is what makes same-hand mod stacks possible without breaking rolls.

### Templates — the home-row-mod recipe

```lisp
(deftemplate lhrm (tappingterm tap-key hold-key)
  (tap-hold-release-tap-keys-release $quick-tap-ms $tappingterm (multi $tap-key @tap) $hold-key $left-side-keys $home-row-left-keys)
)
```
A template is a fill-in-the-blanks snippet; `lhrm` = left home row mod. The six arguments of `tap-hold-release-tap-keys-release`, in order:

1. `$quick-tap-ms` (200) — re-press-to-repeat window
2. `$tappingterm` (300) — hold this long → modifier
3. `(multi $tap-key @tap)` — the **tap** action: the letter itself plus the `@tap` bookkeeping
4. `$hold-key` — the **hold** action: the modifier
5. `$left-side-keys` — press any of these while undecided → instant tap
6. `$home-row-left-keys` — these decide by release order

```lisp
(deftemplate rhrm (tappingterm tap-key hold-key)
  (tap-hold-release-tap-keys-release $quick-tap-ms $tappingterm (multi $tap-key @tap) $hold-key $right-side-keys $home-row-right-keys)
)
```
Identical, with the right-hand lists.

```lisp
(deftemplate nomod (tap-key)
  (multi $tap-key @tap)
)
```
For ordinary letters: output the key **and** run `@tap`. No hold behavior — this exists purely so every letter participates in the idle-tracking trick.

### defalias — the named actions

```lisp
(defalias
  hyper (multi lctrl lalt lshift lmet)
```
"Hyper" = all four modifiers at once, the hold on `g` and `h`. Useful for global app shortcuts that can't collide with anything. **Windows caveat:** Ctrl+Alt+Shift+Win alone is the "Office key"; tapping `g`'s hold with no other key may pop an Office app on some systems.

#### The core trick

```lisp
  tap (multi
    (layer-switch nomods)
    (on-idle $require-prior-idle tap-virtualkey to-base)
  )
```
This runs **every time you type any letter**, and it's the whole magic:

1. `(layer-switch nomods)` — immediately move the base layer to `nomods`, where home-row keys are plain letters (no tap-hold, no waiting, no misfiring).
2. `(on-idle 250 tap-virtualkey to-base)` — schedule: once the keyboard has been quiet for 250 ms, tap the virtual key `to-base`, which switches back to `def`, re-arming the mods.

While you type continuously, every keystroke keeps you in `nomods`; the moment you pause a quarter second, mods come back. That's ZMK's `require-prior-idle`, rebuilt from kanata parts.

#### The old config's keys, kept

```lisp
  cesc (tap-hold-press $quick-tap-ms $tapping-term esc lctl)
```
Caps Lock: tap = Esc, hold = Ctrl. `tap-hold-press` means the hold fires the instant you press **any** other key — Caps+C is Ctrl+C with zero waiting.

```lisp
  lang (tap-hold-press $quick-tap-ms $tapping-term (macro M-spc) lctl)
```
Left Ctrl: tap = the macro Win+Space (language switcher), hold = normal Ctrl. You lose nothing.

#### The ten home-row mods (GASC order)

```lisp
  a (t! lhrm   $tapping-term        a lmet   )
  s (t! lhrm   $tapping-term        s lalt   )
  d (t! lhrm   $tapping-term        d lsft   )
  f (t! lhrm   $tapping-term        f lctl   )
  g (t! lhrm   $tapping-term        g @hyper )

  h (t! rhrm   $tapping-term        h @hyper )
  j (t! rhrm   $tapping-term        j rctl   )
  k (t! rhrm   $tapping-term        k rsft   )
  l (t! rhrm   $tapping-term        l lalt   )
  ; (t! rhrm   $tapping-term        ; rmet   )
```
Each line fills the template: tap = the letter, hold = the mod. Left pinky→index: **W**in, **A**lt, **S**hift, **C**trl; mirrored on the right (J=Ctrl, K=Shift, L=Alt, ;=Win); `g`/`h` = Hyper. `l` uses `lalt` (not right Alt) on purpose — right Alt is AltGr on Windows and behaves like Ctrl+Alt in some layouts.

#### Every other typing key

```lisp
  q (t! nomod q)
  w (t! nomod w)
  ...
  ' (t! nomod ')
  / (t! nomod /)
  spc (t! nomod spc)
```
All remaining letters, punctuation, and Space get the `nomod` treatment: they type themselves **and** run `@tap`. That's why typing *anything* keeps the mods disarmed. (`z` and `c` are missing here because they get their own hold-taps next.)

```lisp
  zfn  (t! lhrm $tapping-term z (layer-while-held fun))
```
`z`: tap = z, hold = FUN layer. On the Mac original this held the globe/fn key, which doesn't exist on Windows. `layer-while-held` = active only while pressed, unlike `layer-switch`, which is permanent.

```lisp
  cnum (tap-hold-release $quick-tap-ms $tapping-term @c (layer-while-held num))
```
`c`: tap = c (via `@c`, so the idle bookkeeping still runs), hold = NUM layer. `tap-hold-release` resolves to hold when another key is pressed *and released* during the hold — slightly more roll-tolerant than `tap-hold-press`.

#### One-shot ("sticky") mods

```lisp
  osm (one-shot $one-shot-timeout lmet)
  oss (one-shot $one-shot-timeout lshift)
  osa (one-shot $one-shot-timeout lalt)
  osc (one-shot $one-shot-timeout lctrl)
```
Tap one (they live on the home row of every layer) and the modifier applies to your **next** keypress only — Callum-style modding. They stack, can be held like normal mods, and stay armed 60 s or until used.

```lisp
  ppmnp (tap-dance 200 ((tap-hold $quick-tap-ms $tapping-term pp mute) next prev))
```
Media key on NAV: a tap-dance with a 200 ms window between taps. One tap = play/pause (`pp`); press-and-hold = mute (the first slot is itself a tap-hold); two taps = next track; three = previous.

#### The tri-layer thumb keys

```lisp
  tlnav (multi
    (on-press   press-virtualkey    lnav)
    (on-press   tap-virtualkey      release_all_mods)
    (on-press   tap-virtualkey      evaluate_tri_layer)
    (on-release tap-virtualkey      ops)
    (on-release release-virtualkey  lnav)
    (on-release release-virtualkey  swapperrcmd)
    (on-release tap-virtualkey      evaluate_tri_layer)
  )
```
The NAV thumb (physical left Alt), line by line:

- press: hold down the invisible marker key `lnav` (outputs `nop0` — nothing — but kanata can see it's held)
- press: tap `release_all_mods`, absorbing leftover one-shot mods so they don't leak into the layer
- press: run `evaluate_tri_layer`, which looks at which markers are held and picks the layer
- release: tap `ops` — briefly pauses processing so a one-shot armed *inside* the layer survives the trip back to `def`
- release: let go of the `lnav` marker
- release: let go of `swapperrcmd` — if you were Alt-Tabbing, this releases Alt and commits the window switch
- release: re-run `evaluate_tri_layer` to drop back to `def` (or to SYM if that thumb is still down)

```lisp
  tlsym (multi
    (on-press   press-virtualkey    lsym)
    ;; (on-press   tap-virtualkey      release_all_mods)
    (on-press   tap-virtualkey      evaluate_tri_layer)
    (on-release tap-virtualkey      ops)
    (on-release release-virtualkey  lsym)
    (on-release tap-virtualkey      evaluate_tri_layer)
  )
```
Same idea for the SYM thumb (physical right Alt), holding marker `lsym` (`nop1`). The one-shot-clearing line is commented out here, mirroring the original author's choice: arming a one-shot and *then* going to SYM keeps it armed.

Why "tri-layer": NAV thumb alone → nav. SYM alone → sym. **Both** → fun. The decision lives in `evaluate_tri_layer` under `defvirtualkeys`.

```lisp
  swapper (multi
    (on-press   press-virtualkey    swapperrcmd)
    (on-press   tap-virtualkey      swappertab)
  )
```
The Alt-Tab swapper (NAV+`w`). First press: holds a virtual Alt and taps Tab → the switcher opens. Every further press taps Tab again. Releasing the NAV thumb releases Alt (via `tlnav` above) → you land on the chosen window.

#### Mode toggles

```lisp
  toggle_num_word
    (switch
      ((layer def)) (layer-switch num) break
      ((layer num)) (layer-switch def) break
    )
```
A `switch` checks conditions top-to-bottom; `break` stops. On `def` → switch (permanently) to `num`; on `num` → back. This is Num Word: a *sticky* number layer, toggled by `m`+`,`+`.`, exited by Space or the NAV-thumb tap.

```lisp
  toggle_muggle_mode
    (switch
      ((layer def)) (layer-switch muggle) break
      ((layer muggle)) (layer-switch def) break
    )
```
Same toggle between `def` and `muggle`. Triggered by `q+w+e+r`.

```lisp
  num (tap-hold-release $quick-tap-ms $tapping-term lmet (layer-while-held num))
```
The NUM thumb (physical left Win): tap = Win (Start menu stays one tap away), hold = NUM layer.

```lisp
  capsword (caps-word-custom-toggle 5000 (a b c d e f g h i j k l m n o p q r s t u v w x y z) (lshift rshift grv apos 6 nop0 nop1 nop9 bspc))
```
Caps Word (the `d`+`k` combo): types LIKE THIS without holding Shift. Arguments: 5000 = auto-off after 5 s idle; first list = keys that get shifted; second list = keys that **don't end it** (manual shifts, `` ` ``, apostrophe, `6` — so the `^`/`~`/`` ` `` combos work mid-word — the invisible `nop` markers, and Backspace). Anything else — Space, Enter, a digit — ends it.

#### NUM-layer helpers

```lisp
  0_sym    (tap-hold-release $tapping-term $quick-tap-ms 0 (layer-while-held sym))
```
On NUM, the SYM thumb becomes: tap = `0`, hold = SYM. The timings are deliberately swapped versus the home-row keys: hold kicks in after just 200 ms, and you get a 300 ms re-press window for typing repeated zeros.

```lisp
  num_spc  (multi (layer-switch def) spc)
```
On NUM, Space exits Num Word *and* types a space — type "200 " and you're back to letters automatically.

```lisp
  num_nav  (tap-hold-release $tapping-term $quick-tap-ms (layer-switch def) (layer-while-held nav))
```
On NUM, the NAV thumb: tap = silently exit Num Word, hold = NAV (arrow around without leaving numbers).

```lisp
  r$       (macro S-r S-4 spc)
  ,00      (macro , Digit0 Digit0 spc)
  000      (macro Digit0 Digit0 Digit0)
)
```
Typing macros for money amounts: "R$ ", ",00 ", "000". Quirk: inside a `macro`, a bare number means "wait that many milliseconds", so the `0` key must be written `Digit0`. The `r$` macro is the original author's currency — change or delete freely.

### defchordsv2 — combos

Each line reads: `(keys) action timeout release-behavior (layers-where-DISABLED)`. The last list is layers where the combo is **off** — everywhere else it works. `all-released` = the action lets go when all fingers are up; `first-release` = as soon as the first finger lifts (snappier for Enter/Backspace).

```lisp
  (w e r)   esc    ... (    nav sym fun     nomods)
  (w   r)   tab    ... (    nav sym fun     nomods)
  (s d f)   enter  ... (    nav sym fun     nomods)
  (s   f)   bspc   ... (    nav sym fun     nomods)
```
Left hand: Esc, Tab, Enter, Backspace. Disabled on the function layers (those keys mean other things there) and on `nomods` — combined with `chords-v2-min-idle 350`, fast typing can't trigger them.

```lisp
  (u i o)   esc   ...
  (u   o)   tab   ...
  (j k l)   enter ...
  (j   l)   bspc  ...
```
The same four mirrored on the right hand — handy while the left hand holds a layer, or during Num Word.

```lisp
  (d k)     @capsword        ... (    nav sym fun num       )
  (m , .)   @toggle_num_word ... (    nav sym fun     nomods)
```
Both middle fingers (`d`+`k`) toggle Caps Word. `m`+`,`+`.` toggles Num Word.

```lisp
  (f ralt)  S-grv  ...   ;; ~
  (s ralt)  S-6    ...   ;; ^
  (d ralt)  grv    ...   ;; `
```
SYM-thumb + a left home key = `~`, `^`, `` ` `` — mainly so you can type them during Caps Word without ending it. (The original had a copy-paste bug sending `^` twice; the `d` one now correctly sends `` ` ``.)

```lisp
  (g h)     lrld   ... (def nav sym     num nomods)
```
`g`+`h` = **live-reload the config** — `fun` is absent from the disabled list, so it only works while on FUN (hold both thumbs, then `g`+`h`). Edit, reload, no restart. (Technically also live in muggle mode, faithful to the original.)

```lisp
  (q w e r) @toggle_muggle_mode ... (   nav sym fun num       )
```
All four left top-row fingers = muggle mode on/off.

### defvirtualkeys — the invisible machinery

Virtual keys have no physical existence; actions can press, release, or tap them.

```lisp
  to-base (layer-switch def)
```
Tapping this returns the base layer to `def`. It's what `@tap` schedules with `on-idle` — the re-arming of mods after a 250 ms pause.

```lisp
  ops (one-shot-pause-processing 10)
```
Pauses input processing 10 ms. Tapped when a layer thumb is released, so an armed one-shot isn't consumed/cancelled by the layer switching itself.

```lisp
  swapperrcmd lalt
  swappertab tab
```
The swapper's building blocks: a holdable virtual **Alt** (this was right Cmd on macOS — the actual Windows adaptation) and a tappable virtual Tab.

```lisp
  lnav nop0
  lsym nop1
```
The layer-thumb markers. They output `nop0`/`nop1` — nothing — but their held/not-held state is readable.

```lisp
  evaluate_tri_layer (switch
    ((and nop0 nop1)) (layer-switch fun) break
    ((and nop0 (not nop1))) (layer-switch nav) break
    ((and nop1 (not nop0))) (layer-switch sym) break
    ((not (and nop0 nop1))) (layer-switch def) break
  )
```
The tri-layer brain, checked in order: both markers held → FUN; only NAV's → nav; only SYM's → sym; otherwise → def. Re-run on every thumb press and release, so the layer always matches the thumb state.

```lisp
  release_all_mods nop9
```
Tapping a do-nothing key is enough to "use up" any armed one-shot mods — that's the whole trick. (`nop9` is in the Caps Word safe list so this housekeeping doesn't end Caps Word.)

### defsrc — which physical keys kanata owns

```lisp
(defsrc
  caps
  q w e r t      y u i o p
  a s d f g      h j k l ; '
  z x c v b      n m , . /
  lctl lmet lalt spc ralt
)
```
The 37 keys kanata remaps. `defsrc` is just an ordered list — line breaks are for humans; position N here = position N in every layer below. The F-row, number row, Enter, Backspace, etc. are *not* listed: thanks to `process-unmapped-keys yes` they're still sequenced through kanata (order preserved!) but keep their normal function. `'` is listed only so it gets the `@tap` idle bookkeeping. Right Ctrl is deliberately absent — it stays a plain Ctrl.

### deflayer def — the main layer

```lisp
(deflayer def
  @cesc
  @q   @w @e    @r  @t        @y  @u  @i  @o  @p
  @a   @s @d    @f  @g        @h  @j  @k  @l  @;  @'
  @zfn @x @cnum @v  @b        @n  @m  @,  @.  @/
  @lang @num @tlnav @spc @tlsym
)
```
Caps = tap-Esc/hold-Ctrl. Top row = plain letters (with idle bookkeeping). Home row = the ten home-row mods plus plain `'`. Bottom row = z (tap z / hold FUN), plain x, c (tap c / hold NUM), plain v b n m , . /. Thumb row, left to right: left Ctrl = language/Ctrl, left Win = Start/NUM, left Alt = **NAV**, Space, right Alt = **SYM**.

### deflayer nomods — where fast typing happens

```lisp
(deflayer nomods
  _
  q  w  e  r  t      y  u  i  o  p
  a  s @d  f  g      h  j @k  l  ;  '
  z  x  c  v  b      n  m  ,  .  /
  _ _ _ _ _
)
```
The layer you're silently switched to while typing. Everything is a **plain key** — no tap-hold, so zero delay and zero misfires — with one deliberate exception: `@d` and `@k` keep their Shift hold so you can capitalize mid-sentence without pausing. The thumbs are `_`, falling through to `def`, so Space and the layer keys still work mid-flow (and Space's `@tap` keeps the cycle going).

### deflayer num

```lisp
(deflayer num
  _
  S-9  S-0  XX   @r$  XX        S-=  7  8  9  S-8
  @osm @osa @oss @osc bspc      -    4  5  6  /   _
  XX   @oss XX   @000 @,00      ,    1  2  3  .
  _ XX @num_nav @num_spc @0_sym
)
```
A right-hand numpad under u-i-o / j-k-l / m-,-.: `7 8 9`, `4 5 6`, `1 2 3`, with `+ * - / , .` around them (`S-=` is `+`, `S-8` is `*`). Left hand: `(` `)` on q/w, the money macros, Backspace on the index stretch, one-shot mods on the home row (GASC order) so Ctrl+5 is just `f` then `5`, plus an extra one-shot Shift on `x`. Thumbs: left Win = `XX` (no accidental Start menu during Num Word), NAV thumb = exit-or-navigate, Space = exit-and-space, SYM thumb = tap 0 / hold SYM.

### deflayer nav

```lisp
(deflayer nav
  _
  tab  @swapper S-C-tab C-tab A-right     pgup   home up   end   bspc
  @osm @osa     @oss    @osc  A-left      pgdn   left down right enter  _
  C-z  C-x      C-c     C-v   f18         @ppmnp f19  vold volu  del
  _ _ _ _ _
)
```
Right hand: the navigation cluster — arrows on the home positions, PgUp/PgDn, Home/End, Backspace/Enter/Delete on the pinky column. Left hand: Tab, the swapper on `w`, previous/next browser tab (`S-C-tab`/`C-tab`), browser back/forward (`A-left`/`A-right` — translated from Cmd+[ / Cmd+] on the Mac), one-shot mods on the home row, and undo/cut/copy/paste on z-x-c-v (Cmd → Ctrl translation). `f18`/`f19` are spare bindable keys; `@ppmnp` is the media tap-dance; `vold`/`volu` = volume.

### deflayer sym

```lisp
(deflayer sym
  _
  esc  S-lbrc lbrc S-9   S-5      S-7  S-0  rbrc S-rbrc S-'
  -    S-6    grv  S-grv S-4      S-3  @osc @oss @osa   @osm  _
  S-=  =      S-8  /     S-2      S-\  \    S-/  S-1    S-;
  _ _ _ S-- _
)
```
Decoded, the three rows are:

```
esc  {  [  (  %        &  )  ]  }  "
 -   ^  `  ~  $        #  one-shot mods
 +   =  *  /  @        |  \  ?  !  :
```

Openers on the left, closers mirrored on the right; one-shots on the right home row (mirrored GASC: j=Ctrl … ;=Win). Space becomes `S--` = **underscore** — lovely for snake_case.

### deflayer fun

```lisp
(deflayer fun
  _
  1    2    3    4    5        6    7    8    9    0
  @osm @osa @oss @osc f11      f12  @osc @oss @osa @osm  _
  f1   f2   f3   f4   f5       f6   f7   f8   f9   f10
  _ _ _ caps _
)
```
Hold **both** thumbs (or just `z`). Real number row on top, F1–F10 on the bottom row, F11/F12 inboard, one-shots on both home rows (Shift+F5, Alt+F4…), and Space = actual **Caps Lock** — the only place it still exists. The `g`+`h` reload combo works here.

### deflayer muggle

```lisp
(deflayer muggle
  caps
  q w e r t      y u i o p
  a s d f g      h j k l ; '
  z x c v b      n m , . /
  lctl lmet lalt spc ralt
)
```
Every key is literally itself — a completely normal keyboard for anyone borrowing the machine. Enter and exit with `q+w+e+r`.

### Putting it together: what happens when you type "so" fast

1. You press `s`. If you'd been typing (within 250 ms), you're on `nomods` → `s` outputs instantly. Done — no bug possible.
2. If you *had* paused, `s` is a tap-hold and waits. You press `o` 40 ms later — `o` queues up **behind** `s` (`process-unmapped-keys yes` at work; in the old config `o` would jump the queue here, producing "os").
3. You release `s` quickly → it resolves as tap → kanata flushes `s`, then `o`, in order: "so". The tap also fires `@tap`, so the next letters fly through `nomods`.
4. Whenever you stop for 250 ms, `on-idle` taps `to-base`, mods re-arm, and a deliberate hold of `f` is Ctrl again.

---

## Credits

- [urob's ZMK config](https://github.com/urob/zmk-config) — the original "timerless" home row mods design this emulates
- sgraar's [require-prior-idle workaround for kanata](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/) — the `nomods` + `on-idle` trick
- The author of the macOS kanata config this was ported from (tri-layer, swapper, combos, Caps/Num Word design)
- [jtroo/kanata](https://github.com/jtroo/kanata) — the remapper itself
