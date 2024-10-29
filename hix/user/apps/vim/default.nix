{/* config, pkgs, */ ... }:
{
  programs.vim.enable = true;
  home.file.".vimrc".text = ''
    set relativenumber
    set number
    inoremap kk <esc>
  '';
}
