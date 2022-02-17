# Configs

A shortcuts to setting up new environments. I got tired of doing it bit by bit and forgetting pieces. More tools will be added as they become things I install or think I may install on more than one machine.

## Shell Update

Run the scripts in the following order:

- first.sh
- spacevim-install.sh
- font-install.sh
- zsh-install.sh (logout and then back in)
- p10k-install.sh 

## General Tools

- net-tools-install.sh
- tmux-install.sh
- vscode-install.sh

## RE Tools

Note: Some tools may be installed as part of others. If you are used to useing them on their own and go to install them separately, and they are already installed... it's fine.

### Scriptable Static Analyzers

- binaryninja-install.sh
- ghidra-install.sh
- jeb-install.sh

### Dynamic Analysis

- angr-install.sh
- gdb-install.sh
- gef-install.sh
- capstone-install.sh
- keystone-install.sh
- frida-install.sh

### Virtualization

- vbox-install.sh
- qemu-install.sh
- unicorn-install.sh

### Exploit enablement

- pwntools-install.sh
- ropper-install.sh

## DEV Tools

### Python

- python-dev-install.sh (includes pycharm-community, ipython3)

### C / C++

- build-install.sh
- boost-install.sh
- clang-install.sh (important for C dev in SpaceVim)
- valgrind-install.sh

### Java

- jre-install.sh (important for OpenRefine in DataScience)

### Android

- android-studio-install.sh
- android-ndk-install.sh

## Defensive Tools

TODO : Whatever this takes
- cuckoo-install.md (Super fucked up, not scriptable)

    Largely going to be whatever goes well in user space as an analyst box that
isn't duplicated by the user interface available on SecurityOnion.

## Data Science

- anaconda-install.sh
- openrefine-install.sh
- matplotlib-install.sh (can be installed in or outside of conda env)

## Additonal Tools

These tools are optional. Some are needed by specific tools above and some are 
just preference. I don't usually add these tools to a distribution unless the 
annotated use case is satisfied.

- jre-install.sh (Important for OpenRefine in DataScience)
- chrome-install.sh (Important for OpenRefine in DataScience)
- spotify-install.sh (Baremetal install music)
- rchat-install.sh
- zoom-install.sh
- pia-vpn-install.sh
- stream-support-install.sh
- libreoffice-install.sh

## TODOs

Adjustments I should make to further automate this when I have time

### General

- Error handle for each command
- Provide exit statuses
- Use exit statuses to nest some commands

### ZSH Install

- Handle logoff and logon after installation

### p10k Install

- automate p10k config entries

### VSCode Install

- Programatically get architecture and update package fetching

### angr Install

- Programatically get the shell used and associated config file

### Anaconda Install

- Programatically add the anaconda initialization code to the user's default
shell

### PIA Install

- Fetch installer from redirecting page
