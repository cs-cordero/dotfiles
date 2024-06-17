# Source an env file with all variables exported
function loadenv {
    if [[ $# -le 0 ]]; then
        printf "E: Requires a filename.\n" >&2;
        printf "Usage: loadenv filename [arguments]\n";
        return 1;
    fi

    set -a
    . $@
    set +a
}
