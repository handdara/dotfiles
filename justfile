alias home := switch-home
session_name := 'cfg'
hd := env_var('HOME')
jd := justfile_directory()
startup_cmd := 'nix develop'

# no default at the moment
default:
    @echo "nothing to do..."
    @just --list

build-vm:
    just {{jd}}/hix/ build-vm

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
    -just {{jd}}/fst/him/ purge
    -just {{jd}}/snd/awesomewm/ purge

_git_add: _check_fmt
    git add .

# replace the symlinked cfgs with nix home manager controlled, i.e. quit "dev-mode"
stable: _git_add purge && switch-home

@_check_fmt:
    nix develop --command alejandra --check .

fmt:
    nixpkgs-fmt .
