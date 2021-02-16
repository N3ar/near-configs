#!/bin/bash
echo "Installing Powerlevel10k...\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# TODO Make this automatic
echo "CHANGE ZSH THEME TO powerlevel10k/powerlevel10k IN THE CONFIG."
vim ~/.zshrc
source ~/.zshrc

p10k configure
