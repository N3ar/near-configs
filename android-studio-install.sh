#!/bin/bash
HOME="/home/$(whoami)"
DWN="${HOME}/Downloads"
INST="/usr/local"

VER="2020.3.1.25"
echo "Downloading Android Studio ${VER}"
echo "Ensure this is the most recent version."
echo "Continue? (y/n): "
read -s -N 1 -t 15 key
printf "\n"    

if [[ $key != $'\x79' ]]; then
    exit 0
fi

# TODO Check if android-studio tar.gz exists

# Get Android Studio
pushd ${DWN}
ls | grep "android-studio-*"
if [[ $? -eq 1 ]]; then
    echo "Fetching Tarball!"

    wget r5---sn-8xgp1vo-p5qe.gvt1.com/edgedl/android/studio/ide-zips/${VER}/android-studio-${VER}-linux.tar.gz
    if [[ $? != 0 ]]; then
        echo "Download error. Go to https://developer.android.com/studio and"
        echo "download manually."
        exit 0
    fi

fi

pushd ${INST}
ls | grep android-studio
if [[ $? -eq 1 ]]; then
    echo "Unpacking Android Stuido"
    sudo tar -zxvf $(ls ${DWN}/android-studio-*)
fi
popd #INST

rm $(ls | grep android-studio | grep tar)
popd #DWN

sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

echo "Running Android Studio for initial setup."
echo "Close Android Studio when complete."
sudo ${INST}/android-studio/bin/studio.sh

echo "path+=('${HOME}/Android/tools')" >> $HOME/.zshrc
echo "path+=('${HOME}/Android/tools/bin')" >> $HOME/.zshrc
echo "path+=('${HOME}/Android/platform-tools')" >> $HOME/.zshrc

export PATH
