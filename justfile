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
  just {{dotfiles_dir}}/fst/him/util/
  just {{dotfiles_dir}}/fst/hez/util/
  just {{dotfiles_dir}}/fst/hish/util/
  just {{dotfiles_dir}}/fst/git/

# re-link nixos configs and rebuild OS, builds using most up to date method
rebuild: pull-core-submodules
  just {{dotfiles_dir}}/hix/ r

# run secondary/tool justfiles
secondary:
  just {{dotfiles_dir}}/snd/gitui/
  just {{dotfiles_dir}}/snd/matlab/
  just {{dotfiles_dir}}/snd/starship/
  just {{dotfiles_dir}}/snd/bash/
  
# clean bash config
clean-bash:
  just {{dotfiles_dir}}/snd/bash/ clean

# clean fish config
clean-fish:
  just {{dotfiles_dir}}/fst/hish/ clean-fish-cfg

# update submodules with remote merge opts
merge-submodules:
  git submodule update --remote --merge
