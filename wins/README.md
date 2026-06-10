# wins.kbd — explained line by line

## How to read kanata syntax (30 seconds)

- Everything is `(parentheses lists)`. `;;` starts a comment that runs to the end of the line.
- `defcfg` = global settings, `defvar` = variables, `deftemplate` = reusable snippets, `defalias` = named actions, `defsrc` = which physical keys kanata takes over, `deflayer` = what those keys do, `defchordsv2` = combos, `defvirtualkeys` = invisible helper keys.
- `@name` uses an alias. `$name` uses a variable. `(t! template args)` expands a template.
- In a layer: `_` = transparent (falls through to the `def` layer, because of `delegate-to-first-layer`), `XX` = do nothing.
- Prefixes on keys: `S-` Shift, `C-` Ctrl, `A-` Alt, `M-` Meta/Win. So `S-9` = `(`, `C-tab` = Ctrl+Tab, `M-spc` = Win+Space.
- Key names: `grv` = `` ` ``, `lbrc`/`rbrc` = `[` `]`, `bspc` = Backspace, `lmet`/`rmet` = left/right Win, `lsft`/`rsft` = Shift, `nop0`…`nop9` = keys that output nothing (used as invisible markers).

---

## Header

```lisp
;; kanata config — Windows port of the urob-style "timerless" home row mods setup
;; Adapted from a macOS config; Windows-specific changes are marked with [win].
;;
;; Run:    kanata.exe --cfg wins.kbd          (run terminal as admin for elevated apps)
;; Check:  kanata.exe --cfg wins.kbd --check  (validate after any edit)
```

Just comments. The `--check` flag parses the config and reports errors without actually remapping anything — run it after every edit.

---

## defcfg — global settings

```lisp
(defcfg
  process-unmapped-keys yes
```
**This is the line that fixes your "os" → "so" bug.** With `no` (your old config), keys not listed in `defsrc` bypassed kanata and reached Windows instantly, while home-row keys sat in kanata's queue waiting for a tap-vs-hold decision — so a later key could overtake an earlier one. With `yes`, every key goes through kanata's queue, so output order always matches the order you pressed them.

```lisp
  block-unmapped-keys no
```
With `yes`, keys not in `defsrc` would be silenced entirely. `no` lets them work normally (F-keys, arrows, Enter, etc. all keep doing their thing).

```lisp
  log-layer-changes no
```
Don't spam the console every time a layer changes. Purely cosmetic.

```lisp
  concurrent-tap-hold yes
```
Lets multiple tap-hold keys be "in flight" at once. Required for the `defchordsv2` combos to coexist with home-row mods, and for chording two mods (e.g. holding `f`+`d` for Ctrl+Shift).

```lisp
  delegate-to-first-layer yes
```
Defines what `_` (transparent) means: fall through to the **first layer** (`def`), not to the raw physical key. So `_` on the Caps position in any layer still gives you tap-Esc/hold-Ctrl, not raw Caps Lock.

```lisp
  chords-v2-min-idle 350
)
```
Combos only fire if the keyboard was idle for ≥350 ms beforehand. This is ZMK's `require-prior-idle`, but for combos — it's why typing "wer" fast never accidentally triggers the w+e+r = Esc combo.

---

## defvar — variables

```lisp
(defvar
  one-shot-timeout 60000
```
One-shot mods (explained later) stay armed for up to 60 seconds. Bonkers, as the original author said, but harmless: a one-shot is consumed by your next keypress anyway.

```lisp
  tapping-term 300
```
Hold a home-row key for 300 ms with nothing else deciding the outcome, and it becomes a modifier. Generous on purpose: the positional rules below make decisions long before 300 ms in normal typing, and a long term means fewer accidental holds.

```lisp
  quick-tap-ms 200
```
Tap a home-row key, then press it **again within 200 ms** → it repeats the letter instead of becoming a mod. This is how you keep key autorepeat ("ssssss") on mod keys.

```lisp
  require-prior-idle 250
```
After any keypress, home-row mods stay "disarmed" until you've paused for 250 ms. This is the heart of the misfire/reordering fix — see the `tap` alias below.

```lisp
  combo-timeout 60
```
All keys of a combo must go down within 60 ms of each other to count as a combo.

```lisp
  left-side-keys   (q w e r t x c v b)
  right-side-keys  (y u i o p n m , . / ')
```
The "instant tap" lists. While a left-hand home-row key is undecided, pressing any `left-side-keys` key instantly resolves it as a **letter** (same for the right hand). Translation: a same-hand roll like `s`→`t` can never become Alt+T. (Consequence: to chord a mod with a same-hand letter from these lists, e.g. Win+Q via `a`, you must hold `a` past 300 ms first.)

```lisp
  home-row-left-keys  (a s d f g z)
  home-row-right-keys (h j k l ;)
)
```
The "decide by release order" lists — the other home-row mod keys on the same hand. If you roll `a`→`s` and release in order, you typed "as". If you press `s`, and it goes down **and up while you're still holding** `a`, that's a deliberate chord → Win+S. This is what makes same-hand mod stacks possible without breaking rolls.

---

## Templates — the home-row-mod recipe

```lisp
(deftemplate lhrm (tappingterm tap-key hold-key)
  (tap-hold-release-tap-keys-release $quick-tap-ms $tappingterm (multi $tap-key @tap) $hold-key $left-side-keys $home-row-left-keys)
)
```
A template is a fill-in-the-blanks snippet; `lhrm` = "left home row mod". The six arguments of `tap-hold-release-tap-keys-release`, in order:

1. `$quick-tap-ms` (200) — the re-press-to-repeat window
2. `$tappingterm` (300) — hold this long → modifier
3. `(multi $tap-key @tap)` — the **tap** action: the letter itself, *plus* the `@tap` bookkeeping (the require-prior-idle trick, below)
4. `$hold-key` — the **hold** action: the modifier
5. `$left-side-keys` — press any of these while undecided → instant tap
6. `$home-row-left-keys` — these decide by release order

```lisp
(deftemplate rhrm (tappingterm tap-key hold-key)
  (tap-hold-release-tap-keys-release $quick-tap-ms $tappingterm (multi $tap-key @tap) $hold-key $right-side-keys $home-row-right-keys)
)
```
Identical, but with the right-hand key lists.

```lisp
(deftemplate nomod (tap-key)
  (multi $tap-key @tap)
)
```
For ordinary letters: output the key **and** run `@tap`. No hold behavior at all — this exists purely so that every letter you type participates in the idle-tracking trick.

---

## defalias — the named actions

```lisp
(defalias
  hyper (multi lctrl lalt lshift lmet)
```
"Hyper" = all four modifiers at once, used as a hold on `g` and `h`. Useful for global app shortcuts that can't collide with anything. **Windows caveat:** Ctrl+Alt+Shift+Win on its own is the "Office key"; pressing and releasing `g`'s hold with no other key may pop up an Office app on some systems.

### The core trick

```lisp
  tap (multi
    (layer-switch nomods)
    (on-idle $require-prior-idle tap-virtualkey to-base)
  )
```
This runs **every time you type any letter**, and it's the whole magic:

1. `(layer-switch nomods)` — immediately move the base layer to `nomods`, where home-row keys are plain letters (no tap-hold, no waiting, no misfiring).
2. `(on-idle 250 tap-virtualkey to-base)` — schedule: "once the keyboard has been quiet for 250 ms, tap the virtual key `to-base`," which switches back to `def`, re-arming the mods.

So while you're typing continuously, every keystroke keeps you in `nomods` (instant, ordinary letters); the moment you pause for a quarter second, mods come back. That's ZMK's `require-prior-idle`, rebuilt out of kanata parts.

### Your old config's keys, kept

```lisp
  cesc (tap-hold-press $quick-tap-ms $tapping-term esc lctl)
```
Caps Lock: tap = Esc, hold = Ctrl. `tap-hold-press` means the hold fires the instant you press **any** other key — so Caps+C is Ctrl+C with zero waiting.

```lisp
  lang (tap-hold-press $quick-tap-ms $tapping-term (macro M-spc) lctl)
```
Left Ctrl: tap = the macro Win+Space (your language switcher), hold = normal Ctrl. You lose nothing — physical Ctrl still works for shortcuts.

### The ten home-row mods (your GASC order)

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
Each line fills in the template: tap = the letter, hold = the mod. Left hand pinky→index: **W**in, **A**lt, **S**hift, **C**trl; mirrored on the right (J=Ctrl, K=Shift, L=Alt, ;=Win); `g`/`h` = Hyper. The right side uses `lalt` on `l` (not Right Alt) on purpose — Right Alt is AltGr on Windows and behaves like Ctrl+Alt in some layouts.

### Every other typing key

```lisp
  q (t! nomod q)
  w (t! nomod w)
  ...
  ' (t! nomod ')
  / (t! nomod /)
  spc (t! nomod spc)
```
All remaining letters, punctuation, and Space get the `nomod` treatment: they type themselves **and** run `@tap`. That's why typing *anything* keeps the mods disarmed — not just home-row keys. (`z` and `c` are missing from this block because they get their own hold-taps next.)

```lisp
  zfn  (t! lhrm $tapping-term z (layer-while-held fun))
```
`z`: tap = z, hold = the FUN layer (F-keys and the number row). On the Mac original this held the globe/fn key, which doesn't exist on Windows, so it holds the layer directly. `layer-while-held` = active only while pressed, unlike `layer-switch` which is permanent.

```lisp
  cnum (tap-hold-release $quick-tap-ms $tapping-term @c (layer-while-held num))
```
`c`: tap = c (via `@c`, so the idle bookkeeping still runs), hold = the NUM layer. `tap-hold-release` resolves to hold when another key is pressed *and released* during the hold — slightly more roll-tolerant than `tap-hold-press`.

### One-shot ("sticky") mods

```lisp
  osm (one-shot $one-shot-timeout lmet)
  oss (one-shot $one-shot-timeout lshift)
  osa (one-shot $one-shot-timeout lalt)
  osc (one-shot $one-shot-timeout lctrl)
```
Tap one of these (they live on the home row of every layer) and the modifier applies to your **next** keypress only — Callum-style modding. Example: hold NAV thumb, tap `d` (one-shot Shift), release everything, press → = select one character. You can also just hold them like normal mods. They stay armed for 60 s or until used.

```lisp
  ppmnp (tap-dance 200 ((tap-hold $quick-tap-ms $tapping-term pp mute) next prev))
```
Media key on NAV: it's a tap-dance with a 200 ms window between taps. One tap = play/pause (`pp`); press-and-hold = mute (the first slot is itself a tap-hold); two taps = next track; three taps = previous track.

### The tri-layer thumb keys

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
The NAV thumb (physical Left Alt). Line by line:

- press: hold down the invisible marker key `lnav` (it outputs `nop0` — nothing — but kanata can see it's held)
- press: tap `release_all_mods`, absorbing any leftover one-shot mods so they don't leak into the layer
- press: run `evaluate_tri_layer`, which looks at which markers are held and picks the layer
- release: tap `ops` — briefly pauses processing so a one-shot you armed *inside* the layer survives the trip back to `def`
- release: let go of the `lnav` marker
- release: let go of `swapperrcmd` — if you were Alt-Tabbing (see swapper), this releases Alt and commits the window switch
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
Same idea for the SYM thumb (physical Right Alt), holding marker `lsym` (`nop1`). The one-shot-clearing line is commented out here, mirroring the original author's choice: arming a one-shot and *then* going to SYM keeps it armed.

Why "tri-layer": NAV thumb alone → nav. SYM thumb alone → sym. **Both** → fun. The decision logic lives in `evaluate_tri_layer` under `defvirtualkeys`.

```lisp
  swapper (multi
    (on-press   press-virtualkey    swapperrcmd)
    (on-press   tap-virtualkey      swappertab)
  )
```
The Alt-Tab "swapper" (on NAV+W). First press: holds a virtual Alt (`swapperrcmd`) and taps Tab → the Windows switcher opens. Every further press taps Tab again → next window. Releasing the NAV thumb releases Alt (via `tlnav` above) → you land on the chosen window. One-key Alt-Tab.

### Mode toggles

```lisp
  toggle_num_word
    (switch
      ((layer def)) (layer-switch num) break
      ((layer num)) (layer-switch def) break
    )
```
A `switch` checks conditions top-to-bottom; `break` stops. If you're on `def`, switch (permanently) to `num`; if on `num`, switch back. This is "num word": a *sticky* number layer, toggled by the m+,+. combo, that you leave by tapping Space or the exit key.

```lisp
  toggle_muggle_mode
    (switch
      ((layer def)) (layer-switch muggle) break
      ((layer muggle)) (layer-switch def) break
    )
```
Same toggle between `def` and `muggle` (the everything-is-normal layer for other people). Triggered by q+w+e+r.

```lisp
  num (tap-hold-release $quick-tap-ms $tapping-term lmet (layer-while-held num))
```
The NUM thumb (physical Left Win): tap = Win (Start menu still one tap away), hold = NUM layer.

```lisp
  capsword (caps-word-custom-toggle 5000 (a b c d e f g h i j k l m n o p q r s t u v w x y z) (lshift rshift grv apos 6 nop0 nop1 nop9 bspc))
```
Caps Word (toggled by the d+k combo): types LIKE_THIS without holding Shift. Arguments: 5000 = auto-off after 5 s of inactivity; first list = keys that get shifted (the letters); second list = keys that **don't end it** (manual shifts, `` ` ``, apostrophe, `6` — so the `^`/`~`/`` ` `` combos work mid-word — the invisible `nop` markers, and Backspace for fixing typos). Anything else — Space, Enter, a digit — ends it.

### NUM-layer helpers

```lisp
  0_sym    (tap-hold-release $tapping-term $quick-tap-ms 0 (layer-while-held sym))
```
On NUM, the SYM thumb becomes: tap = `0`, hold = SYM layer. Note the timings are deliberately swapped versus the home-row keys: hold kicks in after just 200 ms, and you get a generous 300 ms re-press window for typing repeated zeros.

```lisp
  num_spc  (multi (layer-switch def) spc)
```
On NUM, Space exits num-word *and* types a space — type "200 " and you're back to letters automatically.

```lisp
  num_nav  (tap-hold-release $tapping-term $quick-tap-ms (layer-switch def) (layer-while-held nav))
```
On NUM, the NAV thumb: tap = silently exit num-word, hold = NAV layer (so you can arrow around without leaving numbers).

```lisp
  r$       (macro S-r S-4 spc)
  ,00      (macro , Digit0 Digit0 spc)
  000      (macro Digit0 Digit0 Digit0)
)
```
Typing macros from the original author (money amounts): `R$ `, `,00 `, `000`. Quirk to know: inside a `macro`, a bare number means "wait that many milliseconds", so the `0` key must be written `Digit0`. The `r$` one types "R$ " (Brazilian currency) — feel free to change or delete it.

---

## defchordsv2 — combos

Each line reads: `(keys) action timeout release-behavior (layers-where-DISABLED)`. The last list is layers where the combo is turned **off** — everywhere else it works. `all-released` = the action lets go when all fingers are up; `first-release` = it lets go as soon as the first finger lifts (snappier for Enter/Backspace).

```lisp
  (w e r)   esc    ... (    nav sym fun     nomods)
  (w   r)   tab    ... (    nav sym fun     nomods)
  (s d f)   enter  ... (    nav sym fun     nomods)
  (s   f)   bspc   ... (    nav sym fun     nomods)
