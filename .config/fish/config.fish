if status is-interactive
    set fish_greeting ""
    fastfetch --logo none

    alias ls 'eza --icons'
    alias spotify spotify_player
    alias waybar_reload 'killall waybar && waybar && waybar & disown'
    alias bhai tgpt
    alias matrix 'unimatrix -s 96'
    alias dev 'cd ~/Desktop/dev'
    alias ani ani-cli
    alias ff fastfetch
    alias theme 'nvim ~/.config/theme/colors.sh'
    alias reload_theme '~/.config/theme/apply_theme.sh'
    alias hyprland.conf 'nvim ~/.config/hypr/hyprland.conf'
    alias clock 'tty-clock -c -t -s'
    alias sync:Arch 'rclone sync ~/Arch gdrive:Arch --progress'
    alias dot 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    alias gif 'python3 ~/fun_overlay/main.py ~/fun_overlay/your_gif.gif'
    alias chika 'python3 ~/fun_overlay/main.py ~/fun_overlay/chika.gif'
    alias glog 'git log --pretty=format:"%ad | %h | %s" --date=format:"%H:%M:%S"'
    alias uni 'cd ~/Desktop/23BCE5135/'
    alias helium helium-browser
    set -x EDITOR nvim

    starship init fish | source
end

set PATH $PATH /home/darsh/.local/bin
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

pyenv init - | source
