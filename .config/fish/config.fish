if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings
bind \cH backward-kill-path-component
bind "[3;5~" kill-word

function vim
	nvim $argv
end

function ls
	exa $argv
end

function pacu
    sudo pacman -Syu
end

function paci
    sudo pacman -S $argv
end

function pacs
    sudo pacman -Ss $argv
end

function yayi 
    yay -S $argv
end

function yays
    yay -Ss $argv
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/tsousa/.ghcup/bin $PATH # ghcup-env
fish_add_path $HOME/.local/share/nvim/mason/bin/
fish_add_path $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin
