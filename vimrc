"-----------------------------------------------------------------------------
" Vim Configuration (Dotfiles)
"
" Brian Cain
"-----------------------------------------------------------------------------

set nocompatible
let &t_Co=256

"-----------------------------------------------------------------------------
"
" Syntax Highlighting
"
"-----------------------------------------------------------------------------

" Markdown Syntax
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.mdx set filetype=markdown
" Powershell files
autocmd BufNewFile,BufReadPost *.ps1 set filetype=ps1

"-----------------------------------------------------------------------------
" ColorColumn for overflow
"-----------------------------------------------------------------------------

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

"-----------------------------------------------------------------------------
" Vundle Config
"-----------------------------------------------------------------------------

" Setting up Vundle
" Found here: http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let has_vundle=1
let vundle_readme=expand('~/.dotfiles/vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.dotfiles/vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.dotfiles/vim/bundle/vundle
    let has_vundle=0
endif

" Vundle setup config
set rtp+=~/.dotfiles/vim/bundle/vundle/
call vundle#rc()

" Required Bundle
Bundle 'gmarik/vundle'
" Syntax Highlighters
Plugin 'jvirtanen/vim-hcl'
Plugin 'joukevandermaas/vim-ember-hbs'
" Copilot
Plugin 'github/copilot.vim'
" Additional Bundles go here"
Bundle 'L9'
Bundle 'Gundo'
Bundle 'kien/ctrlp.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
" Bundle 'PProvost/vim-ps1'
Bundle 'fatih/vim-go'
Bundle 'morhetz/gruvbox'
" Four needed for snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
" Bundle "garbas/vim-snipmate"
" Bundle "honza/vim-snippets"
" Airline
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
" Installing plugins the first time
" If exists, skip
if has_vundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

"-----------------------------------------------------------------------------
"
" Plugin Configuration
"
"-----------------------------------------------------------------------------

" Shortcuts for CtrlP
let g:ctrlp_map = '<c-p>'
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

syntax enable
filetype plugin indent on

" Gundo mapping
nnoremap <silent> <C-U> :GundoToggle<CR>

let g:snipMate = { 'snippet_version': 1 }

let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"-----------------------------------------------------------------------------
"
" Color
"
"-----------------------------------------------------------------------------

colorscheme gruvbox
set bg=dark

"-----------------------------------------------------------------------------
"
" Airline configuration
"
"-----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1

"-----------------------------------------------------------------------------
" Encoding and general usability
"-----------------------------------------------------------------------------
nnoremap <Space> :

set splitbelow
set splitright

set modeline
set ls=2


set cursorline
set showmatch

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

" Line numbering
set number

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
" Macros
"-----------------------------------------------------------------------------

"
" DEBUGGING RUBY
"

" Inserts a `pry` break on a newline
map ,p orequire 'pry'<ENTER>binding.pry<ESC>
map ,b obyebug<ESC>

"
" Waypoint Changelog
"

map ,w o```release-note:FIXME<ENTER>type:TODO WRITE ME<ENTER>```<ESC>

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
set tabstop=2 shiftwidth=2 expandtab

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

"-----------------------------------------------------------------------------
" NERD Tree
"-----------------------------------------------------------------------------

" Invoke NERD Tree with \nt
nmap <leader>nt :NERDTree<CR>

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

let NERDTreeShowHidden=1

"-----------------------------------------------------------------------------
" Latex-Suite
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
