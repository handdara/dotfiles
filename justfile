alias ms := merge-submodules
alias su := submod-update
alias r := rebuild
alias ufc := update-fst-commits

dotfiles_dir := justfile_directory()

# no default at the moment
default:

# run fst/tool justfiles
fst: submod-update
  just {{dotfiles_dir}}/fst/him/util/
  just {{dotfiles_dir}}/fst/hez/util/
  just {{dotfiles_dir}}/fst/hish/util/
  just {{dotfiles_dir}}/fst/git/

# run secondary/tool justfiles
snd:
  just {{dotfiles_dir}}/snd/gitui/
  just {{dotfiles_dir}}/snd/matlab/
  just {{dotfiles_dir}}/snd/starship/
  # just {{dotfiles_dir}}/snd/bash/ # bashrc now being handled by home manager
  
# clean bash config
clean-bash:
  just {{dotfiles_dir}}/snd/bash/ clean

# clean fish config
clean-fish:
  just {{dotfiles_dir}}/fst/hish/ clean-fish-cfg
