dotfiles_dir := justfile_directory()

# runs: core, secondary
default: core secondary

# init/update core git submodules
core-submodules:
  git submodule init
  git submodule update

# run core/tool justfiles
core: core-submodules
  just {{dotfiles_dir}}/core/him/util/
  just {{dotfiles_dir}}/core/hez/util/
  just {{dotfiles_dir}}/core/hish/util/
  just {{dotfiles_dir}}/core/hix/util/

# run secondary/tool justfiles
secondary:
  just {{dotfiles_dir}}/secondary/gitui/
  just {{dotfiles_dir}}/secondary/matlab/
  just {{dotfiles_dir}}/secondary/starship/
