#!/bin/bash

# Key OS Features
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')

# Directories
# TODO Update script dir to use function "get_script_dir()" from helpers
TMP=/tmp
HOME=/home/$(whoami)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
