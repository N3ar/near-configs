#!/bin/bash

notify() {
    local level="$1"

    case "$level" in
        "i" | "info")
            shift
            echo "[*] ${@} "
            ;;
        "w" | "warn")
            shift
            echo "[!] WARN - ${@} "
            ;;
        "e" | "error")
            shift
            echo "[-] ERROR - ${@} "
            ;;
        "s" | "success")
            shift
            echo "[+] ${@} "
            ;;
        *)
            notify i ${@}
            ;;
    esac
}

update() {
    sudo apt -y update
}

upgrade() {
    sudo apt -y upgrade
}

get_script_dir()
{
    local SOURCE_PATH="${BASH_SOURCE[0]}"
    local SYMLINK_DIR
    local SCRIPT_DIR
    # Resolve symlinks recursively
    while [ -L "$SOURCE_PATH" ]; do
        # Get symlink directory
        SYMLINK_DIR="$( cd -P "$( dirname "$SOURCE_PATH" )" >/dev/null 2>&1 && pwd )"
        # Resolve symlink target (relative or absolute)
        SOURCE_PATH="$(readlink "$SOURCE_PATH")"
        # Check if candidate path is relative or absolute
        if [[ $SOURCE_PATH != /* ]]; then
            # Candidate path is relative, resolve to full path
            SOURCE_PATH=$SYMLINK_DIR/$SOURCE_PATH
        fi
    done
    # Get final script directory path from fully resolved source path
    SCRIPT_DIR="$(cd -P "$( dirname "$SOURCE_PATH" )" >/dev/null 2>&1 && pwd)"
    echo "$SCRIPT_DIR"
}

is_installed() {
    if command -v "${1}" > /dev/null 2>&1; then
        exit 0
    fi
    exit 1
}

# TODO
#
#main() {
#    exit 0
#}
#
#if [ "${1}" != "--source-only" ]; then
#    main "${@}"
#fi
