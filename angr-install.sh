#!/bin/bash
sudo apt install python3-dev libffi-dev build-essential virtualenvwrapper -y
sudo apt install python3-pip -y
sudo pip3 install virtualenvwrapper

echo "# angr ENV VARS" >> ~/.zshrc
echo "export WORKON_HOME=${HOME}/.virtualenvs" >> ~/.zshrc
#echo "export PROJECT_HOME=${HOME}/"
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.zshrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv" >> ~/.zshrc
echo "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh" >> ~/.zshrc

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
mkvirtualenv --python=$(which python3) angr && pip3 install angr
