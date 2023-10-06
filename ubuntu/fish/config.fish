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

# disable conda autoactivate for now
set -gx CONDA_AUTO_ACTIVATE_BASE false

fish_add_path ~/.cargo/bin
fish_add_path ~/matlab/r2022b/bin
fish_add_path /usr/local/texlive/2023/bin/x86_64-linux/
fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts

# ------------------ ALIASES ------------------

alias e "exa"
alias ea "exa -a"
alias el "exa -al"

alias zdi "zellij -s dothe"

alias batconf "bat (find ~/.config -type f | fzf)"
alias batcode "bat (find ~/code -type f | fzf)"

alias fd "find . -type d -not -path '*/.*/'| fzf"

alias openproject "cd (find ~/code -mindepth 1 -maxdepth 1 -type d | fzf)"
alias opencodedir "cd (find ~/code -mindepth 1 -type d \
                                -not -path '*/.git*' \
                                -not -path '*/target*' \
                                -not -path '*dist-newstyle*' \
                                -not -path '*.stack*' \
                                -not -path '*.vscode*' \
                    | fzf)"
alias openscripts "cd ~/.local/scripts"
alias openconf "cd (find ~/.config -type d | fzf)"

# helix fuzzy find in code directory
alias hxfc "hx (find ~/code -mindepth 1 | fzf)"
alias hxfx "hx (find ~/.config -mindepth 1 | fzf)"

alias xc "xclip"
alias xp "xclip -o"

# ------------------ IS WSL? ------------------
if set -q WSL_DISTRO_NAME[1]
    alias cdc "cd /mnt/c/"
    alias cdd "cd /mnt/d/"
    alias cde "cd /mnt/e/"
    alias cdf "cd /mnt/f/"
end

# ------------------ END ALIASES ------------------

zoxide init fish | source

sh ~/.cargo/env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/handdara/apps/miniconda3/bin/conda
    eval /home/handdara/apps/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