```
Left hand: w+e+r = Esc, w+r = Tab, s+d+f = Enter, s+f = Backspace. Disabled on the function layers (those keys mean other things there) and on `nomods` — combined with `chords-v2-min-idle 350`, fast typing can't trigger them.

```lisp
  (u i o)   esc   ...
  (u   o)   tab   ...
  (j k l)   enter ...
  (j   l)   bspc  ...
```
The same four, mirrored on the right hand — handy while your left hand is holding a layer or during num-word.

```lisp
  (d k)     @capsword        ... (    nav sym fun num       )
  (m , .)   @toggle_num_word ... (    nav sym fun     nomods)
```
Both index... both middle-row fingers together (d+k) toggle Caps Word. m+,+. toggles num-word.

```lisp
  (f ralt)  S-grv  ...   ;; ~
  (s ralt)  S-6    ...   ;; ^
  (d ralt)  grv    ...   ;; `
```
SYM-thumb + a left home key = `~`, `^`, `` ` ``. These exist mainly so you can type them during Caps Word without ending it. (The original had a copy-paste bug sending `^` twice; the `d` one now correctly sends `` ` ``.)

```lisp
  (g h)     lrld   ... (def nav sym     num nomods)
```
g+h together = **live-reload the config** — but `fun` is missing from the disabled list, so it only works while you're on the FUN layer (hold both thumbs, then g+h). Edit the file, reload, no restart. (Technically it also works in muggle mode, faithful to the original.)

