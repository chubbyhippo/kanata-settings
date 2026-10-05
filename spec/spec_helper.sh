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

set -eu

LINUX_CONFIGS="fedora arch guix"
SYSTEMD_FOLDERS="fedora arch"
ALL_CONFIGS="wins mac fedora arch guix"

stub_kanata() {
    stub_version="$1"
    stub_dir="${SHELLSPEC_TMPBASE}/stub-$stub_version"
    mkdir -p "$stub_dir"
    {
        echo '#!/bin/sh'
        echo "[ \"\$1\" = '--version' ] && { echo 'kanata $stub_version'; exit 0; }"
        echo 'exit 0'
    } > "$stub_dir/kanata"
    chmod +x "$stub_dir/kanata"
    printf '%s' "$stub_dir"
}

unique_hashes() {
    for folder in $LINUX_CONFIGS; do
        cksum < "$folder/kanata.kbd"
    done | sort -u | wc -l | tr -d ' '
}

changed_lines() {
    diff "$1" "$2" | grep -c '^[<>]' || true
}

has_license_header() {
    grep -q 'SPDX-License-Identifier: GPL-3.0-or-later' "$1"
}

comment_lines_after_header() {
    case "$1" in
        *.kbd)
            awk '
                /SPDX-License-Identifier/ { seen = 1; next }
                seen && /^[[:space:]]*;;/ { print }
            ' "$1"
            ;;
        *.scm)
            awk '
                /SPDX-License-Identifier/ { seen = 1; next }
                seen && /^[[:space:]]*;/ { print }
            ' "$1"
            ;;
        *)
            awk '
                /SPDX-License-Identifier/ { seen = 1; next }
                seen && /^[[:space:]]*#/ && !/^#!/ { print }
            ' "$1"
            ;;
    esac | grep -cv '^$' || true
}

tracked_files() {
    git ls-files "$@" 2>/dev/null || true
}

kanata_available() {
    [ -n "${KANATA_BIN:-}" ] && [ -x "${KANATA_BIN:-}" ]
}

: "${KANATA_BIN:=$(command -v kanata 2>/dev/null || command -v kanata.exe 2>/dev/null || true)}"
export KANATA_BIN

check_config() {
    cfg="$PWD/$1/kanata.kbd"
    case "$KANATA_BIN" in
        *.exe) command -v wslpath >/dev/null 2>&1 && cfg="$(wslpath -w "$cfg")" ;;
    esac
    "$KANATA_BIN" --cfg "$cfg" --check 2>&1 | tr -d '\r'
}

crlf_count() {
    tr -dc '\r' < "$1" | wc -c | tr -d ' '
}
