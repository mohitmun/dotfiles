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
command! -nargs=1 -bang Replace :call Replace(<bang>0, <q-args>)
nnoremap <Leader>r :call Replace(0, input('Replace '.expand('<cword>').' with: '))<CR>

