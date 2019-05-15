
" https://stackoverflow.com/a/5562707/2577465
map gn :cn<cr>
map gp :cp<cr>
map <C-l> :bn<cr>
map <C-h> :bp<cr>
map gb :Buffers<cr>

map <C-p> :FZF<CR>

"https://github.com/smallhadroncollider/dotfiles/blob/e55adafeb472e90399a77e9b01dc0b9d19506393/vim/.vimrc#L228
" replace single quotes in selection
map <leader>" :s/'/"/g<CR>
map U :Gread -<CR>
map f <Plug>(easymotion-f)

"https://github.com/mitsuhiko/dotfiles/blob/master/vim/vimrc
"tab for brackets
nnoremap t %
vnoremap t %


vnoremap <Tab> >
vnoremap <S-tab> <gv

"http://vim.wikia.com/wiki/Easy_indenting_in_insert_and_normal_mode_with_no_cursor_displacement
"commented because C-i doesn work
nnoremap <Tab> >>
" opposite of <C-o>
nnoremap <C-y> <C-I>
nnoremap <S-Tab> <<

nnoremap <Leader>u :MundoToggle<CR>

"https://github.com/jackfranklin/dotfiles/blob/master/vim/vimrc#L224
" new file in current directory
map <Leader>ee :e <C-R>=expand("%:p:h") . "/" <CR>

nmap <silent> <Plug>ReplaceOccurences :call ReplaceOccurence()<CR>
nmap <silent> <Leader>r :let @/ = '\C\<'.expand('<cword>').'\>'<CR>
    \:set hlsearch<CR>:let g:should_inject_replace_occurences=1<CR>cgn
vmap <silent> <Leader>r :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy:let @/ = substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>:set hlsearch<CR>:let g:should_inject_replace_occurences=1<CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>cgn


" Use tab to trigger auto completion.  Default suggests completions as you type.
"let g:completor_auto_trigger = 1
inoremap <expr> <Tab> Tab_Or_Complete()
map <C-a> ggVG
" delete blank lines
map <leader>dbl :g/^$/d<CR>:noh<CR>
" remove trailing space
map <leader>rts :%s/\s\+$//e<CR>

" unused keys
" shift - K, M, Q
" <C-m
map K <Nop>
map M <Nop>
map Q <Nop>
map <C-m> <Nop>

"https://github.com/bag-man/dotfiles/blob/master/vimrc#L59
map H ^
map L $
nnoremap M :Maps<CR>
nnoremap <leader>gf :GFiles?<CR>
map <leader>w :w<CR>:w<CR>

nnoremap * *N
map F *

"set verbose=1

"https://vi.stackexchange.com/a/2770/15805
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>
