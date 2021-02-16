#!/bin/bash
echo "Installing zsh dependencies..."
sudo apt install wget curl git -y

echo "Installing zsh core..."
sudo apt install zsh -y

echo "ZSH Installed successfully"
zsh --version

echo "Installing Oh-my-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Configuring OMZ..."
source ~/.zshrc

echo "Installing Custom Fonts and Context Highlighting..."
sudo apt install powerline fonts-powerline zsh-syntax-highlighting -y
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

echo "Setting ZSH as default shell"
USER=$(whoami)
sudo usermod -s $(which zsh) ${USER}
