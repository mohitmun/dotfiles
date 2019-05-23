
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

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
map <leader>nt :NERDTreeFocus<cr>
map ; :
map <C-f> :Ag<CR>
map swe :Ag <C-R><C-W><CR>
map swc :BLines <C-R><C-W><CR>
map <leader>/ :BLines <CR>
map <leader>f :BLines <CR>
map <leader>ag :Rag<CR>
map <leader>usl :Snippets<CR>
map <leader>use :UltiSnipsEdit<CR>
map <leader>es :UltiSnipsEdit<CR>
map , \
map ,, <Leader><Leader>
map <leader>c :w !colordiff -u % -
map j gj
map k gk
map <leader>csr :!cscope -Rbq<CR>:cs reset<CR><CR>
map <leader>h :History<CR>
map <leader>jpp :%!jq '.'<CR>
map \ss :call SaveSess()<CR>
map \rs :call RestoreSess()<CR>
map <C-g> g;
map <leader>aspl :!aspell -c % <CR>
map <leader>espl :setlocal spell<CR>
map <leader>dspl :setlocal nospell<CR>
map <leader>sgc :%s/<C-R><C-W>//gc<Left><Left><Left>
map <leader>cp :let @+ = expand("%:p")<CR>
map <leader>df :call delete(expand("%"))<CR>:bdelete!<CR>

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
nnoremap <space> za
vnoremap <space> zf
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
imap <C-_> <Esc><leader>c<Space>li
imap <leader>i <Esc>
inoremap jj <ESC>
cmap jj <ESC>
vmap ii <ESC>
nmap ]h <Plug>GitGutterNextHunk
nmap gh <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nnoremap <leader>ggs :GitGutterStageHunk<CR>
nnoremap <leader>gch :GitGutterStageHunk<CR>:!git commit -m ""<Left>
nnoremap <leader>gcf :!git commit -m "" %<Left><Left><Left>
nnoremap gcf :!git commit -m "" %<Left><Left><Left>
nnoremap T :!tig %<CR>
nnoremap <leader>gd :!git diff %<CR>
nnoremap <leader>gdca :!git diff --cached %<CR>
nnoremap <leader>ggp :GitGutterPreviewHunk<CR>
nnoremap <leader>ggu :GitGutterUndoHunk<CR>
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gco :!git checkout %<CR>
nnoremap <leader>ga :!git add %<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
nnoremap <leader>za zR
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
noremap q :bd<CR>
noremap <leader>q q
vnoremap // y/\V<C-r>=escape(@",'/\')<CR>
cmap w!! w !sudo tee > /dev/null %
cmap <C-J> <Down>
cmap <C-K> <Up>
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
nnoremap <leader>d "*d
nnoremap <leader>D "*D
vnoremap <leader>d "*d
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-g>k"))
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-g>j"))

" make Y behave like D and C
nnoremap Y y$
vnoremap > >gv
vnoremap < <gv
nmap <M-n> o<Esc>
nmap <leader>id :IlluminationDisable<CR>
nmap <leader>ie :IlluminationEnable<CR>
nmap <leader>pc :pclose<CR>:cclose<CR>
nmap <leader><leader>c :pclose<CR>:cclose<CR>
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
inoremap <c-c> <c-g>u<Esc>[s1z=`]a<c-g>u
cnoremap %% <C-R>=expand('%:h').'/'<CR>
cnoremap %' <C-R>=expand('%:p')<CR>
nnoremap <Leader>r :call Replace(0, input('Replace '.expand('<cword>').' with: '))<CR>
