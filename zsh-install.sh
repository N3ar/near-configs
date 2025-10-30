#!/bin/bash

source ./HELPERS.sh
source ./env.sh

notify i "Installing zsh dependencies..."
notify i "Installing zsh core..."
if [[ $(is_installed guix) -gt 0 ]]; then
    sudo apt install zsh wget curl git -y
else
    guix install zsh wget curl git
fi

echo "ZSH Installed successfully"
zsh --version

echo "Installing Oh-my-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Configuring OMZ..."
source ~/.zshrc

echo "Installing Custom Fonts and Context Highlighting..."
if [[ $(is_installed guix) -gt 0 ]]; then
    sudo apt install powerline fonts-powerline zsh-syntax-highlighting -y
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
else
    guix install zsh-syntax-highlighting
    sudo apt install powerline fonts-powerline -y
    echo "source $GUIX_PROFILE/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

echo "Setting ZSH as default shell"
USER=$(whoami)
sudo usermod -s $(which zsh) ${USER}
