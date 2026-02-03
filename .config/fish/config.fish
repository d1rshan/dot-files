if status is-interactive
    set fish_greeting ""
    fastfetch --logo none

    alias ls 'eza --icons'
    alias matrix 'unimatrix -s 96'
    alias dev 'cd ~/Desktop/dev'
    alias ani ani-cli
    alias ff fastfetch
    alias hyprland.conf 'nvim ~/.config/hypr/hyprland.conf'
    alias clock 'tty-clock -c -t -s'
    alias sync:Arch 'rclone sync ~/Arch gdrive:Arch --progress'
    alias dot 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    alias gif 'python3 ~/fun_overlay/main.py ~/fun_overlay/your_gif.gif'
    alias chika 'python3 ~/fun_overlay/main.py ~/fun_overlay/chika.gif'
    alias glog 'git log --pretty=format:"%ad | %h | %s" --date=format:"%H:%M:%S"'
    alias uni 'cd ~/Desktop/23BCE5135/'
    alias helium helium-browser
    alias files 'nautilus . & disown'
    set -x EDITOR nvim

    starship init fish | source
end

set PATH $PATH /home/darsh/.local/bin
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

# pyenv init - | source

# pnpm
set -gx PNPM_HOME "/home/darsh/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

function gcl
    if test (count $argv) -lt 1
        echo "usage: gcl <repo> [dir]"
        return 1
    end

    set repo $argv[1]
    set dir $argv[2]

    if test -n "$dir"
        git clone git@github.com:d1rshan/$repo.git $dir
    else
        git clone git@github.com:d1rshan/$repo.git
    end
end

function 2pdf
    if test (count $argv) -ne 1
        echo "Usage: 2pdf <file-or-directory>"
        return 1
    end

    set target $argv[1]

    if test -d $target
        for f in $target/*.{ppt,pptx,doc,docx,xls,xlsx,odt,odp,ods}
            if test -e $f
                echo "Converting $f"
                libreoffice --headless --convert-to pdf "$f"
            end
        end
        return
    end

    libreoffice --headless --convert-to pdf "$target"
end

function dots
    set -lx GIT_DIR $HOME/.dotfiles
    set -lx GIT_WORK_TREE $HOME
    nvim ~/.config
end
