# Copyright (C) 2026 Chubby Hippo
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0-or-later

Describe 'setup.sh command line'
  It 'prints usage and succeeds for --help'
    When run script ./setup.sh --help
    The status should be success
    The output should include 'Usage: setup.sh'
  End

  It 'rejects an unknown option instead of guessing'
    When run script ./setup.sh --nonsense
    The status should be failure
    The stderr should include 'unknown option'
  End

  It 'changes nothing under --detect-only'
    When run script ./setup.sh --detect-only
    The status should be success
    The output should include 'detected:'
    The output should not include '[dry-run]'
    The output should not include 'installed'
  End
End

Describe 'setup.sh dispatch'
  linux_dry_run() {
    export PATH="$(stub_kanata 1.11.0):$PATH"
    ./setup.sh --dry-run --platform linux --family "$1" --init "$2" --desktop "$3" 2>&1
  }

  Describe 'on macOS'
    It 'hands over to the mac installer rather than doing it itself'
      When run script ./setup.sh --dry-run --platform darwin
      The status should be success
      The output should include 'mac/install.sh'
      The output should not include 'groupadd'
    End
  End

  Describe 'on Guix'
    It 'prints the declarative service instead of installing anything'
      When run script ./setup.sh --platform linux --family guix
      The status should be success
      The output should include 'kanata-service-type'
      The output should include 'guix system reconfigure'
      The output should not include 'groupadd'
    End
  End

  Describe 'on a systemd host'
    It 'sets up the groups, the udev rule and a user unit'
      When call linux_dry_run debian systemd gnome
      The output should include 'sudo groupadd --system uinput'
      The output should include 'sudo usermod -aG input,uinput'
      The output should include '/etc/udev/rules.d/99-input.rules'
      The output should include 'systemctl --user enable kanata.service'
      The output should not include 'rc-update'
    End
  End

  Describe 'when no init system is present'
    It 'refuses rather than installing a service nothing will start'
      export PATH="$(stub_kanata 1.11.0):$PATH"
      When run script ./setup.sh --dry-run --platform linux --family debian --init none --desktop gnome
      The status should be failure
      The stderr should include 'no systemd'
      The output should include 'detected:'
    End
  End

  Describe 'with a too-old kanata'
    It 'stops before changing anything'
      export PATH="$(stub_kanata 1.9.0):$PATH"
      When run script ./setup.sh --dry-run --platform linux --family debian --init systemd --desktop gnome
      The status should be failure
      The stderr should include 'too old'
      The output should not include 'groupadd'
    End
  End
End

Describe 'setup.sh desktop patching'
  Include ./setup.sh

  patched() {
    desktop="$1"
    target="$SHELLSPEC_TMPBASE/patched.kbd"
    cp ./debian/kanata.kbd "$target"
    patch_desktop "$target" >/dev/null 2>&1
    grep -c "$2" "$target"
  }

  Describe 'on KDE Plasma'
    Parameters
      '^  overview M-w$'
      '^  minimize M-pgdn$'
      '^  emoji M-\.$'
      '^  langtoggle M-A-k$'
    End

    Example "rewrites the alias to $1"
      When call patched kde "$1"
      The output should eq 1
    End
  End

  Describe 'on GNOME'
    Parameters
      '^  overview lmet$'
      '^  minimize M-h$'
      '^  emoji C-\.$'
      '^  langtoggle M-spc$'
    End

    Example "leaves $1 alone"
      When call patched gnome "$1"
      The output should eq 1
    End
  End

  Describe 'on Cinnamon'
    It 'warns about the two aliases Cinnamon leaves unbound'
      desktop=cinnamon
      target="$SHELLSPEC_TMPBASE/cinnamon.kbd"
      cp ./debian/kanata.kbd "$target"
      When call patch_desktop "$target"
      The stderr should include 'overview'
      The stderr should include 'minimize'
    End

    It 'does not silently rewrite anything'
      When call patched cinnamon '^  overview lmet$'
      The output should eq 1
    End
  End

  Describe 'on an unrecognised desktop'
    It 'says so rather than pretending the GNOME values are right'
      desktop=other
      desktop_raw=XFCE
      target="$SHELLSPEC_TMPBASE/other.kbd"
      cp ./debian/kanata.kbd "$target"
      When call patch_desktop "$target"
      The stderr should include 'not recognised'
    End
  End
End
