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

- binaryninja-install.sh (FIX TO RUN INSTALLER)
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

- docker-install.sh (doesn't fit with RE really)
- jq-install.sh

### Python

- python-dev-install.sh (includes pycharm-community, ipython3)
- virtualenv-install.sh (Surely other things use it, I just don't know)

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
- rootAVD-install.sh

## Red Teaming Tools

- cyberchef-install.sh (Collection https://github.com/gchq/CyberChef)

### Recon Tools

- interactsh-install.sh (https://github.com/projectdiscovery/interactsh)
  - Honestly, I don't really know what it does so here it stays.

#### Port Scanning

- nmap-install.sh
- naabu-install.sh (https://github.com/projectdiscovery/naabu)

#### Domain Enumeration

- lepus-install.sh (https://github.com/gfek/Lepus)
- subfinder-install.sh (https://github.com/projectdiscovery/subfinder)
- httpx-install.sh (https://github.com/projectdiscovery/httpx)

### Vuln Scanning Tools

- nuclei-install.sh (https://github.com/projectdiscovery/nuclei)
- nuclei-template-install.sh (https://github.com/projectdiscovery/nuclei-templates)

#### Web Vuln Scanning Tools

- zaproxy-install.sh (https://www.zaproxy.org/download/)

### Crypanalysis

- rsactftool-install.sh (https://github.com/Ganapati/RsaCtfTool)

### Web Analysis

## Defensive Tools

TODO : Whatever this takes
- cuckoo-install.md (Super fucked up, not scriptable)

    Largely going to be whatever goes well in user space as an analyst box that
isn't duplicated by the user interface available on SecurityOnion.

## OSINT Tools

Some of these tools may be installed other places. That's fine, we can clean
it up later.

### Prerequisites

Python tooling should be installed before installing these tools.

### Video Tools

- vlc-install.sh
- ffmpeg-install.sh

#### Youtube Tools

- youtubedl-install.sh (download yt vods)
- ytdlp-install.sh (???)

#### Stream Tools

- streamlink-install.sh (pipes video streams from services)

### Social Tools

- sherlock-install.sh
- instalooter-install.sh
- instaloader-install.sh

### Image Tools

- gallerydl-install.sh

### Document Tools

- xeuledoc-install.sh (Info on public Google Docs)

### Phone Tools

- phoneinfoga-install.py (https://github.com/sundowndev/PhoneInfoga)

## DevOps Tools

Not something I know much about... required for a project.

- hashicorp-ppa-install.sh
- vault-install.sh

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

## TODOs

Adjustments I should make to further automate this when I have time

### GITHUB FIXES

- Update all github installs to work on FORKs
- Write Fork Updater
  - Read List of Repos
  - Confirm .git presence
  - Provide diff to user to assess updates (accept all option)

### GITHUB UPDATES

- Write script to cull /usr/local for .git repos and update all found

### General

- Error handle for each command
- Provide exit statuses
- Use exit statuses to nest some commands

### Binja Install

- Run included install script that I wasn't using before

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

### Windows tools?
- Could always put something together w/ windows tools and VMs
- https://github.com/mentebinaria/retoolkit

