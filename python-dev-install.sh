#!/bin/bash
# Developer environment
sudo snap install pycharm-community --classic
sudo apt install ipython3 -y

# TODO Add Developer leayers to spacevim

# Python PIP and Packages
sudo apt install python3-pip
pip3 install --user pylint
pip3 install --user yapf
pip3 install --user autoflake
pip3 install --user isort
pip3 install --user coverage
pip3 install --user pandas
