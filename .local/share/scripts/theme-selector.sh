#!/bin/bash

# defaults
theme_options=(
    "catppuccin-dark"
    "gruvbox-material-dark"
    "catppuccin-light"
    "gruvbox-material-light"
)

# rofi script to get what theme to use
chosen=$(printf '%s\n' "${theme_options[@]}" | rofi -dmenu -p "Choose a theme")

theme=$(echo "${chosen}" | cut -d- -f1)
background=$(echo "${chosen}" | cut -d- -f2)

# change rofi theme
sed -i "s/\(@import \".config\/rofi\/colors\/\).*/\1${theme}-${background}.rasi\"/" ~/.config/rofi/config.rasi

# change neovim theme
sed -i "s/\(local color = \).*/\1\"${theme}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua
sed -i "s/\(local background = \).*/\1\"${background}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua

# change xresources
xresources_themes=".Xresources.d"
sed -i "s/#include \".*\"/#include \"~\/${xresources_themes}\/${theme}-${background}\"/" ~/.Xresources


