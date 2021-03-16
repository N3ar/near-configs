#!/bin/bash

echo "Requires python development to be installed\n"
pip3 install gdown

BINJA_ID=1GF4pQBLJsKd4xNXe_FhLE231hxGgKIqQ
BINJA_LOC=/opt/binaryninja

# Tool that can download from Google Drive (2020)
#pip3 install gdown

# NOTE Only works on open access files.
pushd ~/Downloads
gdown ${BINJA_ID}

# Unpack Binja to opt 
sudo mkdir ${BINJA_LOC}
sudo tar -zxf binja.tar.gz --directory ${BINJA_LOC}

# Install Binja 
pushd ${BINJA_LOC}


# Put Binja on Python Path


popd

# Remove tar ball
rm -f binja.tar.gz 

