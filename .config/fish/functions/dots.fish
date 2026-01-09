function dots
    set -lx GIT_DIR $HOME/.dotfiles
    set -lx GIT_WORK_TREE $HOME
    nvim ~/.config
end
