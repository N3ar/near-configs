#!/bin/bash
ARCH="amd64"
APP="vault"
#APP="vault-enterprise"

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=${ARCH}] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update -y && sudo apt install -y ${APP}
