alias test := test-rebuild-nixos-home
alias switch := rebuild-switch-nixos-home

dotfiles_dir := justfile_directory()

# no default at the moment
default:
  @echo "nothing to do..."
  @just --list

# run core/tool justfiles
fst:
  # just {{dotfiles_dir}}/fst/him/util/
  # just {{dotfiles_dir}}/fst/hez/util/
  # just {{dotfiles_dir}}/fst/hish/util/
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

# clean bash config
clean-bash:
  just {{dotfiles_dir}}/snd/bash/ clean

# clean fish config
clean-fish:
  just {{dotfiles_dir}}/fst/hish/ clean-fish-cfg
