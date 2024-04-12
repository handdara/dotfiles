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
set -gx EDITOR nvim

# necessary to make okular dark
set -Ux QT_QPA_PLATFORMTHEME gtk2 

# miniconda3
# disable conda autoactivate for now
set -gx CONDA_AUTO_ACTIVATE_BASE false
# end miniconda3

# matlab needs gtk2
set -gx GTK_PATH /usr/lib/x86_64-linux-gnu/gtk-2.0

fish_add_path ~/.cargo/bin
fish_add_path ~/matlab/r2022b/bin
fish_add_path /usr/local/texlive/2023/bin/x86_64-linux/
fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts
fish_add_path /usr/local/go/bin
fish_add_path ~/go/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/apps/lexifer

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
abbr --erase (abbr --list)

abbr --add ls "exa"

abbr --add cat "bat"

abbr --add e "exa"
abbr --add ea "exa -a"
abbr --add el "exa -l"
abbr --add ela "exa -la"

# the following are added so they can be used also by neovim/helix/etc
# tree view
abbr --add et "exa -T --group-directories-first"
alias et "exa -T --group-directories-first"
alias e2 "exa -T --group-directories-first -L2"
alias e3 "exa -T --group-directories-first -L3"
# tree view of a git repo
abbr --add eg "exa -Tl --git --git-ignore --no-time --no-permissions --extended"
alias eg "exa -Tl --git --git-ignore --no-time --no-permissions --extended"
# tree view of directories only
abbr --add ed "exa -lTD"
alias ed "exa -lTD"

abbr --add batconf "bat (find ~/.config -type f | fzf)"
abbr --add batcode "bat (find ~/code -type f | fzf)"

# find directory
abbr --add fdir --set-cursor=! "find ~! -type d -not -path '*/.*'| fzf" 
# find directory including `.___` dirs 
abbr --add fdira --set-cursor=! "find ! -type d | fzf" 
# find file
abbr --add ff --set-cursor=! "find ~! -type f -not -path '*/.*'| fzf" 
# find file including `.___` dirs 
abbr --add ffa --set-cursor=! "find ! -type f | fzf" 

# "open project"
abbr --add op "z (find ~/code -mindepth 1 -maxdepth 1 -type d | fzf)"

# "open code subdirectory"
abbr --add oc "z (find ~/code -mindepth 1 -type d \
-not -path '*/.git*' \
-not -path '*/target*' \
-not -path '*dist-newstyle*' \
-not -path '*.stack*' \
-not -path '*.vscode*' \
| fzf)"

# "open scripts"
abbr --add oscr "z ~/.local/scripts"

# "open config directory"
abbr --add oconf "z (find ~/.config -type d | fzf)"

# open editor with fuzzy find in common directories
abbr --add efc "$EDITOR (find ~/code -mindepth 1 | fzf)"

# command line clipboard
abbr --add xc "xclip"
alias xc "xclip"
abbr --add xp "xclip -o"
alias xp "xclip -o"

# dumb fun
abbr --add confetti "ssh -p 2222 ssh.caarlos0.dev"
abbr --add fireworks "ssh -p 2223 ssh.caarlos0.dev"

# hoogle shortening
abbr --add hsi --set-cursor=! "hoogle search --info \"!\"" 
abbr --add hs  --set-cursor=! "hoogle search \"!\"" 

# porsmo abbreviations, quick timers
# time minutes
abbr --add pt --set-cursor=! "porsmo timer (math !\*60)"
# time hours
abbr --add pt-hr --set-cursor=! "porsmo timer (math !\*3600)"
abbr --add pts "porsmo stopwatch"

abbr --add vi "nvim"
abbr --add vim "nvim"

abbr --add config-refresh "source ~/.config/fish/config.fish"
abbr --add conf-r "source ~/.config/fish/config.fish"

abbr --add ok "flatpak run org.kde.okular"
abbr --add okf "flatpak run org.kde.okular (find ./ -type f -name \"*.pdf\" -not -path '*/.*'| fzf) &"

abbr --add matlab "LD_PRELOAD=/lib/x86_64-linux-gnu/libstdc++.so.6 matlab"
abbr --add matlab-cli "LD_PRELOAD=/lib/x86_64-linux-gnu/libstdc++.so.6 matlab -nodesktop -nosplash"
# abbr --add matlab-cli "matlab -nodesktop -nosplash"

abbr --add --set-cursor=! cht "curl cht.sh/!"

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

# nvm.fish default node version
set -gx nvm_default_version 18
nvm use 18 > /dev/null
