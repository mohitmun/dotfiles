"https://redd.it/kz84u
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore

au BufNewFile,BufRead * if &syntax == '' | setlocal spell | endif
"au BufNewFile,BufRead * if &syntax == 'markdown' | setlocal spell | endif

autocmd FileType ruby map <C-b> :!ruby %<CR>
autocmd FileType javascript map <C-b> :!node %<CR>
autocmd FileType ruby map <C-t> :!rspec %<CR>

augroup auto_move_to_next
    autocmd! InsertLeave * :call MoveToNext()
augroup END

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""

if !empty($SSH_CONNECTION)
  autocmd TextYankPost * call writefile(getreg('0', 1, 1), "/tmp/y") | call system("cat /tmp/y | nc localhost 2000")
endif
