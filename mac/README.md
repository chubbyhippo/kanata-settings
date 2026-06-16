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

3. **Permissions:** System Settings → Privacy & Security → add the kanata binary to **Input Monitoring** and **Accessibility**.

Then test: hold left Cmd + `k` → ↑.

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold left Cmd (NAV) + `c` / `v` / `x` / `z` |
| Ctrl chords (Emacs, terminal) | hold Caps (= Ctrl) + the key — or pause, hold `f`/`j` + a cross-hand key |
| Cmd+Tab | works as always: hold left Cmd, tap Tab (or `w`), release to switch |
| Quit / close (Cmd+Q / Cmd+W) | NUM (hold `c` / `,`): tap `a` (one-shot Cmd), release, press `q` / `w` |
| Reopen tab (Cmd+Shift+T) | NUM: tap `a`, tap `d`, release, press `t` |
| Move word left / right | `j`+`k` = Opt+← · `d`+`f` = Opt+→ |
| Select word left / right | `h`+`j` = Shift+Opt+← · `f`+`g` = Shift+Opt+→ |
| Delete word forward / back | `s`+`d` = Opt+Del · `k`+`l` = Opt+Bksp |
| Undo / Redo | `s`+`f` = Cmd+Z · `j`+`l` = Cmd+Shift+Z |
| Cut / Copy / Paste (combo) | `z`+`x` = Cut · `x`+`c` = Copy · `c`+`v` = Paste |
| Type + - * | `u`+`j` = + · `i`+`k` = - · `o`+`l` = * |
| Emacs-style arrows | hold left Cmd (NAV): `n`/`p`/`f`/`b` = ↓/↑/→/← · `a`/`e` = Home/End |
| Vim-style arrows | hold left Cmd (NAV): `h`/`j`/`k`/`l` = ←/↓/↑/→ · `d`/`u` = PgDn/PgUp |
| Next / previous browser tab | NAV + `r` / hold Caps + Shift, tap Tab |
| Browser back / forward | NAV + `g` / NAV + `t` (Cmd+[ / Cmd+]) |
| Arrows, PgUp/PgDn, Home/End | hold left Cmd (NAV), or hold `x` / `.` |
| Switch input language | tap left Ctrl (Ctrl+Space) |
| Spotlight (Cmd+Space) | hold `a` (Cmd) + Space |
| Cmd + any left-hand key | NUM: tap `a` (one-shot Cmd), release, press the letter |
| Screenshot (Cmd+Shift+4) | NUM: tap `a`, tap `d`, press `u` (= 4) |
| Select text | hold real Shift + NAV arrows |
| Accents (é, ü, ñ…) | right Opt is untouched — use it as stock |
| Type ALL_CAPS | `d`+`k` together → Caps Word; Space or a digit ends it |
| Type a number / amount | `m`+`,` → Num Word on; Space types 0; tap the NAV thumb to exit |
| Esc / Tab / Enter / Backspace / Delete | combos `q·w` / `a·s·d` / `l·;` / `u·i` / `r·t` |
| Save / Select all / Find | combos `w·s` / `q·a` / `r·f` |
| F-keys | hold `z` / `/` or both Cmds: bottom row = F1–F10 |
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
       Cmd Opt Sft Ctl Hyp      Hyp Ctl Sft Opt Cmd
       FUN NAV NUM SYM ·        ·   SYM NUM NAV FUN

thumbs:  [Lang|Ctrl] [Ctrl] [NAV] [Space] [SYM]
         (LCtrl)     (LOpt) (LCmd)        (RCmd)
caps:    [Esc|Ctrl]
```

### NAV — hold left Cmd (or hold `x` / `.`)

```
Esc    Swapper  End    Tab→   Fwd→        ⌘V     PgUp  Tab   Bksp  ↑
Home   ⌘S       PgDn   →      ←Back       ←      ↓     ↑     →     Enter
⌘Z     ⌘X       ⌘C     ⌘V     ←           ↓      Media Vol−  Vol+  Del
```

Physical Tab on NAV is also the swapper, so Cmd+Tab works like stock macOS. Holding `x` or `.` reaches NAV without the thumb's extras (the Tab swapper and tri-layer FUN), so use the thumb for Cmd+Tab. `Media` tap-dance: 1 tap = play/pause, hold = mute, 2 taps = next, 3 = previous. Emacs-style nav: `n p f b a e` = ↓ ↑ → ← Home End, mirroring `C-n/p/f/b/a/e` — same keys, left Cmd instead of Ctrl. Vim-style too: `h j k l` = ← ↓ ↑ →, with `d`/`u` = PgDn/PgUp (like `C-d`/`C-u`). Back/forward = Cmd+[ / Cmd+].

### SYM — hold right Cmd (or hold `v` / `m`)

```
'      {      [      (      %         &     )     ]     }     "
-      ^      `      ~      $         #     osCtl osSft osOpt osCmd
+      =      *      /      @         |     \     ?     !     :

                            Space = _
```

Holding `v` or `m` reaches SYM without the thumb's tri-layer FUN; `v` is the comfortable side for the right-hand symbols and one-shot mods.

### NUM — hold `c` / `,`

```
(      )      ·      R$     ·         +     7     8     9     *
osCmd  osOpt  osSft  osCtl  Bksp      -     4     5     6     /
·      osSft  ·      000    ,000      ,     1     2     3     .

                            Space = 0

thumbs:  [·] [·] [tap: exit | hold: NAV] [Space: 0] [tap: 0 | hold: SYM]
```

