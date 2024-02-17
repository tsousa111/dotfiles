#!/bin/bash

# defaults
theme="catppuccin"
background="dark"


# change rofi theme
sed -i "s/\(@import \".config\/rofi\/colors\/\).*/\1${theme}.rasi\"/" ~/.config/rofi/config.rasi

# change neovim theme
sed -i "s/\(local color = \).*/\1\"${theme}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua
sed -i "s/\(local background = \).*/\1\"${background}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua
# change xresources
