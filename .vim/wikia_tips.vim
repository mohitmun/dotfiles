"http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers
"bufdo execute "normal! @a" | update
"http://vim.wikia.com/wiki/Search_and_replace_in_multiple_buffers
" Search for current word and replace with given text for files in arglist.
function! Replace(bang, replace)
  let flag = 'ge'
  if !a:bang
    let flag .= 'c'
  endif
  let search = '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
  let replace = escape(a:replace, '/\&~')
  execute 'argdo %s/' . search . '/' . replace . '/' . flag
endfunction


"https://gist.github.com/orlp/8c25ed4abb36372bc6fe
" quick replace occurences
function! MoveToNext()
    if g:should_inject_replace_occurences
        call feedkeys("n")
        call repeat#set("\<Plug>ReplaceOccurences")
    endif

    let g:should_inject_replace_occurences = 0
endfunction

function! ReplaceOccurence()
    " check if we are on top of an occurence
    let l:winview = winsaveview()
    let l:save_reg = getreg('"')
    let l:save_regmode = getregtype('"')
    let [l:lnum_cur, l:col_cur] = getpos(".")[1:2] 
    normal! ygn
    let [l:lnum1, l:col1] = getpos("'[")[1:2]
    let [l:lnum2, l:col2] = getpos("']")[1:2]
    call setreg('"', l:save_reg, l:save_regmode)
    call winrestview(winview)
    
    " if we are on top of an occurence, replace it
    if l:lnum_cur >= l:lnum1 && l:lnum_cur <= l:lnum2 && l:col_cur >= l:col1 && l:col_cur <= l:col2
        exe "normal! cgn\<c-a>\<esc>"
    endif
    
    call feedkeys("n")
    call repeat#set("\<Plug>ReplaceOccurences")
endfunction

function! LineBreakAt(bang, ...) range
  let save_search = @/
  if empty(a:bang)
    let before = ''
    let after = '\ze.'
    let repl = '&\r'
  else
    let before = '.\zs'
    let after = ''
    let repl = '\r&'
  endif
  let pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~[')")
  let find = empty(pat_list) ? @/ : join(pat_list, '\|')
  let find = before . '\%(' . find . '\)' . after
  " Example: 10,20s/\%(arg1\|arg2\|arg3\)\ze./&\r/ge
  execute a:firstline . ',' . a:lastline . 's/'. find . '/' . repl . '/ge'
  let @/ = save_search
endfunction

function! Rename(name, bang)
	let l:curfile = expand("%:p")
	let l:curpath = expand("%:h") . "/"
	let v:errmsg = ""
	silent! exe "saveas" . a:bang . " " . fnameescape(l:curpath . a:name)

	if v:errmsg =~# '^$\|^E329'
		let l:oldfile = l:curfile
		let l:curfile = expand("%:p")
		if l:curfile !=# l:oldfile && filewritable(l:curfile)
			silent exe "bwipe! " . fnameescape(l:oldfile)
			if delete(l:oldfile)
				echoerr "Could not delete " . l:oldfile
			endif
		endif
	else
		echoerr v:errmsg
	endif
endfunction
