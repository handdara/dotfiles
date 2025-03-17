alias home := switch-home

dotfiles_dir := justfile_directory()
home_dir := env_var('HOME')

# no default at the moment
default:
    @echo "nothing to do..."
    @just --list

# test rebuild nixos and home-manager
test:
    just {{dotfiles_dir}}/hix/ test-nixos
    just {{dotfiles_dir}}/hix/ test-home-mngr

# rebuild nixos and home-manager using most up-to-date method and switch
switch: _check_fmt switch-nixos switch-home

switch-nixos:
    just {{dotfiles_dir}}/hix/ switch-nixos
    @echo "current generation $(nixos-rebuild list-generations | awk '/current/ {print $1}')"

# rebuild only home-manager using most up-to-date method and switch
switch-home: _check_fmt 
    just {{dotfiles_dir}}/hix/ switch-home-mngr

# purge directories needed to switch home-manager
purge: 
    -just {{dotfiles_dir}}/fst/hish/ purge
    -just {{dotfiles_dir}}/fst/him/ purge
    -just {{dotfiles_dir}}/fst/hez/ purge
    -just {{dotfiles_dir}}/fst/hish/ purge
    -just {{dotfiles_dir}}/snd/awesomewm/ purge

# retrieve the lazy.vim lock-files
get-lazylock:
    just {{dotfiles_dir}}/fst/him/ get-lazylock

# retrieve the lazy.vim lock-files
place-lazylock:
    just {{dotfiles_dir}}/fst/him/ place-lazylock

dev-nvim:
    just {{dotfiles_dir}}/fst/him/ replace-nix

# "dev mode", i.e. replace the nix home manager controlled cfgs with a symlink for fast dev
dev: dev-nvim
    just {{dotfiles_dir}}/fst/hez/ replace-nix
    just {{dotfiles_dir}}/snd/awesomewm/ replace-nix

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
