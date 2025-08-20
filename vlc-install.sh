#!/bin/bash
#
# TODO https://unix.stackexchange.com/questions/4988/how-do-i-test-to-see-if-an-application-exists-in-path
# Create helper functions for exists() and exists_in_path()
if type "guix" >/dev/null 2>/dev/null; then
    guix install vlc
elif type "snap" >/dev/null 2>/dev/null; then
    sudo snap install vlc
fi
