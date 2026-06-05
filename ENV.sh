#!/bin/bash

# Key OS Features
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')

# Directories
TMP=/tmp
HOME=/home/$(whoami)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
