if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR="nvim"
export TERMINAL="kitty"
export TERMINAL_PROG="kitty"
export BROWSER="firefox"
export PAGER="bat"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GOPATH="$XDG_DATA_HOME/go"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

source $XDG_CONFIG_HOME/fish/aliasrc
bind \cf $XDG_DATA_HOME/scripts/tmux-sessionizer.sh

fish_default_key_bindings
#fish_vi_key_bindings
bind \cH backward-kill-path-component
bind "[3;5~" kill-word

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/tsousa/.ghcup/bin $PATH # ghcup-env
fish_add_path $HOME/.local/share/nvim/mason/bin/
fish_add_path $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin
fish_add_path $HOME/.cargo/bin/
fish_add_path $HOME/.config/emacs/bin
# google cloud bin
fish_add_path /opt/google-cloud-cli/bin

starship init fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/tsousa/.miniconda3/bin/conda
    eval /home/tsousa/.miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<
conda deactivate
