#!/bin/bash
USER=$(whoami)
HOME=/home/${USER}
FONTS=/usr/share/fonts
MESLO=/usr/share/fonts/meslo

# Download Fonts
pushd ${HOME}/Downloads
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Place in Font directory
sudo mkdir -p ${MESLO}
sudo mv *.ttf ${MESLO}

sudo fc-cache -fv ${FONTS}

echo "[+] Before running the configure script, close open terminals so you can set the font to Meslo and default shell to /usr/bin/zsh."
popd
