alias a := session
alias home := switch-home
session_name := 'cfg'
hd := env_var('HOME')
jd := justfile_directory()
startup_cmd := 'nix develop'

# no default at the moment
default:
    @echo "nothing to do..."
    @just --list

# test rebuild nixos and home-manager
test:
    just {{jd}}/hix/ test-nixos
    just {{jd}}/hix/ test-home-mngr

# rebuild nixos and home-manager using most up-to-date method and switch
switch: _check_fmt switch-nixos switch-home

switch-nixos:
    just {{jd}}/hix/ switch-nixos
    @echo "current generation $(nixos-rebuild list-generations | awk '/current/ {print $1}')"

# rebuild only home-manager using most up-to-date method and switch
switch-home: _check_fmt 
    just {{jd}}/hix/ switch-home-mngr

# purge directories needed to switch home-manager
purge: 
    -just {{jd}}/fst/hish/ purge
    -just {{jd}}/fst/him/ purge
    -just {{jd}}/fst/hez/ purge
    -just {{jd}}/fst/hish/ purge
    -just {{jd}}/snd/awesomewm/ purge

# retrieve the lazy.vim lock-files
get-lazylock:
    just {{jd}}/fst/him/ get-lazylock

# retrieve the lazy.vim lock-files
place-lazylock:
    just {{jd}}/fst/him/ place-lazylock

dev-nvim:
    just {{jd}}/fst/him/ replace-nix

# "dev mode", i.e. replace the nix home manager controlled cfgs with a symlink for fast dev
dev: dev-nvim
    just {{jd}}/fst/hez/ replace-nix
    just {{jd}}/snd/awesomewm/ replace-nix

_git_add: _check_fmt
    git add .

# replace the symlinked cfgs with nix home manager controlled, i.e. quit "dev-mode"
stable: _git_add purge && switch-home place-lazylock

edit:
    nvim

@_check_fmt:
    nix develop --command alejandra --check .

fmt:
    nix develop --command alejandra .

# start tmux session
session:
    #!/usr/bin/env bash
    set -exo pipefail
    if ! tmux has-session -t={{session_name}} 2> /dev/null; then
        tmux new-session -ds {{session_name}} -c {{jd}} {{startup_cmd}}
    fi
    if [ -z $TMUX ] ; then
        echo 'tmux a -t {{session_name}}' | xclip -rmlastnl -selection clipboard
        echo 'Run `tmux a -t {{session_name}}`. Which has been placed into the system clipboard.'
    else
        echo 'switching client'
        tmux switch-client -t {{session_name}}
    fi