```lisp
  (q w e r) @toggle_muggle_mode ... (   nav sym fun num       )
```
All four left top-row fingers = toggle muggle mode on/off.

---

## defvirtualkeys — the invisible machinery

Virtual keys are keys with no physical existence; actions can press, release, or tap them.

```lisp
  to-base (layer-switch def)
```
"Tapping" this returns the base layer to `def`. It's the thing `@tap` schedules with `on-idle` — the re-arming of your mods after a 250 ms pause.

```lisp
  ops (one-shot-pause-processing 10)
```
Pauses input processing for 10 ms. Tapped when a layer thumb is released so that an armed one-shot mod isn't consumed/cancelled by the layer-switching itself.

```lisp
  swapperrcmd lalt
  swappertab tab
```
The swapper's building blocks: a holdable virtual **Alt** (this was Right Cmd on macOS — the actual Windows adaptation) and a tappable virtual Tab.

```lisp
  lnav nop0
  lsym nop1
```
The layer-thumb markers. They output `nop0`/`nop1` — literally nothing — but their held/not-held state is readable.

```lisp
  evaluate_tri_layer (switch
    ((and nop0 nop1)) (layer-switch fun) break
    ((and nop0 (not nop1))) (layer-switch nav) break
    ((and nop1 (not nop0))) (layer-switch sym) break
    ((not (and nop0 nop1))) (layer-switch def) break
  )
```
The tri-layer brain, checked in order: both markers held → FUN; only NAV's → nav; only SYM's → sym; otherwise → def. Re-run on every thumb press and release, so the layer always matches the current thumb state.

