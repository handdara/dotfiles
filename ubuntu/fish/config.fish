#!/usr/bin/fish
if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_prompt
        printf '%s: %s%s%s > ' $USER \
            (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    end

    function fish_greeting
        printf "This machine is %s%s%s. Lets fish...\n" (set_color green) $hostname (set_color normal)
        # ------------------ IS WSL? ------------------
        if set -q WSL_DISTRO_NAME[1]
            printf "I think you are working in %sWSL%s.\n" (set_color green) (set_color normal)
        else    
            # printf "I think you are %snot%s working in WSL.\n" (set_color green) (set_color normal)  
        end
    end
end

# default editor
set -gx EDITOR hx

# miniconda3
# disable conda autoactivate for now
set -gx CONDA_AUTO_ACTIVATE_BASE false
# end miniconda3

fish_add_path ~/.cargo/bin
fish_add_path ~/matlab/r2022b/bin
fish_add_path /usr/local/texlive/2023/bin/x86_64-linux/
fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts
fish_add_path /usr/local/go/bin
fish_add_path ~/go/bin

# ------------------ Custom Funcs ------------------

function today-onlydate
    date +'%d%b%Y'
end

function today
    date +'%d%b%Y,  %a'
end

function today-time
    date +'%d%b%Y,  %a,  %H:%M'
end

if set -q WSL_DISTRO_NAME[1]
else
    function dump_okular
        echo $argv > ~/okular_file_line_dump.log
    end
end

# ------------------ ALIASes / ABBRs ------------------

# alias out ls to exa
abbr --add ls "exa"

# alias out cat to bat
abbr --add cat "bat"

abbr --add e "exa"
abbr --add ea "exa -a"
abbr --add el "exa -l"
abbr --add ela "exa -la"
abbr --add et "exa -Tl --no-time"
# tree view of a git repo
abbr --add eg "exa -Tl --git --git-ignore --no-time --no-permissions --extended"
abbr --add ed "exa -lTD"

abbr --add zdi "zellij --session dothe --layout dothe"

abbr --add batconf "bat (find ~/.config -type f | fzf)"
abbr --add batcode "bat (find ~/code -type f | fzf)"

abbr --add fd "find % -type d -not -path '*/.*/*'| fzf" --set-cursor

abbr --add openproject "z (find ~/code -mindepth 1 -maxdepth 1 -type d | fzf)"

abbr --add opencodedir "z (find ~/code -mindepth 1 -type d \
-not -path '*/.git*' \
-not -path '*/target*' \
-not -path '*dist-newstyle*' \
-not -path '*.stack*' \
-not -path '*.vscode*' \
| fzf)"

abbr --add openscripts "z ~/.local/scripts"

abbr --add openconf "z (find ~/.config -type d | fzf)"

# open helix with fuzzy find in common directories
abbr --add hxfc "hx (find ~/code -mindepth 1 | fzf)"
abbr --add hxfx "hx (find ~/.config -mindepth 1 | fzf)"

# command line clipboard
abbr --add xc "xclip"
abbr --add xp "xclip -o"

# dumb fun
abbr --add confetti "ssh -p 2222 ssh.caarlos0.dev"
abbr --add fireworks "ssh -p 2223 ssh.caarlos0.dev"

# hoogle shortening
abbr --add hsi --set-cursor hoogle search --info \"%\" 
abbr --add hs  --set-cursor hoogle search \"%\" 

# ------------------ IS WSL? ------------------
if set -q WSL_DISTRO_NAME[1]
    abbr --add cdc "cd /mnt/c/"
    abbr --add cdd "cd /mnt/d/"
    abbr --add cde "cd /mnt/e/"
    abbr --add cdf "cd /mnt/f/"

    # attempt to remove blinking cursor here
    # - [ ] fix blinking cursor in WSL2
    # echo -e -n "\e[2 q"

    # set scratch.md path
    # - for my personal zellij setup
    set -gx SCRATCHDIR "~/ansible"
else
    # set scratch.md path
    # - for my personal zellij setup
    set -gx SCRATCHDIR "~/Documents/ansible"
end
set -gx SCRATCHPATH (string join '/' $SCRATCHDIR "scratch.md")

zoxide init fish | source

sh ~/.cargo/env

# miniconda3
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/handdara/apps/miniconda3/bin/conda
    eval /home/handdara/apps/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<
# miniconda3

starship init fish | source
