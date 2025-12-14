let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/code/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 term://~/code//8192:mg
badd +45 hix/home.nix
badd +1 hix/machines/sha76/battery.nix
badd +1 hix/machines/sha76/bootloader.nix
badd +1 hix/machines/sha76/extra.nix
badd +1 hix/machines/sha76/gpu.nix
badd +1 hix/machines/sha76/hardware-configuration.nix
badd +1 hix/machines/sha76/home.nix
badd +1 hix/machines/sha76/networking.nix
badd +1 hix/machines/sha76/options.nix
badd +2 hix/machines/mixed/home.nix
badd +11 hix/configuration.nix
badd +1 hix/system/fonts/nerdfonts/default.nix
badd +6 hix/system/remote/default.nix
badd +5 hix/system/wm/gdm/default.nix
badd +38 hix/flake.nix
badd +4 hix/user/apps/nvim/sm.nix
badd +206 term://~/code/dotfiles//180410:bash
badd +3 hix/user/apps/btop/default.nix
badd +2 hix/user/apps/nvim/default.nix
badd +1 hix/user/apps/starship/default.nix
argglobal
%argdel
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit hix/home.nix
argglobal
balt term://~/code//8192:mg
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 45 - ((22 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 45
normal! 0
tabnext
argglobal
enew | setl bt=help
help CTRL-W@en
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 566 - ((10 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 566
normal! 065|
tabnext
argglobal
if bufexists(fnamemodify("term://~/code/dotfiles//180410:bash", ":p")) | buffer term://~/code/dotfiles//180410:bash | else | edit term://~/code/dotfiles//180410:bash | endif
if &buftype ==# 'terminal'
  silent file term://~/code/dotfiles//180410:bash
endif
balt hix/user/apps/nvim/sm.nix
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
let s:l = 206 - ((40 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 206
normal! 06|
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
