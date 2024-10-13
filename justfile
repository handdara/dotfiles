alias ms := merge-submodules
alias su := submod-update
alias r := rebuild
alias ufc := update-fst-commits

dotfiles_dir := justfile_directory()

# no default at the moment
default:

# init/update fst git submodules
submod-update:
  git submodule init
  git submodule update --init --recursive

# git add fst, commit and push
update-fst-commits:
  git add fst
  git commit -m "update fst submodules' commit ptrs"
  git push

# run fst/tool justfiles
fst: submod-update
  just {{dotfiles_dir}}/fst/him/util/
  just {{dotfiles_dir}}/fst/hez/util/
  just {{dotfiles_dir}}/fst/hish/util/
  just {{dotfiles_dir}}/fst/git/

# re-link nixos configs and rebuild OS, builds using most up to date method
rebuild: submod-update
  just {{dotfiles_dir}}/hix/ r

# run secondary/tool justfiles
snd:
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
