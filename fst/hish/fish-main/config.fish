#!/usr/bin/fish
if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_prompt
        printf '%s: %s%s%s > ' $USER (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
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

# matlab needs gtk2
# set -gx GTK_PATH /usr/lib/x86_64-linux-gnu/gtk-2.0

fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts

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

# ------------------ ALIASes / ABBRs ------------------
abbr --erase (abbr --list)

abbr --add cat "bat"

# fish git abbrs
abbr --add gs "git status"
abbr --add ga "git add"
abbr --add gc "git commit"
abbr --add gco "git checkout"

# fish eza abbrs
abbr --add ls "eza"
abbr --add e "eza"
abbr --add ea "eza -a"
abbr --add el "eza -l"
abbr --add ela "eza -la"
abbr --add et "eza -T --group-directories-first"
alias et "eza -T --group-directories-first"
alias e2 "eza -T --group-directories-first -L2"
alias e3 "eza -T --group-directories-first -L3"
# tree view of a git repo
abbr --add eg "eza -Tl --git --git-ignore --no-time --no-permissions --extended"
alias eg "eza -Tl --git --git-ignore --no-time --no-permissions --extended"
# tree view of directories only
abbr --add ed "eza -lTD"
alias ed "eza -lTD"

# dir and subdirectory abbrs
abbr --add zd --set-cursor=! 'z (find .! -type d | fzf)'
abbr --add fdir --set-cursor=! "find ~! -type d -not -path '*/.*'| fzf" # find directory
abbr --add fdira --set-cursor=! "find ! -type d | fzf" # find directory including `.___` dirs 
abbr --add ff --set-cursor=! "find ~! -type f -not -path '*/.*'| fzf" # find file
abbr --add ffa --set-cursor=! "find ! -type f | fzf" # find file including `.___` dirs 

abbr --add batconf "bat (find -L ~/.config -type f | fzf)"
abbr --add batcode "bat (find -L ~/code -type f | fzf)"

# fish just abbrs
abbr --add j "just"

abbr --add op "z (find ~/code -mindepth 1 -maxdepth 1 -type d | fzf)" # "open project"

# "open code subdirectory"
abbr --add oc "z (find ~/code -mindepth 1 -type d \
-not -path '*/.git*' \
-not -path '*/target*' \
-not -path '*dist-newstyle*' \
-not -path '*.stack*' \
-not -path '*.vscode*' \
| fzf)"

abbr --add oscr "z ~/.local/scripts" # "open scripts sub-directory"
abbr --add oconf "z (find ~/.config -type d | fzf)" # "open config sub-directory"
abbr --add od "z (find . -type d | fzf)" # "open sub-directory"
abbr --add omeg "z (find ~/MEGA -type d | fzf)" # "open mega sub-directory"

abbr --add qe --set-cursor=! "$EDITOR (find ! -mindepth 1 | fzf)" # [Q]uick [E]dit a file
abbr --add qec --set-cursor=! "$EDITOR (find ~/code -mindepth 1 | fzf)" # [Q]uick [E]dit a code file

# command line/clipboard interop help
abbr --add xc --position anywhere "xclip -selection clipboard"
abbr --add xp --position anywhere "xclip -selection clipboard -o"
abbr --add xcv --position anywhere "xclip"
abbr --add xpv --position anywhere "xclip -o"

# porsmo abbreviations, quick timers
# abbr --add pt --set-cursor=! "porsmo timer (math !\*60)" # time in minutes
# abbr --add pt-hr --set-cursor=! "porsmo timer (math !\*3600)" # time in hours
# abbr --add pts "porsmo stopwatch"
abbr --add porsmo --set-cursor=! "nix-shell -p porsmo --run porsmo" # time in minutes
abbr --add pt --set-cursor=! "nix-shell -p porsmo --run \"porsmo timer !m\"" # time in minutes
abbr --add pth --set-cursor=! "nix-shell -p porsmo --run \"porsmo timer !h\"" # time in hours
abbr --add pts "nix-shell -p porsmo --run \"porsmo stopwatch\""

abbr --add vi "nvim"

# command I wrote for managing my fish stuff, can reload my config as well
abbr --add mg "manage"

abbr --add --set-cursor=! m "math '(!)'"

# CLI inits

zoxide init fish | source

starship init fish | source
