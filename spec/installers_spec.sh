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

Describe 'behaviour shared by every installer'
  Describe 'the version gate accepts a new enough kanata'
    Parameters
      setup.sh                 1.11.0
      setup.sh                 1.12.0
      setup.sh                 2.0.0
      debian/install.sh        1.11.0
      openrc/install.sh       1.11.0
      fedora/install.sh        1.12.3
      arch/install.sh          1.12.0
    End

    Example "$1 accepts kanata $2"
      __SOURCED__=1
      . "./$1"
      When call version_at_least "$2" 1.11.0
      The status should be success
    End
  End

  Describe 'the version gate rejects anything below the floor'
    Parameters
      setup.sh                 1.9.0
      debian/install.sh        1.9.0
      openrc/install.sh       1.9.0
      fedora/install.sh        1.10.9
      arch/install.sh          0.11.0
    End

    Example "$1 rejects kanata $2"
      __SOURCED__=1
      . "./$1"
      When call version_at_least "$2" 1.11.0
      The status should be failure
    End
  End

  Describe 'the Debian trap'
    It 'rejects 1.9.0 against 1.11.0, which a lexical compare would accept'
      __SOURCED__=1
      . ./debian/install.sh
      When call version_at_least 1.9.0 1.11.0
      The status should be failure
    End
  End

  Describe 'parsing the version out of kanata --version'
    Parameters
      setup.sh
      debian/install.sh
      openrc/install.sh
      fedora/install.sh
      arch/install.sh
    End

    Example "$1 reads 1.11.0 from the real output shape"
      __SOURCED__=1
      . "./$1"
      stub="$(stub_kanata 1.11.0)"
      When call kanata_version "$stub/kanata"
      The output should eq 1.11.0
    End
  End
End

Describe 'the OpenRC init script'
  Include ./openrc/install.sh

  substitute() {
    sed -e "1s|^#!/sbin/openrc-run\$|#!/usr/bin/openrc-run|" \
        -e "s|^command=\"/usr/bin/kanata\"\$|command=\"/home/mk/.cargo/bin/kanata\"|" \
        -e "s|^command_args=\".*\"\$|command_args=\"--cfg /home/mk/.config/kanata/kanata.kbd --no-wait\"|" \
        -e "s|^command_user=\"user\"\$|command_user=\"mk\"|" \
        ./openrc/kanata.openrc > "$1"
  }

  Describe 'the placeholder guard'
    It 'refuses the unsubstituted template'
      When run verify_substituted ./openrc/kanata.openrc
      The status should be failure
      The stderr should include 'placeholder substitution failed'
    End

    It 'accepts a fully substituted script'
      target="$SHELLSPEC_TMPBASE/kanata.openrc"
      substitute "$target"
      When call verify_substituted "$target"
      The status should be success
    End
  End

  Describe 'substitution'
    Parameters
      '^#!/usr/bin/openrc-run$'
      '^command="/home/mk/.cargo/bin/kanata"$'
      '^command_args="--cfg /home/mk/.config/kanata/kanata.kbd --no-wait"$'
      '^command_user="mk"$'
    End

    Example "produces a line matching $1"
      target="$SHELLSPEC_TMPBASE/kanata.openrc"
      substitute "$target"
      When call grep -c "$1" "$target"
      The output should eq 1
    End
  End

  Describe 'the shipped template'
    It 'uses --cfg, not the --config flag kanata does not have'
      When call grep -c -- '--cfg' ./openrc/kanata.openrc
      The output should eq 1
    End

    It 'passes --no-wait so the supervisor can restart it'
      When call grep -c -- '--no-wait' ./openrc/kanata.openrc
      The output should eq 1
    End

    It 'runs as a named user rather than root'
      When call grep -c '^command_user=' ./openrc/kanata.openrc
      The output should eq 1
    End
  End
End

Describe 'the systemd unit'
  Parameters
    debian
    fedora
    arch
  End

  Example "$1/kanata.service passes --no-wait"
    When call grep -c -- '--no-wait' "./$1/kanata.service"
    The output should eq 1
  End
End

Describe 'macOS TCC permission helpers'
  BeforeAll
    __SOURCED__=1
    . ./mac/install.sh
  End

  make_tcc_db() {
    sqlite3 "$1" "CREATE TABLE access (service TEXT, client TEXT, auth_value INTEGER);
INSERT INTO access VALUES ('kTCCServiceListenEvent', '/opt/homebrew/bin/kanata', 2);
INSERT INTO access VALUES ('kTCCServiceAccessibility', '/opt/homebrew/bin/kanata', 0);"
  }

  It 'treats auth_value 2 as granted'
    db="$SHELLSPEC_TMPBASE/tcc.db"
    make_tcc_db "$db"
    When call tcc_client_allowed "$db" kTCCServiceListenEvent /opt/homebrew/bin/kanata
    The status should be success
  End

  It 'treats auth_value 0 as missing'
    db="$SHELLSPEC_TMPBASE/tcc.db"
    make_tcc_db "$db"
    When call tcc_client_allowed "$db" kTCCServiceAccessibility /opt/homebrew/bin/kanata
    The status should be failure
  End

  It 'prints both Input Monitoring and Accessibility in the guide'
    When call print_permission_guide /opt/homebrew/bin/kanata /opt/homebrew/Cellar/kanata/1.12.0/bin/kanata
    The output should include 'Input Monitoring'
    The output should include 'Accessibility'
    The output should include '/opt/homebrew/Cellar/kanata/1.12.0/bin/kanata'
    The output should include 'launchctl kickstart'
  End
End

Describe 'the udev rule'
  Parameters
    debian
    fedora
    arch
    openrc
  End

  Example "$1/99-input.rules grants the uinput group access to /dev/uinput"
    When call grep -c 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' "./$1/99-input.rules"
    The output should eq 1
  End
End
