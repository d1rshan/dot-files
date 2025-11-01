if status is-interactive
    # Commands to run in interactive sessions can go here
    # cmatrix -u 5 -b -s -C green & sleep 1
    # kill $last_pid

    set fish_greeting ""
    # clear
    fastfetch

    alias ls 'eza --icons'
    alias spotify spotify_player

    starship init fish | source
end
