#!/bin/bash

# defaults
theme_options=(
    "catppuccin-dark"
    "gruvbox-material-dark"
    "catppuccin-light"
    "gruvbox-material-light"
)

# rofi script to get what theme to use
chosen=$(printf '%s\n' "${theme_options[@]}" | rofi -dmenu -p "Theme")

theme=$(echo "${chosen}" | rev | cut -d- -f2- | rev)

background=$(echo "${chosen}" | awk -F'-' '{print $NF}')

echo "Theme: ${theme}"
echo "Background: ${background}"
# change rofi theme
sed -i "s/\(@import \".config\/rofi\/colors\/\).*/\1${theme}-${background}.rasi\"/" ~/.config/rofi/config.rasi

# change neovim theme
sed -i "s/\(local color = \).*/\1\"${theme}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua
sed -i "s/\(local background = \).*/\1\"${background}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua

# change xresources
xresources_themes=".Xresources.d"
sed -i "s/#include \".*\"/#include \"~\/${xresources_themes}\/${theme}-${background}\"/" ~/.Xresources
xrdb ~/.Xresources


