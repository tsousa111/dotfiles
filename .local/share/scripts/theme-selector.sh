#!/bin/bash

# defaults
theme_options=(
    "catppuccin-dark"
    "gruvbox-material-dark"
    "catppuccin-light"
    "gruvbox-material-light"
)

# rofi script to get what theme to use
chosen=$(printf '%s\n' "${theme_options[@]}" | rofi -dmenu -p "Theme" -theme-str "configuration {show-icons:false;}")
if [[ $chosen == "-" ]]; then
    exit 1
fi
theme=$(echo "${chosen}" | rev | cut -d- -f2- | rev)

background=$(echo "${chosen}" | awk -F'-' '{print $NF}')

# change rofi theme
rofi_conf=~/.config/rofi/config.rasi
rofi_theme_check="${rofi_conf}"/"${chosen}".rasi
if [[ -f $rofi_theme_check ]]; then
    echo "Rofi Theme ${chosen} not found"
    exit 1
fi
sed -i "s/\(@import \"~\/.config\/rofi\/colors\/\).*/\1${theme}-${background}.rasi\"/" $rofi_conf

# change neovim theme
sed -i "s/\(local color = \).*/\1\"${theme}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua
sed -i "s/\(local background = \).*/\1\"${background}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua

# change xresources
xresources_themes=".Xresources.d"
sed -i "s/#include \".*\"/#include \"${xresources_themes}\/${theme}-${background}\"/" ~/.Xresources
xrdb ~/.Xresources

# change tmux
# add case for when tmux is not running
tmux_background=$(grep "^*.background" ~/"${xresources_themes}"/"${theme}"-"${background}" | awk '{print $2}')
tmux_foreground=$(grep "^*.foreground" ~/"${xresources_themes}"/"${theme}"-"${background}" | awk '{print $2}')
sed -i "s/set -g status-style 'bg=.* fg=.*'/set -g status-style 'bg=${tmux_background} fg=${tmux_foreground}'/" ~/.config/tmux/tmux.conf
tmux source "$HOME/.config/tmux/tmux.conf"

# change dunst

# change fish
fish -c "echo 'y' | fish_config theme save '${chosen}'"

# maybe change gtk theme?? and discord??

# recompile i3
i3-msg restart
