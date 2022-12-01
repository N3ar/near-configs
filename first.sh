#!/bin/bash
echo "Updating apt repos to avoid broken links"
sudo apt update -y
sudo apt upgrade -y

sudo apt purge -y apport
sudo apt remove -y popularity-contest

sudo apt install -y curl
