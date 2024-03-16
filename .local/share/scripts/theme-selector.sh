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

if [[ $chosen == "" ]]; then
    exit 0
fi
theme=$(echo "${chosen}" | rev | cut -d- -f2- | rev)

tmux_bg=$(echo "${chosen}" | awk -F'-' '{print $NF}')

# change rofi theme
rofi_conf=~/.config/rofi/config.rasi
rofi_theme_check="${rofi_conf}"/"${chosen}".rasi
if [[ -f $rofi_theme_check ]]; then
    echo "Rofi Theme ${chosen} not found"
    exit 1
fi
sed -i "s/\(@import \"~\/.config\/rofi\/colors\/\).*/\1${theme}-${tmux_bg}.rasi\"/" $rofi_conf

# change neovim theme
sed -i "s/\(local color = \).*/\1\"${theme}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua
sed -i "s/\(local background = \).*/\1\"${tmux_bg}\"/" ~/.config/nvim/lua/tsousa/plugins/colorscheme.lua

# change xresources
xresources_themes=".Xresources.d"
sed -i "s/#include \".*\"/#include \"${xresources_themes}\/${theme}-${tmux_bg}\"/" ~/.Xresources
xrdb ~/.Xresources

# change tmux
# add case for when tmux is not running
tmux_bg=$(xrdb -get background)
tmux_fg=$(xrdb -get foreground)
sed -i "s/set -g status-style 'bg=.* fg=.*'/set -g status-style 'bg=${tmux_bg} fg=${tmux_fg}'/" ~/.config/tmux/tmux.conf
tmux source "$HOME/.config/tmux/tmux.conf"

# change dunst
dunst_template=~/.config/dunst/template
dunst_conf=~/.config/dunst/dunstrc
dunst_bg=$(xrdb -get background)
dunst_fg=$(xrdb -get foreground)
dunst_red=$(xrdb -get color1)
cp "${dunst_template}" "${dunst_conf}"
sed -i "s/\${bg}/${dunst_bg}/" "${dunst_conf}"
sed -i "s/\${fg}/${dunst_fg}/" "${dunst_conf}"
sed -i "s/\${color1}/${dunst_red}/" "${dunst_conf}"
systemctl --user restart dunst.service

# NOTE: need to update fish theme for gruvbox

# change fish
fish -c "echo 'y' | fish_config theme save '${chosen}'"

# maybe change gtk theme?? and discord??

# recompile i3
i3-msg -q restart
