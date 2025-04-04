#!/usr/bin/fish

# Interactive shell setup
# -------------------------------------------------------------------------------------------------

if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_prompt
        printf '%s: %s%s%s > ' $USER (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    end

    function fish_greeting
    end

    fish_config theme choose '@fish_theme@'
    fish_vi_key_bindings
end

# Adding to path and other env vars
# -------------------------------------------------------------------------------------------------

fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts
fish_add_path ~/.yarn/bin

set -gx EZA_COLORS "di=38;5;12:da=38;5;12"

# Custom Funcs
# -------------------------------------------------------------------------------------------------

function today-onlydate
    date +'%d%b%Y'
end

function today
    date +'%d%b%Y,  %a'
end

function today-time
    date +'%d%b%Y,  %a,  %H:%M'
end

# ALIASes / ABBRs 
# -------------------------------------------------------------------------------------------------

abbr --erase (abbr --list)

abbr --add cat bat

# fish git abbrs
abbr --add gs "git status"
abbr --add ga "git add"
abbr --add gc "git commit"
abbr --add gp "git push"
abbr --add gco "git checkout"

alias ls eza # fish eza abbrs
abbr --add e eza
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
abbr --add fdirh --set-cursor=! "fd --type d -HI . ~! | fzf" # find directory, exclude .dirs
abbr --add ffh --set-cursor=! "fd --type f -HI . ~! | fzf" # find file, exclude .dirs
abbr --add fdir --set-cursor=! "fd --type d -HIL . ! | fzf" # find directory including `.___` dirs 
abbr --add ff --set-cursor=! "fd --type f -HIL . ! | fzf" # find file including `.___` dirs 

abbr --add bx "bat (fd -LHI --type f . ~/.config | fzf)"
abbr --add bc "bat (fd -LHI --type f . ~/code | fzf)"

# fish just abbrs
abbr --add j just
alias j just
# "open code subdirectory"
abbr --add zc "z (fd --type d . ~/code | fzf)"
abbr --add zs "z ~/.local/scripts" # "open scripts"
abbr --add zx "z (fd --type d . ~/.config | fzf)" # "open config sub-directory"
abbr --add zd --set-cursor=! 'z (fd --type d .! | fzf)' # open subdirectory of current dir
abbr --add zm "z (fd --type d -HI . ~/MEGA | fzf)" # "open mega sub-directory"
abbr --add zp "z (fd --min-depth 1 --max-depth 1 --type d . ~/code | fzf)" # "open project"
abbr --add zt "z (mktemp -d)" # "open temp directory"

abbr --add qe --set-cursor=! "$EDITOR (fd --min-depth 1 . ! | fzf)" # [Q]uick [E]dit a file
abbr --add qec --set-cursor=! "$EDITOR (fd --min-depth 1 . ~/code | fzf)" # [Q]uick [E]dit a code file

# command line/clipboard interop help
abbr --add xc --position anywhere "xclip -selection clipboard"
abbr --add xp --position anywhere "xclip -selection clipboard -o"
abbr --add xcv --position anywhere xclip
abbr --add xpv --position anywhere "xclip -o"

# porsmo abbreviations, quick timers
# abbr --add pt --set-cursor=! "porsmo timer (math !\*60)" # time in minutes
abbr --add p nix-shell -p porsmo --run porsmo # time in minutes
abbr --add pt --set-cursor=! "nix-shell -p porsmo --run \"porsmo timer !m\"" # time in minutes
abbr --add pth --set-cursor=! "nix-shell -p porsmo --run \"porsmo timer !h\"" # time in hours
abbr --add pts "nix-shell -p porsmo --run \"porsmo stopwatch\""

abbr --add vi nvim

abbr --add tempvim "vim -n -u NONE -i NONE"

# command I wrote for managing my fish stuff, can reload my config as well
abbr --add mg ~/.local/scripts/mg
abbr --add mgf manage

abbr --add --set-cursor=! m "math '(!)'"

abbr --add hs hsync

# CLI inits
# -------------------------------------------------------------------------------------------------

zoxide init fish | source

starship init fish | source
enable_transience
