
" set the height of my window:
set lines=40

" set the width:
set columns=82
  
" default macvim colorscheme:
"colorscheme wombat

" Solarized color scheme for vim and gvim
set background=light
colorscheme solarized 
call togglebg#map("<leader>bg")

" font-style and font-size
set guifont=inconsolata:h26

" get rid of left scrollbar when splitting vertically
set go-=l

" Get rid of menu (m) and toolbar (T)
set guioptions-=m
set guioptions-=T

" a makes visual mode more powerful
" c makes tabs look less fancy, among other things probably
set guioptions=ac

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

