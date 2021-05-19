#!/bin/bash
# TODO Get the latest one every time
INST=$(pwd)/external-installers
if [ ! -d "${INST}" ]; then
  mkdir ${INST}
fi

ls ${INST} | grep Anaconda3
if [ $? -eq 0 ]; then
  echo "Anaconda3 installer exists: $(ls Anaconda3*)"
else 
  wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh -P ${INST}
fi

pushd ${INST}
chmod +x $(ls Anaconda3*)
./$(ls Anaconda3*)
popd

echo "Anaconda has finsihed installing all components and added to .bashrc"
echo "If using a different shell, copy that component to your shell's rc"
echo "For Example: .zshrc"

echo "If you don't want to automatically be in a conda environment everytime"
echo "you open a shell, run 'conda config --set auto_activate_base false' in"
echo "order to unset the value."

echo "If you want to enter a conda environment, run 'conda env list' and then"
echo "enter a listed environment with 'conda activate myenvname'."

