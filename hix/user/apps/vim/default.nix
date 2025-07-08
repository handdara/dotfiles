{
    /*
  config, pkgs,
  */
    ...
}: {
    home.file.".vimrc".source = ../../../../fst/him/vim-plain/init.vim;
    # home.file.".vim/after" = {
    #     source = ../../../../fst/him/vim-plain/after;
    #     recursive = true;
    # };
}