```lisp
  release_all_mods nop9
```
Tapping a do-nothing key is enough to "use up" any armed one-shot mods — that's the whole trick. (`nop9` is in the caps-word safe list so this housekeeping doesn't end Caps Word.)

---

## defsrc — which physical keys kanata owns

```lisp
(defsrc
  caps
  q w e r t      y u i o p
  a s d f g      h j k l ; '
  z x c v b      n m , . /
  lctl lmet lalt spc ralt
)
```
The 37 keys kanata remaps. `defsrc` is just an ordered list — the line breaks are for humans; position N here = position N in every layer below. Note the F-row, number row, Enter, Backspace, etc. are *not* listed: thanks to `process-unmapped-keys yes` they're still sequenced through kanata (order preserved!) but keep their normal function. `'` is in the list only so it gets the `@tap` idle bookkeeping.

---

## deflayer def — the main layer

```lisp
(deflayer def
  @cesc
  @q   @w @e    @r  @t        @y  @u  @i  @o  @p
  @a   @s @d    @f  @g        @h  @j  @k  @l  @;  @'
  @zfn @x @cnum @v  @b        @n  @m  @,  @.  @/
  @lang @num @tlnav @spc @tlsym
)
```
Row by row: Caps = tap-Esc/hold-Ctrl. Top row = plain letters (with idle bookkeeping). Home row = the ten home-row mods plus plain `'`. Bottom row = z (tap z / hold FUN), plain x, c (tap c / hold NUM), plain v b n m , . /. Thumb row, left to right: LCtrl = language/Ctrl, LWin = Start/NUM, LAlt = **NAV thumb**, Space, RAlt = **SYM thumb**.

