alias home := switch-home

dotfiles_dir := justfile_directory()

# no default at the moment
default:
    @echo "nothing to do..."
    @just --list

_matlab:
    just {{dotfiles_dir}}/snd/matlab/

# test rebuild nixos and home-manager
test:
    just {{dotfiles_dir}}/hix/ test-nixos
    just {{dotfiles_dir}}/hix/ test-home-mngr

# rebuild nixos and home-manager using most up-to-date method and switch
switch:
    just {{dotfiles_dir}}/hix/ switch-nixos
    just {{dotfiles_dir}}/hix/ switch-home-mngr

# rebuild only home-manager using most up-to-date method and switch
switch-home:
    just {{dotfiles_dir}}/hix/ rebuild-home-mngr

# unlink directories needed to switch home-manager
unlink-all:
    -just {{dotfiles_dir}}/fst/him/ unlink
    -just {{dotfiles_dir}}/fst/hez/ unlink
    -just {{dotfiles_dir}}/fst/hish/ unlink

# purge directories needed to switch home-manager
purge: unlink-all
    -just {{dotfiles_dir}}/fst/hish/ purge
    -just {{dotfiles_dir}}/fst/him/ purge
    -just {{dotfiles_dir}}/fst/hez/ purge
    -just {{dotfiles_dir}}/fst/hish/ purge

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

# replace the symlinked cfgs with nix home manager controlled, i.e. quit "dev-mode"
stable: purge && switch-home
    git add .
