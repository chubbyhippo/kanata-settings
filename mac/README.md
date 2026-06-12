# mac.kbd — macOS kanata config

A [kanata](https://github.com/jtroo/kanata) config for macOS with urob-style "timerless" home row mods: type as fast as you want with zero misfires and zero letter reordering, while keeping all four modifiers plus navigation, symbol, number, and function layers on the home position. Derived from the [Windows config](../wins/README.md): shortcuts are translated to mac conventions, but the mod order stays GASC — Ctrl on the index finger, Cmd on `a`/`;` — so Emacs muscle memory carries over between the two machines.

**The one rule:** while you're typing, the home row is just letters — mods only arm after a 250 ms pause. Rhythm for any shortcut: **tiny pause → hold → press**. Cross-hand chords are instant (pause, then `f`+`j` = Ctrl+J). Same-hand mod+letter never chords — use a one-shot or hold the mod a full 0.3 s first. (Exceptions: `d`/`k` keep their Shift hold and `f`/`j` their Ctrl hold even mid-burst — C-n/C-p right after typing just works.)

## Install

Needs **kanata v1.10.1+** ([releases](https://github.com/jtroo/kanata/releases)) and the Karabiner driver. One-time setup:

1. **Driver:** install the [Karabiner-DriverKit-VirtualHIDDevice **v6.2.0**](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/tag/v6.2.0) `.pkg` (kanata is built against exactly this version), then activate and approve it:

   ```sh
   sudo /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager forceActivate
   ```

   Toggle it on under System Settings → General → Login Items & Extensions → Driver Extensions.

2. **kanata binary:** `brew install kanata`, or put the release binary at `/usr/local/bin/kanata` (`chmod +x` it).

3. **Permissions:** System Settings → Privacy & Security → add the kanata binary to **Input Monitoring** and **Accessibility**.

4. **Config + autostart** (the mac equivalent of `katana.bat` — starts everything at boot):

   ```sh
   base=https://raw.githubusercontent.com/chubbyhippo/kanata-settings/refs/heads/main/mac
   sudo mkdir -p /etc/kanata
   sudo curl -fsSL $base/mac.kbd -o /etc/kanata/mac.kbd
   sudo curl -fsSL $base/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist -o /Library/LaunchDaemons/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist
   sudo curl -fsSL $base/dev.kanata.kanata.plist -o /Library/LaunchDaemons/dev.kanata.kanata.plist
   sudo chown root:wheel /Library/LaunchDaemons/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist /Library/LaunchDaemons/dev.kanata.kanata.plist
   sudo launchctl bootstrap system /Library/LaunchDaemons/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist
   sudo launchctl bootstrap system /Library/LaunchDaemons/dev.kanata.kanata.plist
   ```

   Skip the `org.pqrs` plist if you also run Karabiner-Elements (it manages the daemon itself). Installed kanata with Homebrew? Edit the binary path in `dev.kanata.kanata.plist` first (`/opt/homebrew/bin/kanata` on Apple Silicon).

Then test: hold left Cmd + `k` → ↑.

## Keyboard shortcuts

| You want | Do this |
|---|---|
| Copy / Paste / Cut / Undo | hold left Cmd (NAV) + `c` / `v` / `x` / `z` |
| Ctrl chords (Emacs, terminal) | hold Caps (= Ctrl) + the key — or pause, hold `f`/`j` + a cross-hand key |
| Cmd+Tab | works as always: hold left Cmd, tap Tab (or `w`), release to switch |
| Quit / close (Cmd+Q / Cmd+W) | NUM (hold left Opt): tap `a` (one-shot Cmd), release, press `q` / `w` |
| Reopen tab (Cmd+Shift+T) | NUM: tap `a`, tap `d`, release, press `t` |
| Ctrl+Opt+key (Emacs `C-M-…`) | hold `j`+`k` together + left-hand key, or `d`+`f` + right-hand key |
| Emacs-style arrows | hold left Cmd (NAV): `n`/`p`/`f`/`b` = ↓/↑/→/← · `a`/`e` = Home/End |
| Vim-style arrows | hold left Cmd (NAV): `h`/`j`/`k`/`l` = ←/↓/↑/→ · `d`/`u` = PgDn/PgUp |
| Next / previous browser tab | NAV + `r` / hold Caps + Shift, tap Tab |
| Browser back / forward | NAV + `g` / NAV + `t` (Cmd+[ / Cmd+]) |
| Arrows, PgUp/PgDn, Home/End | hold left Cmd (NAV) |
| Switch input language | tap left Ctrl (Ctrl+Space) |
| Spotlight | tap left Opt (Cmd+Space) |
| Cmd + any left-hand key | NUM: tap `a` (one-shot Cmd), release, press the letter |
| Screenshot (Cmd+Shift+4) | NUM: tap `a`, tap `d`, press `u` (= 4) |
| Select text | hold real Shift + NAV arrows |
| Accents (é, ü, ñ…) | right Opt is untouched — use it as stock |
| Type ALL_CAPS | `d`+`k` together → Caps Word; Space or a digit ends it |
| Type a number / amount | `m`+`,`+`.` together → Num Word; Space exits automatically |
| Esc / Tab / Enter / Backspace | combos `w·e·r` / `w·r` / `s·d·f` / `s·f` (right hand: `u·i·o` / `u·o` / `j·k·l` / `j·l`) |
| F-keys | hold `z` or both Cmds: bottom row = F1–F10 |
| Caps Lock, actually | FUN layer + Space |
| Esc | tap Caps Lock |
| Normal keyboard (lend laptop, games) | `q`+`w`+`e`+`r` together = muggle mode; same to come back |
| Kill kanata entirely | hold physical `LCtrl + Space + Esc` |

## Layer maps

`os` = one-shot modifier (applies to the next key). `·` = nothing.

### DEF — base layer

```
tap:   q   w   e   r   t        y   u   i   o   p
       a   s   d   f   g        h   j   k   l   ;   '
       z   x   c   v   b        n   m   ,   .   /

hold:  ·   ·   ·   ·   ·        ·   ·   ·   ·   ·
       Cmd Opt Sft Ctl Hyp      Hyp Ctl Sft Opt Cmd ·
       FUN ·   NUM ·   ·        ·   ·   ·   ·   ·

thumbs:  [Lang|Ctrl] [Spotlight|NUM] [NAV] [Space] [SYM]
         (LCtrl)     (LOpt)          (LCmd)        (RCmd)
caps:    [Esc|Ctrl]
```

### NAV — hold left Cmd

```
Tab    Swapper  End    Tab→   Fwd→        ⌘V     PgUp  Tab   Bksp  ↑
Home   ⌘S       PgDn   →      ←Back       ←      ↓     ↑     →     Enter
⌘Z     ⌘X       ⌘C     ⌘V     ←           ↓      Media Vol−  Vol+  Del
```

Physical Tab on NAV is also the swapper, so Cmd+Tab works like stock macOS. `Media` tap-dance: 1 tap = play/pause, hold = mute, 2 taps = next, 3 = previous. Emacs-style nav: `n p f b a e` = ↓ ↑ → ← Home End, mirroring `C-n/p/f/b/a/e` — same keys, left Cmd instead of Ctrl. Vim-style too: `h j k l` = ← ↓ ↑ →, with `d`/`u` = PgDn/PgUp (like `C-d`/`C-u`). Back/forward = Cmd+[ / Cmd+].

### SYM — hold right Cmd

```
Esc    {      [      (      %         &     )     ]     }     "
-      ^      `      ~      $         #     osCtl osSft osOpt osCmd
+      =      *      /      @         |     \     ?     !     :

                            Space = _
```

### NUM — hold left Opt (or hold `c`)

```
(      )      ·      R$     ·         +     7     8     9     *
osCmd  osOpt  osSft  osCtl  Bksp      -     4     5     6     /
·      osSft  ·      000    ,000      ,     1     2     3     .

                            Space = 0

thumbs:  [·] [·] [tap: exit | hold: NAV] [Space: exit / 0 while c held] [tap: 0 | hold: SYM]
```

Ctrl+5 = `f` then `5`. `000`/`,000` are typing macros; `R$` types "R$ " — edit or delete in the config. While NUM is held via `c`, Space types **0**; via left Opt or Num Word, Space still exits.

### FUN — hold both Cmds (or hold `z`)

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
| `w e r` / `u i o` | Esc |
| `w r` / `u o` | Tab |
| `s d f` / `j k l` | Enter |
| `s f` / `j l` | Backspace |
| `d k` | Caps Word on/off |
| `d f` / `j k` (keep held) | Ctrl+Opt while held — for Emacs `C-M-…` |
| `m , .` | Num Word on/off |
| `f` / `s` / `d` + right Cmd | `~` / `^` / `` ` `` |
| `q w e r` | Muggle mode on/off |
| `g h` (FUN layer only) | live-reload the config |

## One-shot mods

NUM, SYM (right hand), and FUN have the full `osCmd osOpt osSft osCtl` home row; NAV doesn't (its home row is navigation). **Tap** one → applies to your next keypress only; tap several to stack; hold to use as a normal mod. Armed up to 60 s, and they survive releasing the layer key. This is the answer to every "mod + same-hand key": Cmd+Q = NUM → tap `a` → release → `q`. Cmd+Shift+4 = NUM → tap `a`, tap `d`, press `u`.

## Caps Word and Num Word

**Caps Word** (`d`+`k`): next letters come out capitalized, no Shift held. Ends on Space, Enter, a digit, or 5 s idle; survives apostrophes, Backspace, and the `~ ^ ` `` combos — for underscores, hold `d`/`k` instead.

**Num Word** (`m`+`,`+`.`): sticky NUM layer, no key held. Space exits and types the space; tap the NAV thumb to exit silently. The right-hand combos (`u·o` = Tab, `j·l` = Backspace) stay available.

## Quick start

Needs macOS 11+, **kanata v1.10.1+**, and the Karabiner driver from [Install](#install).

1. Validate: `kanata --cfg mac.kbd --check`
2. Run: `sudo kanata --cfg mac.kbd` — kanata must run as root on macOS
3. Test: hold left Cmd + `k` → ↑. Tap Caps Lock → Esc.

**Autostart:** covered by the [Install](#install) section's LaunchDaemons. After changing the config there, reload with `sudo launchctl kickstart -k system/dev.kanata.kanata`.

**After editing the config:** run `--check`, then restart kanata or live-reload: hold both Cmds (FUN) and press `g`+`h`. A failed reload keeps the previous good config running.

## What's remapped

Only 38 keys. Number row, F-row, fn/Globe, Esc, Enter, Backspace, Shift, arrows, Delete, and right Opt are untouched. Tab is plain Tab everywhere except on NAV, where it's the Cmd-Tab swapper.

| Physical key | Tap | Hold |
|---|---|---|
| Caps Lock | Esc | Ctrl |
| Left Ctrl | switch input source (Ctrl+Space) | Ctrl |
| Left Opt | Spotlight (Cmd+Space) | **NUM** |
| Left Cmd | — | **NAV** |
| Right Cmd | — | **SYM** |
| Both Cmds | — | **FUN** |
| `a s d f` / `j k l ;` | the letter | Cmd Opt Shift Ctrl / Ctrl Shift Opt Cmd |
| `g` / `h` | the letter | Hyper (Ctrl+Opt+Shift+Cmd) |
| `z` / `c` | the letter | **FUN** / **NUM** |

## Troubleshooting

- **"My Cmd keys don't work."** They're layer keys now: left = NAV, right = SYM, both = FUN. The Cmd *modifier* is on `a`/`;`; Cmd+Tab itself works normally.
- **"Mods don't trigger / I get letters."** Pause 250 ms first, then hold. Same-hand mod+letter never chords — use a one-shot. (Shift on `d`/`k` and Ctrl on `f`/`j` work even without the pause.)
- **"Spotlight pops up randomly."** You tapped left Opt without pressing anything else — that's its tap action. Press Esc. (Accents live on *right* Opt.)
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

[urob's ZMK config](https://github.com/urob/zmk-config) (the timerless design), sgraar's [require-prior-idle workaround](https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/comment/o7cmdzd/), the [Windows port](../wins/README.md) this was derived from, and [jtroo/kanata](https://github.com/jtroo/kanata) itself.
