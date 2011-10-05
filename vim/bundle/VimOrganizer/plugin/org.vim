" ********************* IMPORTANT ************
" This sets up the global plugin variables and functions
" 

" if desired, set main directories where you store .org files here,
" these will be used to assemble list of agenda files to choose from
let g:agenda_dirs=[]

" You can (and should) modify TodoSetup() and TagSetup() calls
" in InitBuffer() below, but be careful about changing anything else
function! InitBuffer()
		set filetype=org
		" The two lines below set up TODOS and tag lists for your
		" org files, eventually each file will be able to have
		" these defined with customization lines in the file, but
		" for now must call a function manually.  You can set 
		" different org files up differently, if you want.  As
		" it stands now all org files use same sample setup, below
    call TodoSetup([['TODO','NEXT'],'STARTED',['DONE','CANCELLED']])

		call TagSetup('{@home(h) @work(w) @tennisclub(t)} {easy(e) hard(d)} {computer(c) phone(p)}')

			if !exists('g:in_agenda_search') && (&foldmethod!='expr')
							setlocal foldmethod=expr
							set foldlevel=1
			endif
endfunction     

" These two hooks are currently the only ones enabled in 
" the VimOrganizer codebase, but they are easy to add so if
" there's a particular hook you want go ahead and request it
" or look for where these hooks are implemented in 
" /ftplugin/org.vim and use them as example for placing your
" own hooks in VimOrganizer:
function! Org_property_changed_functions(line,key, val)
        "call confirm("prop changed: ".a:line."--key:".a:key." val:".a:val)
endfunction
function! Org_after_todo_state_change_hook(line,state1, state2)
        "call ConfirmDrawer("LOGBOOK")
        "let str = ": - State: " . Pad(a:state2,10) . "   from: " . Pad(a:state1,10) .
        "            \ '    [' . Timestamp() . ']'
        "call append(line("."), repeat(' ',len(matchstr(getline(line(".")),'^\s*'))) . str)
        
endfunction

"keep all below 
syntax on
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufRead,BufNewFile *.org            call org#SetOrgFileType()
au BufRead *.org :PreLoadTags
au BufWrite *.org :PreWriteTags
au BufWritePost *.org :PostWriteTags
