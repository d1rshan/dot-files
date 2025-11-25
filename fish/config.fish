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

    set -x EDITOR nvim

    starship init fish | source
end

# Created by `pipx` on 2025-11-03 06:45:28
set PATH $PATH /home/darsh/.local/bin
