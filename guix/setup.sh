#!/bin/sh
set -eu

main() {
    locate_source
    [ -n "$local_dir" ] || {
        echo "run this script from a local kanata-settings checkout" >&2
        exit 1
    }
    kbd_path="$local_dir/kanata.kbd"

    cat <<EOF

Guix is declarative — there is nothing to install imperatively.
(gnu services desktop) already exports kanata-service-type.

Add to your operating-system:

    (use-modules (gnu services desktop)
                 (guix gexp))

    (services
     (cons* (service kanata-service-type
                     (kanata-configuration
                      (keymaps (list (local-file "$kbd_path")))))
            %desktop-services))

Then:  sudo guix system reconfigure /etc/config.scm
EOF
}

locate_source() {
    local_dir=""
    case "$0" in
        */*) candidate="${0%/*}" ;;
        *)   candidate="." ;;
    esac
    candidate="$(cd "$candidate" 2>/dev/null && pwd || printf '')"
    [ -n "$candidate" ] && [ -r "$candidate/../kanata.kbd" ] \
        && local_dir="$(cd "$candidate/.." && pwd)" || true
}

${__SOURCED__:+return}

main "$@"
