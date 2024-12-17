alias home := switch-home

dotfiles_dir := justfile_directory()

# no default at the moment
default:
    @echo "nothing to do..."
    @just --list

# test rebuild nixos and home-manager
test:
    just {{dotfiles_dir}}/hix/ test-nixos
    just {{dotfiles_dir}}/hix/ test-home-mngr

# rebuild nixos and home-manager using most up-to-date method and switch
switch: && switch-home
    just {{dotfiles_dir}}/hix/ switch-nixos

# rebuild only home-manager using most up-to-date method and switch
switch-home:
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

# "dev mode", i.e. replace the nix home manager controlled cfgs with a symlink for fast dev
dev:
    just {{dotfiles_dir}}/fst/him/ replace-nix
    just {{dotfiles_dir}}/fst/hez/ replace-nix
    just {{dotfiles_dir}}/snd/awesomewm/ replace-nix

_git_add:
    git add .

# replace the symlinked cfgs with nix home manager controlled, i.e. quit "dev-mode"
stable: _git_add purge && switch-home place-lazylock

edit:
    nvim