Ctrl+5 = `f` then `5`. `000`/`,000` are typing macros; `R$` types "R$ " — edit or delete in the config. In NUM, Space types **0** and never exits — leave NUM by releasing the hold (`c` or `,`) or tapping the NAV thumb (Left Cmd).

### FUN — hold both Cmds (or hold `z` / `/`)

```
1      2      3      4      5         6     7     8     9     0
osCmd  osOpt  osSft  osCtl  F11       F12   osCtl osSft osOpt osCmd
F1     F2     F3     F4     F5        F6    F7    F8    F9    F10

                        Space = Caps Lock
```

The config-reload combo `g`+`h` only works on this layer. The physical fn/Globe key is untouched, so fn-row media functions still work.

## Combos

Press together (within 60 ms). They only fire after ≥350 ms idle and are disabled during fast typing.

| Combo | Result |
|---|---|
| `q w` | Esc |
| `a s d` | Tab |
| `l ;` | Enter |
| `u i` | Backspace |
| `r t` | Forward delete |
| `s d` / `k l` | Delete word forward / back (Opt+Del / Opt+Bksp) |
| `d k` | Caps Word on/off |
| `d f` / `j k` | Move word right / left (Opt+→ / Opt+←) |
| `f g` / `h j` | Select word right / left (Shift+Opt+→ / ←) |
| `z x` / `x c` / `c v` | Cut / Copy / Paste (Cmd+`X` / `C` / `V`) |
| `s f` / `j l` | Undo / Redo (Cmd+Z / Cmd+Shift+Z) |
| `w s` / `q a` / `r f` | Save / Select all / Find (Cmd+S / A / F) |
| `m ,` | Num Word on (tap the NAV thumb to cancel) |
| `u j` / `i k` / `o l` | `+` / `-` / `*` (vertical, same-finger) |
| `f` / `s` / `d` + right Cmd | `~` / `^` / `` ` `` |
| `q w e r` | Muggle mode on/off |
| `g h` (FUN layer only) | live-reload the config |

## One-shot mods

NUM, SYM (right hand), and FUN have the full `osCmd osOpt osSft osCtl` home row; NAV doesn't (its home row is navigation). **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Cmd+Q = NUM → tap `a` → release → `q`. Cmd+Shift+4 = NUM → tap `a`, tap `d`, press `u`.

## Caps Word and Num Word

**Caps Word** (`d`+`k`): next letters come out capitalized, no Shift held. Ends on Space, Enter, a digit, or 5 s idle; survives apostrophes, Backspace, and the `~ ^ ` `` combos — for underscores, hold `d`/`k` instead.

**Num Word** (`m`+`,`): sticky NUM layer, no key held. Space types a **0** and stays on; tap the NAV thumb (Left Cmd) to cancel. The combo only turns it on (it's disabled inside NUM), so typing digits like 12 can't trip it. The right-hand combos (`l·;` = Enter, `u·i` = Backspace) stay available.

## Quick start

Needs macOS 11+, **kanata v1.10.1+**, and the Karabiner driver from [Install](#install).

1. Validate: `kanata --cfg mac.kbd --check`
2. Run: `sudo kanata --cfg mac.kbd` — kanata must run as root on macOS
3. Test: hold left Cmd + `k` → ↑. Tap Caps Lock → Esc.

**Autostart:** covered by the [Install](#install) section's LaunchDaemons. After changing the config there, reload with `sudo launchctl kickstart -k system/dev.kanata.kanata`.

**After editing the config:** run `--check`, then restart kanata or live-reload: hold both Cmds (FUN) and press `g`+`h`. A failed reload keeps the previous good config running.

## What's remapped

Only 37 keys. Number row, F-row, fn/Globe, Esc, Enter, Backspace, Shift, arrows, Delete, and right Opt are untouched. Tab is plain Tab everywhere except on NAV, where it's the Cmd-Tab swapper.

| Physical key | Tap | Hold |
|---|---|---|
| Caps Lock | Esc | Ctrl |
| Left Ctrl | switch input source (Ctrl+Space) | Ctrl |
| Left Opt | (quick Ctrl) | **Ctrl** |
| Left Cmd | — | **NAV** |
| Right Cmd | — | **SYM** |
| Both Cmds | — | **FUN** |
| `a s d f` / `j k l ;` | the letter | Cmd Opt Shift Ctrl / Ctrl Shift Opt Cmd |
| `g` / `h` | the letter | Hyper (Ctrl+Opt+Shift+Cmd) |
| `z` / `c` | the letter | **FUN** / **NUM** |
| `/` / `,` | the symbol | **FUN** / **NUM** |
| `x` / `.` | the letter / symbol | **NAV** |
| `v` / `m` | the letter | **SYM** |

## Troubleshooting

- **"My Cmd keys don't work."** They're layer keys now: left = NAV, right = SYM, both = FUN. The Cmd *modifier* is on `a`/`;`; Cmd+Tab itself works normally.
- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Left Opt is Ctrl now."** The left Option thumb is a plain Ctrl modifier (a tap just sends a quick Ctrl). NUM moved to hold `c`/`,`; Spotlight is hold `a` (Cmd) + Space. Accents still live on the untouched *right* Opt.
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
