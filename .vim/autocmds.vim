"https://redd.it/kz84u
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=3000
au InsertLeave * let &updatetime=updaterestore

au BufNewFile,BufRead * if &syntax == '' | setlocal spell | endif

autocmd FileType ruby map <C-b> :!ruby %<CR>
autocmd FileType javascript map <C-b> :!node %<CR>
autocmd FileType ruby map <C-t> :!rspec %<CR>