## deflayer nomods — where fast typing happens

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

## deflayer num

```lisp
(deflayer num
  _
  S-9  S-0  XX   @r$  XX        S-=  7  8  9  S-8
  @osm @osa @oss @osc bspc      -    4  5  6  /   _
  XX   @oss XX   @000 @,00      ,    1  2  3  .
  _ XX @num_nav @num_spc @0_sym
)
```
A right-hand numpad under u-i-o / j-k-l / m-,-.: `7 8 9`, `4 5 6`, `1 2 3`, with `+ * - / , .` around them (`S-=` is `+`, `S-8` is `*`). Left hand: `(` `)` on q/w, the money macros, Backspace on the index-stretch, one-shot mods on the home row (in your GASC order) so Ctrl+5 is just f→5, and an extra one-shot Shift on `x`. Thumbs: LWin = `XX` (no accidental Start menu during num-word), NAV thumb = exit-or-navigate, Space = exit-and-space, SYM thumb = tap 0 / hold SYM.

## deflayer nav

```lisp
(deflayer nav
  _
  tab  @swapper S-C-tab C-tab A-right     pgup   home up   end   bspc
  @osm @osa     @oss    @osc  A-left      pgdn   left down right enter  _
  C-z  C-x      C-c     C-v   f18         @ppmnp f19  vold volu  del
  _ _ _ _ _
)
```
Hold the NAV thumb (Left Alt position). Right hand: a navigation cluster — PgUp/PgDn, Home/End, arrows under j-k-l-;… actually arrows on the home positions, Backspace/Enter/Delete on the pinky column. Left hand: Tab, the Alt-Tab swapper on `w`, previous/next browser tab (`S-C-tab`/`C-tab`), browser back/forward (`A-left`/`A-right`, translated from Cmd+[ / Cmd+] on the Mac), one-shot mods on the home row (so NAV+d then → = Shift-select), and undo/cut/copy/paste on z-x-c-v (translated from Cmd to Ctrl). `f18`/`f19` are spare keys — bind them to anything in an app or AutoHotkey. `@ppmnp` is the media tap-dance; `vold`/`volu` volume.

