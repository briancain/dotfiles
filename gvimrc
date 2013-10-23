" set the height of my window:
set lines=40

" set the width:
set columns=82
  
" Solarized color scheme for vim and gvim
set background=light
"colorscheme solarized 
colorscheme corporation
call togglebg#map("<leader>bg")

set noballooneval

" Switch to wombat colorscheme
" Note: This comes after the Solarized option above. The following should be
" commented out if I intend to use the Solarized color scheme.
"colorscheme wombat

" Toggle wombat and solarized-light with \cc {{{
let g:colortoggle=0
nmap <silent> <leader>cc :call ColorToggle()<CR>
function! ColorToggle()
  if g:colortoggle==0
    colorscheme solarized
    set background=light
    let g:colortoggle=1
  else
    colorscheme wombat
    let g:colortoggle=0
  endif
endfunction
" Toggle wombat and solarized-light with \cc }}}

" font-style and font-size

set guifont=Inconsolata:h15

" get rid of left scrollbar when splitting vertically
set go-=l

" Get rid of menu (m) and toolbar (T)
set guioptions-=m
set guioptions-=T

" a makes visual mode more powerful
" c makes tabs look less fancy, among other things probably
set guioptions=ac

" Set up the gui cursor to look nice
set cursorline
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

