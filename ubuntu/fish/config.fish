#!/bin/fish
if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_prompt
        printf '%s: %s%s%s > ' $USER \
            (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    end

    function fish_greeting
        printf "This machine is %s%s%s. Lets fish...\n" (set_color green) $hostname (set_color normal)
    end
end

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
alias batcode "bat (find ~/code * | fzf)"

alias openconf "cd (find ~/.config -type d | fzf)"
alias opencode "cd (find ~/code -mindepth 1 -maxdepth 1 -type d | fzf)"
alias openscripts "cd ~/.local/scripts"

alias xc "xclip"
alias xp "xclip -o"

# ------------------ END ALIASES ------------------

sh ~/.cargo/env
