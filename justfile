alias ms := merge-submodules
alias ps := pull-core-submodules
alias snd := secondary

dotfiles_dir := justfile_directory()

# runs: core, secondary
default: core secondary

# init/update core git submodules
pull-core-submodules:
  git submodule init
  git submodule update --init --recursive

# run core/tool justfiles
core: pull-core-submodules
  just {{dotfiles_dir}}/core/him/util/
  just {{dotfiles_dir}}/core/hez/util/
  just {{dotfiles_dir}}/core/hish/util/
  just {{dotfiles_dir}}/core/hix/util/

# run secondary/tool justfiles
secondary:
  just {{dotfiles_dir}}/secondary/gitui/
  just {{dotfiles_dir}}/secondary/matlab/
  just {{dotfiles_dir}}/secondary/starship/
  just {{dotfiles_dir}}/secondary/bash/

# update submodules with remote merge opts
merge-submodules:
  git submodule update --remote --merge

