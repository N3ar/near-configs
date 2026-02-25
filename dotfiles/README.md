# Dotfiles

TODO - All of it

These are near's dotfiles. They contain preferred aliases and configurations loaded in the shell and with login.

**Q: Why not just edit the existing dotfiles?**
A: Install scripts used to (some still do, working on that) edit the existing dotfiles. While it is possible to update every script with logic to check for the existence of an alias already in those files and to add one if there isn't it is a bit of a pain. 
Additionally, switching between bash and zsh means my configs largely need to be included in an `aliases` file. Placing configurations in an `aliases` file that go beyond the scope of aliases is generally bad practice.
This way I can add my preffered configs to any shell through a simple `if` checking for presence. If my configs are missing, nothing breaks, no warning flood, just move on.

