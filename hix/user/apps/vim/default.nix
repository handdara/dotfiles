{
    /*
  config, pkgs,
  */
    ...
}: {
    home.file.".vimrc".source = ../../../../fst/him/vim-plain/dot-vimrc;
    # home.file.".vim/after" = {
    #     source = ../../../../fst/him/vim-plain/after;
    #     recursive = true;
    # };
}
