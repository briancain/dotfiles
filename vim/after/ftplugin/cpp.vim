"-----------------------------------------------------------------------------
" Mappings
"-----------------------------------------------------------------------------

" F3 to compile, F4 to run
map <F3> :call CompileGpp()<CR>
map <F4> :call CompileRunGpp()<CR>

" Compile g++ {{{
func! CompileGpp()
  exec "w"
  exec "!g++ % -o %<"
endfunc
" }}}

" Compile and run g++ {{{
func! CompileRunGpp()
  exec "call CompileGpp()"
  exec "! ./%<"
endfunc
" }}}

" Disable auto comments {{{
setlocal comments-=://
setlocal comments+=f://
" }}}
