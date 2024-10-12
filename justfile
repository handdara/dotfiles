alias ms := merge-submodules
alias ps := pull-core-submodules
alias r := rebuild
alias snd := secondary
alias ucc := update-core-commits

dotfiles_dir := justfile_directory()

# no default at the moment
default:

# init/update core git submodules
pull-core-submodules:
  git submodule init
  git submodule update --init --recursive

# git add core, commit and push
update-core-commits:
  git add core
  git commit -m "update core submodules' commit ptrs"
  git push

# run core/tool justfiles
core: pull-core-submodules
  just {{dotfiles_dir}}/core/him/util/
  just {{dotfiles_dir}}/core/hez/util/
  just {{dotfiles_dir}}/core/hish/util/
  just {{dotfiles_dir}}/core/hix/util/
  just {{dotfiles_dir}}/core/git/

# re-link nixos configs and rebuild OS, builds using most up to date method
rebuild: pull-core-submodules
  just {{dotfiles_dir}}/core/hix/util/ r

# run secondary/tool justfiles
secondary:
  just {{dotfiles_dir}}/secondary/gitui/
  just {{dotfiles_dir}}/secondary/matlab/
  just {{dotfiles_dir}}/secondary/starship/
  just {{dotfiles_dir}}/secondary/bash/
  
# clean bash config
clean-bash:
  just {{dotfiles_dir}}/secondary/bash/ clean

# update submodules with remote merge opts
merge-submodules:
  git submodule update --remote --merge
