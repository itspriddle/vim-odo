" odo.vim
" Author:  Joshua Priddle <jpriddle@nevercraft.net>
" URL:     https://github.com/itspriddle/vim-odo
" Version: 0.1.0
" License: Same as Vim itself (see :help license)

if exists('g:loaded_odo') || &cp || ! has('gui_macvim')
  finish
endif
let g:loaded_odo = 1

function! s:ResizeWindow(direction, ...)
  let steps = a:0 ? a:1 : 10

  if a:direction == 'x+'
    exe 'set columns+='.steps
  elseif a:direction == 'x-'
    exe 'set columns-='.steps
  elseif a:direction == 'y+'
    exe 'set lines-='.steps
  elseif a:direction == 'y-'
    exe 'set lines+='.steps
  endif
endfunction

command! -nargs=+ Guiresize call s:ResizeWindow(<f-args>)

silent! map <unique> <silent> <C-M-l> :Guiresize x+<cr>
silent! map <unique> <silent> <C-M-h> :Guiresize x-<cr>
silent! map <unique> <silent> <C-M-k> :Guiresize y+<cr>
silent! map <unique> <silent> <C-M-j> :Guiresize y-<cr>

function! s:MoveWindow(direction, ...)
  let pixels = a:0 ? a:1 : 20

  if a:direction == 'left'
    let newpos = (getwinposx() - pixels).' '.getwinposy()
  elseif a:direction == 'right'
    let newpos = (getwinposx() + pixels).' '.getwinposy()
  elseif a:direction == 'up'
    let newpos = getwinposx().' '.(getwinposy() + pixels)
  elseif a:direction == 'down'
    let newpos = getwinposx().' '.(getwinposy() - pixels)
  endif
  exe 'winpos '.newpos
endfunction

command! -nargs=+ Guinudge call s:MoveWindow(<f-args>)

silent! map <unique> <silent> <M-l> :Guinudge right<cr>
silent! map <unique> <silent> <M-h> :Guinudge left<cr>
silent! map <unique> <silent> <M-k> :Guinudge up<cr>
silent! map <unique> <silent> <M-j> :Guinudge down<cr>
