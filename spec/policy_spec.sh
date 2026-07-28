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

Describe 'repository policy'
  Describe 'the GPL header'
    Parameters
      setup.sh
      wins/kanata.kbd
      wins/katana.bat
      mac/kanata.kbd
      mac/install.sh
      mac/dev.kanata.kanata.plist
      mac/org.pqrs.Karabiner-VirtualHIDDevice-Daemon.plist
      debian/kanata.kbd
      debian/install.sh
      debian/install-openrc.sh
      debian/kanata.service
      debian/kanata.openrc
      debian/99-input.rules
      fedora/kanata.kbd
      fedora/install.sh
      fedora/kanata.service
      fedora/99-input.rules
      arch/kanata.kbd
      arch/install.sh
      arch/kanata.service
      arch/99-input.rules
      guix/kanata.kbd
      guix/kanata-service.scm
    End

    Example "$1 carries the SPDX identifier"
      When call has_license_header "$1"
      The status should be success
    End
  End

  Describe 'the license-only comment rule'
    Parameters
      setup.sh
      mac/install.sh
      debian/install.sh
      debian/install-openrc.sh
      debian/kanata.service
      debian/kanata.openrc
      debian/99-input.rules
      guix/kanata-service.scm
      wins/kanata.kbd
      debian/kanata.kbd
    End

    Example "$1 carries no comment after the header"
      When call comment_lines_after_header "$1"
      The output should eq 0
    End
  End

  Describe 'line endings'
    It 'keeps the Windows launcher CRLF, because cmd.exe needs it'
      When call crlf_count wins/katana.bat
      The output should not eq 0
    End

    Parameters
      setup.sh
      debian/install.sh
      debian/install-openrc.sh
      debian/kanata.openrc
      debian/kanata.kbd
      guix/kanata-service.scm
    End

    Example "$1 is LF only"
      When call crlf_count "$1"
      The output should eq 0
    End
  End

  Describe 'the executable bit'
    Parameters
      setup.sh
      mac/install.sh
      debian/install.sh
      debian/install-openrc.sh
      arch/install.sh
      fedora/install.sh
    End

    Example "$1 is executable"
      When call test -x "$1"
      The status should be success
    End
  End

  Describe 'shell syntax'
    Parameters
      setup.sh
      mac/install.sh
      debian/install.sh
      debian/install-openrc.sh
      fedora/install.sh
      arch/install.sh
      debian/kanata.openrc
    End

    Example "$1 parses under POSIX sh"
      When call sh -n "$1"
      The status should be success
    End
  End
End
