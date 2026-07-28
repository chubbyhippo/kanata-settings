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

Describe 'the shipped configs'
  Describe 'the four Linux builds'
    It 'are byte-identical to one another'
      When call unique_hashes
      The output should eq 1
    End
  End

  Describe 'the Linux build against the Windows one'
    It 'differs in exactly the four DE-dependent alias lines'
      When call changed_lines wins/kanata.kbd debian/kanata.kbd
      The output should eq 8
    End

    Parameters
      '^  overview lmet$'
      '^  minimize M-h$'
      '^  emoji C-\.$'
      '^  screenshot prnt$'
    End

    Example "carries the GNOME value $1"
      When call grep -c "$1" debian/kanata.kbd
      The output should eq 1
    End
  End

  Describe 'every config'
    Parameters
      wins
      mac
      debian
      fedora
      arch
      guix
    End

    Example "$1/kanata.kbd keeps def as the first deflayer"
      When call sh -c "grep -m1 '^(deflayer' $1/kanata.kbd"
      The output should eq '(deflayer def'
    End
  End

  Describe 'the mac build alone'
    It 'carries the 12 F-row aliases the others do not'
      When call grep -c '^  fk[0-9]' mac/kanata.kbd
      The output should eq 12
    End
  End

  Describe 'validation against a real kanata'
    Parameters
      wins
      mac
      debian
      fedora
      arch
      guix
    End

    Example "$1/kanata.kbd passes kanata --check"
      Skip if 'no kanata binary available' [ -z "${KANATA_BIN:-}" ]
      When call check_config "$1"
      The output should include 'config file is valid'
    End
  End
End
