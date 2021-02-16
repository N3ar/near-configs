# Configs

A shortcuts to setting up new environments. I got tired of doing it bit by bit and forgetting pieces. More tools will be added as they become things I install standard.

## Shell Update

Run the scripts in the following order:

- first.sh
- spacevim-install.sh
- font-install.sh
- zsh-install.sh 
- p10k-install.sh 

## General Tools

- vscode-install.sh
- tmux-install.sh

## RE Tools

### Scriptable Analyzers

- angr-install.sh
- binaryninja-install.sh
- gdb-install.sh

## DEV Tools

### Python

- python-dev-install.sh (includes pycharm-community, ipython3)

### C / C++

- gcc-install.sh
- make-install.sh
- boost-install.sh
- clang-install.sh (important for C dev in SpaceVim)

## Defensive Tools

TODO : Whatever this takes

## TODOs

Adjustments I should make to further automate this when I have time:

### General

Error handle for each command

### Fonts Install

- programatically find the directory to install fonts into
- save fonts into downloads folder, if it doesn't exist, create it

### ZSH Install

- switch to zsh before source
- move powerline stuff to fonts
- automate exit from drop in shell to continue script

### p10k Install

- automate config file update
- automate p10k config entries

### VSCode Install

- Programatically get architecture and update package fetching

### angr Install

- Programatically get the shell used and associated config file

### Make Install

### GDB Install

### qemu Install
