#!/bin/bash

p10k_tgt=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [ ! -d "$p10k_tgt" ]; then
	echo "Installing Powerlevel10k...\n"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${p10k_tgt}
fi

cp p10k-configs/.zshrc /home/$(whoami)/.zshrc

echo "[+] Configs are in place! powerlevel10k will run the next time you execute zsh"
