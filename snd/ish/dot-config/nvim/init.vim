let g:mapleader = " "
let g:maplocalleader = " "

set path+=**
set undodir=~/.undo
set wmnu udf

inoremap jj <esc>
nnoremap <leader>ln :set invrnu invnu<cr>
nnoremap <leader>q q:i
nnoremap <leader>sf :find *
nnoremap <leader>sh :h
nnoremap <leader>so :bro ol<cr>
nnoremap <leader>w :update<cr>
xnoremap <leader>S !sort -r<cr>
xnoremap <leader>s !sort<cr>
