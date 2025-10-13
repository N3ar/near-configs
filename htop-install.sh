#!/bin/bash

if ! command -v guix &> /dev/null; then
    echo "[-] guix is not installed; install guix"
    exit 1
fi

guix install htop
