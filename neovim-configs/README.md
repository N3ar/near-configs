# Neovim Config Instructions

After NvChad installs itself, copy these files into the appropriate place.

If `NvChad` or `Neovim` have updated how they handle plugins, you will need to update this approach. For now:
- `cp init.lua ${XDG_CONFIG_HOME}/nvim/lua/plugins/init.lua`
- `cp mappings.lua ${XDG_CONFIG_HOME}/nvim/lua/mappings.lua`

If there is no XDG_CONFIG_HOME set, it is unlikely that installing this stuff in .nvim will work. Take care.``