## deflayer sym

```lisp
(deflayer sym
  _
  esc  S-lbrc lbrc S-9   S-5      S-7  S-0  rbrc S-rbrc S-'
  -    S-6    grv  S-grv S-4      S-3  @osc @oss @osa   @osm  _
  S-=  =      S-8  /     S-2      S-\  \    S-/  S-1    S-;
  _ _ _ S-- _
)
```
Hold the SYM thumb (Right Alt position). Decoded, the three rows are:

```
esc  {  [  (  %        &  )  ]  }  "
 -   ^  `  ~  $        #  one-shot mods
 +   =  *  /  @        |  \  ?  !  :
```

Openers on the left, closers mirrored on the right; the one-shot mods sit on the right home row here (mirrored GASC: j=Ctrl … ;=Win). Space becomes `S--` = **underscore**, which is lovely for snake_case.

## deflayer fun

```lisp
(deflayer fun
  _
  1    2    3    4    5        6    7    8    9    0
  @osm @osa @oss @osc f11      f12  @osc @oss @osa @osm  _
  f1   f2   f3   f4   f5       f6   f7   f8   f9   f10
  _ _ _ caps _
)
```
Hold **both** thumbs. The real number row lives on the top row, F1–F10 on the bottom row, F11/F12 on the inner home positions, one-shots on both home rows (Shift+F5, Alt+F4…), and Space = actual **Caps Lock** — the only place it still exists. This is also where g+h = config reload works.

## deflayer muggle

```lisp
(deflayer muggle
  caps
  q w e r t      y u i o p
  a s d f g      h j k l ; '
  z x c v b      n m , . /
  lctl lmet lalt spc ralt
)
```
Every key is literally itself — a completely normal keyboard for anyone borrowing your machine. Enter and exit with q+w+e+r pressed together.

---

## Putting it together: what happens when you type "so" fast

1. You press `s`. If you'd been typing (within 250 ms), you're on `nomods` → `s` outputs instantly. Done — no bug possible.
2. If you *had* paused, `s` is a tap-hold and waits. You press `o` 40 ms later — `o` queues up **behind** `s` (this is `process-unmapped-keys yes` at work; in your old config `o` would jump the queue here, producing "os").
3. You release `s` quickly → it resolves as tap → kanata flushes `s`, then `o`, in order. "so". The tap also fires `@tap`, so the next letters fly through `nomods`.
4. Whenever you stop for 250 ms, `on-idle` taps `to-base`, mods re-arm, and a deliberate hold of `f` is Ctrl again.

## Knobs you're most likely to tweak

`tapping-term` (lower = mods trigger faster, more misfire risk), `require-prior-idle` (lower = mods re-arm sooner after typing), the `r$` macro (author's currency — make it yours), and the mod order in the ten `lhrm`/`rhrm` lines if you ever want to swap GASC for something else (remember to mirror the `@osm @osa @oss @osc` rows in the layers if you do).
