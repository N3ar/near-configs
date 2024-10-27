#!/bin/bash

. HELPERS.sh --source-only

update && upgrade
sudo apt -y install podman
