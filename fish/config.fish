if status is-interactive
    # Commands to run in interactive sessions can go here
    # cmatrix -u 5 -b -s -C green & sleep 1
    # kill $last_pid

    set fish_greeting ""
    # clear
    fastfetch

    alias ls 'eza --icons'
    alias spotify spotify_player
    alias waybar_reload 'killall waybar && waybar && waybar & disown'
    alias bhai tgpt
    alias matrix 'unimatrix -s 96'
    alias dev 'cd ~/Desktop/dev'

    set -x EDITOR nvim

    starship init fish | source
end

# Created by `pipx` on 2025-11-03 06:45:28
set PATH $PATH /home/darsh/.local/bin
