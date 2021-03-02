#!/bin/bash
echo "Installing Powerlevel10k...\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cp p10k-configs/.zshrc /home/$(whoami)/.zshrc
source ~/.zshrc

echo "If p10k configure hasn't run yet do it manually after closing all shells and opening a new one."
