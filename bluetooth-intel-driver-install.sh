#!/bin/bash
set -ueo pipefail

sudo apt update -y && sudo apt install bluez-firmware firmware-iwlwifi bluez

echo -e "[*] If somehow this still doesn't work, you may need to turn on experimental features per: https://wiki.debian.org/BluetoothUser"
