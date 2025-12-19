#!/bin/bash

set -euo pipefail

source ./HELPERS.sh
source ./env.sh

notify "Installing by GUIX or APT"
if [[ $(is_installed guix) -gt 0 ]]; then
    notify "Installing tmux via APT"
    sudo apt install -y tmux
else
    notify "Installing tmux via GUIX"
    guix install tmux
fi

# Install TPM package manager for tmux plugins
# TODO Write git update module for TPM
TPMDIR="${XDG_CONFIG_HOME}/tmux/plugins/tpm"
if [ -d ${TPMDIR} ]; then
    notify w "Tmux Package Manager (TPM) is already installed"
else
    notify "Installing Tmux Package Manager (TPM)"
    git clone https://github.com/tmux-plugins/tpm ${TPMDIR}
fi

# if XDG variable is set, copy it to good place, otherwise put in $HOME
TMUXCONFIGS=${SCRIPT_DIR}/tmux-configs
if [[ -v XDG_CONFIG_HOME ]]; then
    notify "XDG Variable set, storing configs relative to there"
    mkdir -p ${XDG_CONFIG_HOME}/tmux
    cp ${TMUXCONFIGS}/tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf
else
    notify w "XDG Variables not present, store $HOME as dotfile"
    cp ${TMUXCONFIGS}/tmux.conf ~/.tmux.conf
fi

#THEME=${TMUXCONFIGS}/tmux-spacemacs-dark/tmux-spacemacs-dark.tmux
#GITURL="https://github.com/sei40kr/tmux-spacemacs-dark.git"
#if [ ! -f "${THEME}" ]; then
#    notify "Installing spacemacs dark theme for tmux"
#    git clone ${GITURL} ${SCRIPT_DIR}/tmux-configs
#    mkdir -p ${XDG_CONFIG_HOME}/tmux/themes
#    ln -s ${THEME} ${XDG_CONFIG_HOME}/tmux/themes/spacemacs-dark.tmux
#else
#    notify w "The theme is already in place"
#fi

# NOTE If spacemacs theme doesn't strike my fancy I will use the powerline thing.
# Currently I am installing it as a backup through TPM
