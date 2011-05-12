"-----------------------------------------------------------------------------
" Mappings
"-----------------------------------------------------------------------------

" F3 to compile, F4 to run
map <F3> :call CompileGcc()<CR>
map <F4> :call CompileRunGcc()<CR>

" Compile gcc {{{
func! CompileGcc()
  exec "w"
  exec "!gcc % -o %<"
endfunc
" }}}

" Compile and run gcc {{{
func! CompileRunGcc()
  exec "w"
  exec "!gcc % -o %<"
  exec "! ./%<"
endfunc
" }}}

