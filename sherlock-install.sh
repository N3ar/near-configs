#!/bin/bash
DIR=/usr/local

pushd ${DIR}
sudo git clone https://github.com/N3ar/sherlock.git
pushd ${DIR}/sherlock
sudo git remote add upstream https://github.com/sherlock-project/sherlock.git
sudo git fetch upstream

sudo -H python3 -m pip install -r requirements.txt
sudo -H python3 -m pip install socialscan -I
sudo -H python3 -m pip install holehe -I
popd
popd

./sherlock-update.sh
