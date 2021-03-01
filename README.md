# Configs

A shortcuts to setting up new environments. I got tired of doing it bit by bit and forgetting pieces. More tools will be added as they become things I install or think I may install on more than one machine.

## Shell Update

Run the scripts in the following order:

- first.sh
- spacevim-install.sh
- font-install.sh
- zsh-install.sh 
- p10k-install.sh 

## General Tools

- net-tools-install.sh
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

- build-install.sh
- boost-install.sh
- clang-install.sh (important for C dev in SpaceVim)

## Defensive Tools

TODO : Whatever this takes
Largely going to be whatever goes well in user space as an analyst box that
isn't duplicated by the user interface available on SecurityOnion.

## TODOs

Adjustments I should make to further automate this when I have time:

### General

Error handle for each command

### ZSH Install

- switch to zsh before source
- move powerline stuff to fonts

### p10k Install

- automate p10k config entries

### VSCode Install

- Programatically get architecture and update package fetching

### angr Install

- Programatically get the shell used and associated config file

### GDB Install

### qemu Install
