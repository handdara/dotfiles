alias test := test-rebuild-nixos-home
alias switch := rebuild-switch-nixos-home
alias home := rebuild-switch-home

dotfiles_dir := justfile_directory()

# no default at the moment
default:
  @echo "nothing to do..."
  @just --list

# run core/tool justfiles
fst:
  # just {{dotfiles_dir}}/fst/him/
  # just {{dotfiles_dir}}/fst/hez/
  # just {{dotfiles_dir}}/fst/hish/
  # just {{dotfiles_dir}}/fst/git/

# run secondary/tool justfiles
snd:
  # just {{dotfiles_dir}}/snd/gitui/
  # just {{dotfiles_dir}}/snd/starship/
  # just {{dotfiles_dir}}/snd/bash/
  just {{dotfiles_dir}}/snd/matlab/

# test rebuild nixos and home-manager
test-rebuild-nixos-home:
  just {{dotfiles_dir}}/hix/ test-rebuild-flake
  just {{dotfiles_dir}}/hix/ test-rebuild-home-mngr-flake

# rebuild nixos and home-manager using most up-to-date method and switch
rebuild-switch-nixos-home:
  just {{dotfiles_dir}}/hix/ rebuild
  just {{dotfiles_dir}}/hix/ rebuild-home-mngr

# rebuild only home-manager using most up-to-date method and switch
rebuild-switch-home:
  just {{dotfiles_dir}}/hix/ rebuild-home-mngr

# unlink directories needed to switch home-manager
unlink:
  just {{dotfiles_dir}}/fst/him/ unlink
  just {{dotfiles_dir}}/fst/hez/ unlink
  just {{dotfiles_dir}}/fst/hish/ unlink

# purge directories needed to switch home-manager
purge:
  just {{dotfiles_dir}}/fst/hish/ purge
  just {{dotfiles_dir}}/snd/starship/ purge
  just {{dotfiles_dir}}/fst/him/ purge
  just {{dotfiles_dir}}/fst/hez/ purge
  just {{dotfiles_dir}}/fst/hish/ purge

# retrieve the lazy.vim lock-file
get-lazylock:
  just {{dotfiles_dir}}/fst/him/ get-lazylock
