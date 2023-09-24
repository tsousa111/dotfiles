if status is-interactive
    # Commands to run in interactive sessions can go here
end
source $HOME/.config/fish/myFunctions/alias.fish
source $HOME/.config/fish/myFunctions/dotfiles.fish

fish_vi_key_bindings
bind \cH backward-kill-path-component
bind "[3;5~" kill-word


export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/tsousa/.ghcup/bin $PATH # ghcup-env
fish_add_path $HOME/.local/share/nvim/mason/bin/
fish_add_path $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin
fish_add_path $HOME/.cargo/bin/
fish_add_path $HOME/.config/emacs/bin

starship init fish | source


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/tsousa/miniconda3/bin/conda
    eval /home/tsousa/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

