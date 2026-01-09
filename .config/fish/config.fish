if status is-interactive
    set fish_greeting ""
    fastfetch

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
    set -x EDITOR nvim

    starship init fish | source
end

set PATH $PATH /home/darsh/.local/bin
