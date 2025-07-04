#!/bin/bash
set -ueo pipefail

echo -e "[*] SPOTIFY - If install fails, check for updated instructions:\n\thttps://www.spotify.com/de-en/download/linux/"

curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update -y && sudo apt-get install -y spotify-client

# TODO Add in a grep that check to see if this is already there or not
echo "alias spotify=\"spotify > /dev/null 2>&1 & disown\"" >> ~/.bash_aliases

# TODO Add in checks for migrated /home directories where there is a lock in the ~/.cache folder preventing it from starting on the new host.
