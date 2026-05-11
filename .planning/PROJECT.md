# near-configs

## What This Is

A collection of install scripts and supporting dotfiles for managing tools and utilities I use across Linux systems. Each script handles installation, setup, and configuration for a specific tool — from Flatpak apps to low-level development libraries.

## Core Value

One-command installation and configuration of tools — run a script and everything is set up correctly with no manual steps.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Logseq sync: automated git push/pull of notes via systemd services
- [ ] Additional install scripts for on-demand tools
- [ ] Supporting files (systemd units, configs) wired into install scripts

### Out of Scope

- [ ] Package management abstractions — scripts use distro-native methods
- [ ] Cross-platform support — Linux-only (no WSL/macOS targets)

## Context

- Repository contains ~60+ install scripts, each named `{tool}-install.sh`
- Scripts share `env.sh` and `HELPERS.sh` for common functions
- Configuration directories (e.g. `neovim-configs/`, `tmux-configs/`) live alongside scripts
- Target system is a single-user development machine running Arch-based Linux

## Constraints

- **Path conventions**: User-level systemd units go to `~/.config/systemd/user/`
- **Flatpak first**: Prefer Flatpak when available for user-space applications
- **Script location**: Install scripts in `$HOME/` directory; supporting files in subdirectories alongside the script

## Key Decisions

| Decision | Rationale | Outcome |
|---|---|---|
| @@HOME@@ placeholder in systemd units | Avoids %i/%I template specifiers that don't work in plain units; sed substitutes at install time | — Pending |
| Shared install_logseq_sync() function | Both Flatpak and AppImage paths need the same sync setup | — Pending |

---
*Last updated: 2026-05-11 after initialization*
