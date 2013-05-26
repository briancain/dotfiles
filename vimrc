set nocompatible
filetype off

"-----------------------------------------------------------------------------
" Pathogen: http://www.vim.org/scripts/script.php?script_id=2332
" This needs to occur after filetype off and before filetype plugin on
"-----------------------------------------------------------------------------
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Mixed signals on this command, but it seems common enough to use
filetype plugin indent on
" Python stuff from
" http://www.sontek.net/python-with-a-modular-ide-vim
autocmd FileType python set omnifunc=pythoncomplete#Complete

"-----------------------------------------------------------------------------
" Vundle Config
"-----------------------------------------------------------------------------

set rtp+=~/.dotfiles/vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Gundo'

filetype plugin indent on

" Shortcuts for FF
if v:version >= 703
    nmap <silent> st     :FufFileWithCurrentBufferDir<CR>
    nmap <silent> sT     :FufFileWithFullCwd<CR>
    nmap <silent> s<C-t> :FufFile<CR>
    nmap <silent> sn     :FufCoverageFileChange<CR>
    nmap <silent> sN     :FufCoverageFileChange<CR>
    nmap <silent> sd     :FufDirWithCurrentBufferDir<CR>
    nmap <silent> sD     :FufDirWithFullCwd<CR>
    nmap <silent> s<C-d> :FufDir<CR>
    nmap <silent> sb     :FufMruFile<CR>
    nmap <silent> sB     :FufMruFileInCwd<CR>
endif

" Gundo mapping
nnoremap <silent> <C-U> :GundoToggle<CR>

"-----------------------------------------------------------------------------
" Better Bottom Bar
"-----------------------------------------------------------------------------

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2


"-----------------------------------------------------------------------------
" Encoding and general usability
"-----------------------------------------------------------------------------
nnoremap <Space> :

set splitbelow
set splitright

set modeline
set ls=2

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start

set display=lastline

" Line numbering
set number
" set relativenumber

" Vim window stuff
set linebreak
set guifont=Inconsolata:h15

" Show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
  if v:version >= 700
    set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
  else
    set list listchars=tab:»·,trail:·,extends:…
  endif
else
  if v:version >= 700
    set list listchars=tab:>-,trail:.,extends:>,nbsp:_
  else
    set list listchars=tab:>-,trail:.,extends:>
  endif
endif

"-----------------------------------------------------------------------------
" Search, highlight, spelling, etc.
"-----------------------------------------------------------------------------

" Improved searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase

set incsearch

" Enable syntax highlighting, if one exists
if has("syntax")
    syntax on
endif

" Paragraph formatting stuff:
set formatprg=par

" Store temporary files in a central location
set backupdir=~/.vim/vim-tmp,~/.tmp,~/tmp,~/var/tmp,/tmp
set directory=~/.vim/vim-tmp,~/.tmp,~/tmp,~/var/tmp,/tmp


" Omnifunction
set omnifunc=syntaxcomplete#Complete

" If a file has been changed outside of Vim, reload it inside of Vim
set autoread

"-----------------------------------------------------------------------------
" Spacing
"-----------------------------------------------------------------------------

set autoindent
set smartindent 
set tabstop=4 shiftwidth=4 expandtab


"-----------------------------------------------------------------------------
" Buffers
"-----------------------------------------------------------------------------

" Delete all buffers with \da
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Let me switch buffers with unsaved changes
set hidden


"-----------------------------------------------------------------------------
" Folds and folding
"-----------------------------------------------------------------------------

set foldcolumn=0
set foldmethod=marker "alternatives: indent, syntax, marker

" Change what folded lines show (currently disabled)
function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let comment = substitute(getline(v:foldstart),"^ *","",1)
    let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
    let txt = '+ ' . linetext . ' : "' . comment . '" : length ' . nl
    return txt
endfunction
" set foldtext=MyFoldText()

" map <leader>mv :mkview<CR>
" map <leader>lv :loadview<CR>

"-----------------------------------------------------------------------------
" Keymap stuff
"-----------------------------------------------------------------------------

" noremap <Up> gk 
" noremap <Down> gj

" Toggle text wrapping with \w {{{
noremap <silent> <Leader>w :call ToggleWrap()<CR>

function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction 
" }}}

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
set mouse=a

" Keymappings for :e
map <leader>ew :e <C-R>=expand("%:p:h")."/"<CR> 
map <leader>es :sp <C-R>=expand("%:p:h")."/"<CR>
map <leader>ev :vsp <C-R>=expand("%:p:h")."/"<CR>
map <leader>et :tabe <C-R>=expand("%:p:h")."/"<CR>

" Map for omnicomplete
inoremap <F8> <C-X><C-O>

" Access .vimrc with \vi
nmap <silent> <leader>vi :e $MYVIMRC<CR>
nmap <silent> <leader>vh :e ~/Documents/References/vim.txt<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Relative Number toggle (\rn) {{{
nmap <silent> <leader>rn :call RelativeNumberToggle()<CR>
function! RelativeNumberToggle()
  if &number
    echo "relativenumber ON"
    setlocal relativenumber
  else
    if &relativenumber
      echo "relativenumber OFF"
      setlocal norelativenumber
      setlocal number
    endif
  endif
endfunction
" }}}

" Display hidden characters (paragraph,eol) with \s
"nmap <leader>s :set list!<CR>
"set listchars=tab:▸\ ,eol:¬


"-----------------------------------------------------------------------------
" Compiling code
"-----------------------------------------------------------------------------

" Compile Python with \p2 or \p3
nmap <buffer> <leader>p2 :w<CR>:!/usr/bin/env python % <CR>
nmap <buffer> <leader>p3 :w<CR>:!/usr/bin/env python3 % <CR>


"-----------------------------------------------------------------------------
" NERD Tree
"-----------------------------------------------------------------------------

" Invoke NERD Tree with \nt
nmap <leader>nt :NERDTree<CR>

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>



"-----------------------------------------------------------------------------
" Latex-Suite (which I no longer use)
"-----------------------------------------------------------------------------
"let g:Tex_ViewRule_pdf = '/Applications/Skim.app'

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
"
" " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" " can be called correctly.
set shellslash
"
" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*
"
" " OPTIONAL: This enables automatic indentation as you type.
filetype indent on
"
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
" to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


"-----------------------------------------------------------------------------
" Latex-Box
"-----------------------------------------------------------------------------

" These don't work (for me, at least)
" Use \la instead, from ftplugin/tex.vim
let g:LatexBox_viewer = 'skim'
"let g:LatexBox_latexmk_options = '-pvc'

"-----------------------------------------------------------------------------
" utl.vim
" Plugin for handling hyperlinks
"-----------------------------------------------------------------------------

" Set how Vim opens hyperlinks
let g:utl_cfg_hdl_scm_http_system = 'silent !open "%u"'

" Open hyperlinks with \fo
" Think "Firefox-open"
noremap <leader>fo :Utl<CR>

