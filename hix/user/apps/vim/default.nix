{
    /*
  config, pkgs,
  */
    ...
}: {
    programs.vim.enable = true;
    home.file.".vimrc".text = ''
      set relativenumber
      set number
      inoremap jk <esc>
      inoremap kj <esc>
    '';
}
