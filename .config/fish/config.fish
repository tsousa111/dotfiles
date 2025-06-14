if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"
export PAGER="bat"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ANDROID_HOME="$HOME/Android/Sdk"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"

export GOPATH="$XDG_DATA_HOME/go"
export ANDROID_HOME="/home/tsousa/Android/Sdk/"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig"

source $XDG_CONFIG_HOME/fish/aliasrc


#fish_default_key_bindings
fish_vi_key_bindings
set fish_cursor_insert block
bind \cH backward-kill-path-component
# bind "[3;5~" kill-word
bind -M insert \cf $XDG_DATA_HOME/scripts/tmux-sessionizer.sh
bind -M default \cf $XDG_DATA_HOME/scripts/tmux-sessionizer.sh

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/tsousa/.ghcup/bin $PATH # ghcup-env
fish_add_path $HOME/.local/share/nvim/mason/bin/
fish_add_path $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
fish_add_path $HOME/.cargo/bin/
fish_add_path $HOME/.config/emacs/bin

fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin

starship init fish | source
