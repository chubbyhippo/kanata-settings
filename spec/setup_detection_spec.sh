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

Describe 'setup.sh detection'
  Include ./setup.sh

  Describe 'the distro family'
    fake_os_release() {
      os_release_field() {
        case "$1" in
          ID)      printf '%s' "$fake_id" ;;
          ID_LIKE) printf '%s' "$fake_like" ;;
        esac
      }
    }

    Parameters
      arch        ""                        arch
      manjaro     "arch"                    arch
      endeavouros "arch"                    arch
      artix       "arch"                    arch
      cachyos     "arch"                    arch
      fedora      ""                        fedora
      nobara      "fedora"                  fedora
      rocky       "rhel centos fedora"      fedora
      guix        ""                        guix
    End

    Example "reads ID=$1 ID_LIKE=${2:-none} as the $3 family"
      fake_id="$1"
      fake_like="$2"
      fake_os_release
      When call detect_family
      The variable family should eq "$3"
    End
  End

  Describe 'an unsupported distro'
    Parameters
      "opensuse-tumbleweed" "opensuse suse"
      alpine                ""
      void                  ""
      debian                ""
      ubuntu                "debian"
    End

    Example "falls back to unknown for $1 rather than guessing"
      fake_id="$1"
      fake_like="$2"
      os_release_field() {
        case "$1" in
          ID)      printf '%s' "$fake_id" ;;
          ID_LIKE) printf '%s' "$fake_like" ;;
        esac
      }
      When call detect_family
      The variable family should eq unknown
    End
  End

  Describe 'the desktop'
    Parameters
      "GNOME"          gnome
      "ubuntu:GNOME"   gnome
      "KDE"            kde
      "plasma"         kde
      "X-Cinnamon"     cinnamon
      "XFCE"           other
      "MATE"           other
      ""               unknown
    End

    Example "reads XDG_CURRENT_DESKTOP='$1' as $2"
      export XDG_CURRENT_DESKTOP="$1"
      export XDG_SESSION_DESKTOP=""
      export DESKTOP_SESSION=""
      When call detect_desktop
      The variable desktop should eq "$2"
    End
  End

  Describe 'WSL'
    It 'recognises WSL from WSL_DISTRO_NAME alone'
      export WSL_DISTRO_NAME=Ubuntu
      When call is_wsl
      The status should be success
    End

    It 'does not claim WSL when neither the env var nor the kernel says so'
      unset WSL_DISTRO_NAME
      is_wsl_isolated() {
        [ -n "${WSL_DISTRO_NAME:-}" ] && return 0
        printf '%s' "$fake_release" | tr '[:upper:]' '[:lower:]' | grep -q 'microsoft\|wsl'
      }
      fake_release='6.6.87-generic'
      When call is_wsl_isolated
      The status should be failure
    End

    It 'recognises a Microsoft kernel release string'
      unset WSL_DISTRO_NAME
      is_wsl_isolated() {
        [ -n "${WSL_DISTRO_NAME:-}" ] && return 0
        printf '%s' "$fake_release" | tr '[:upper:]' '[:lower:]' | grep -q 'microsoft\|wsl'
      }
      fake_release='6.6.87.2-microsoft-standard-WSL2'
      When call is_wsl_isolated
      The status should be success
    End
  End
End
