#!/bin/bash

update() {
    sudo apt -y update
}

upgrade() {
    sudo apt -y upgrade
}

# TODO

main() {
    exit 0
}

if [ "${1}" != "--source-only" ]; then
    main "${@}"
fi
