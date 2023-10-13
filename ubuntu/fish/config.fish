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

# ------------------ ALIASES ------------------

# alias out ls to exa
alias ls "exa"

alias e "exa"
alias ea "exa -a"
alias el "exa -l"
alias ela "exa -la"
alias et "exa -Tl --no-time"
# tree view of a git repo
alias eg "exa -Tl --git --git-ignore --no-time --no-permissions --extended"
alias ed "exa -lTD"

alias zdi "zellij --session dothe --layout dothe"

alias batconf "bat (find ~/.config -type f | fzf)"
alias batcode "bat (find ~/code -type f | fzf)"

alias fd "find . -type d -not -path '*/.*/*'| fzf"

alias openproject "z (find ~/code -mindepth 1 -maxdepth 1 -type d | fzf)"
alias opencodedir "z (find ~/code -mindepth 1 -type d \
                                -not -path '*/.git*' \
                                -not -path '*/target*' \
                                -not -path '*dist-newstyle*' \
                                -not -path '*.stack*' \
                                -not -path '*.vscode*' \
                    | fzf)"
alias openscripts "z ~/.local/scripts"
alias openconf "z (find ~/.config -type d | fzf)"

# open helix with fuzzy find in code directory
alias hxfc "hx (find ~/code -mindepth 1 | fzf)"
alias hxfx "hx (find ~/.config -mindepth 1 | fzf)"

# command line clipboard
alias xc "xclip"
alias xp "xclip -o"

# dumb fun
alias confetti "ssh -p 2222 ssh.caarlos0.dev"
alias fireworks "ssh -p 2223 ssh.caarlos0.dev"

# ------------------ IS WSL? ------------------
if set -q WSL_DISTRO_NAME[1]
    alias cdc "cd /mnt/c/"
    alias cdd "cd /mnt/d/"
    alias cde "cd /mnt/e/"
    alias cdf "cd /mnt/f/"

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

