alias switch := rebuild-switch-nixos-home
alias home := rebuild-switch-home

dotfiles_dir := justfile_directory()

# no default at the moment
default:
    @echo "nothing to do..."
    @just --list

_matlab:
    just {{dotfiles_dir}}/snd/matlab/

# test rebuild nixos and home-manager
test:
    just {{dotfiles_dir}}/hix/ test-rebuild-flake
    just {{dotfiles_dir}}/hix/ test-rebuild-home-mngr-flake

git-add:
    git add .

# rebuild nixos and home-manager using most up-to-date method and switch
rebuild-switch-nixos-home: git-add
    just {{dotfiles_dir}}/hix/ rebuild
    just {{dotfiles_dir}}/hix/ rebuild-home-mngr

# rebuild only home-manager using most up-to-date method and switch
rebuild-switch-home: git-add
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

# replace the symlinked cfgs with nix home manager controlled, i.e. quit "dev-mode"
stable: purge && rebuild-switch-home
    git add .
