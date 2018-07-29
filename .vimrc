" GistID: 963f95aaf61d50e512511ac4eb097e50
"Constantly improve at vim
"  http://vimgolf.com
"  http://derekwyatt.org/vim/tutorials/advanced/
"  https://statico.github.io/vim3.html
"  https://www.reddit.com/r/vim/comments/8gmmk3/how_to_continue_to_improve_at_vim/
"  https://stackoverflow.com/q/726894/2577465
"Why
"  http://www.viemu.com/a-why-vi-vim.html	
"Headstart	
"  https://github.com/mhinz/vim-galore	
"  https://github.com/bpierre/switch-to-vim-for-good
"  http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/	
"  http://www.worldtimzone.com/res/vi.html	
"  https://danielmiessler.com/study/vim/	
"  http://learnvimscriptthehardway.stevelosh.com/	
"  https://github.com/learnbyexample/scripting_course/blob/master/Vim_curated_resources.md
"Tips	
"  http://nvie.com/posts/how-i-boosted-my-vim/	
"Refactoring in vim
"  https://stackoverflow.com/a/8783131/2577465
"https://kev.town/2010/12/15/this-is-your-brain-on-vim/
"Terms	
"  https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/	
"  1. Using vim-plug (https://junegunn.kr/2013/09/writing-my-own-vim-plugin-manager/	
"  https://sanctum.geek.nz/arabesque/buffers-windows-tabs/ (Buffers/windows/tabs) 	
"Vim as IDE http://vim.wikia.com/wiki/Use_Vim_like_an_IDE
"Key Learnings	
"  Read the fucking manual, :help is powerful	
"  Make life easier by vimrc	
"vimrcs	
"  https://github.com/amix/vimrc	
"  https://github.com/nvie/vimrc/blob/master/vimrc	
"  https://github.com/garybernhardt/dotfiles/blob/master/.vimrc	
"  https://github.com/mhinz/dotfiles/blob/master/.vim/vimrc	
"  https://github.com/junegunn/dotfiles/blob/master/vimrc
"CheatSheets	
"  https://gist.github.com/0xadada/1ea7f96d108dcfbe75c9	
"  https://devhints.io/vim	
"  http://www.viemu.com/vi-vim-cheat-sheet.gif The ultimate vimrc https://github.com/amix/vimrc
" The ultimate vimrc https://github.com/amix/vimrc 
" wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim and
" move it to ~/.vim/autoload and run :PlugInstall
" mkdir -p ~/.vim/undodir
" mkdir -p ~/.vim/backupdir
" mkdir -p ~/.vim/directory

"https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'ctrlpvim/ctrlp.vim
"Plug 'Valloric/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors' " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'amix/vim-zenroom2'
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'w0rp/ale'
Plug 'mohitmun/gist-vim'
Plug 'mattn/webapi-vim' " dependancy for gist-vim
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'yuttie/comfortable-motion.vim'
Plug 'sjl/gundo.vim'
" https://vi.stackexchange.com/a/8224/15805
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'suan/vim-instant-markdown'
"fucks up disable cut logic
"Plug 'maxbrunsfeld/vim-yankstack'
"Plug 'majutsushi/tagbar'

" slow downs cursor moment on large files
Plug 'Yggdroot/indentLine'
Plug '907th/vim-auto-save'
Plug 'machakann/vim-highlightedyank'
Plug 'Raimondi/delimitMate'
Plug 'elzr/vim-json'


"Plug 'google/vim-searchindex' 
"removed this because its not compatible with is.vim
Plug 'osyo-manga/vim-anzu'
Plug 'simnalamburt/vim-mundo'
"Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'benmills/vimux'
Plug 'haya14busa/is.vim'
Plug 'crusoexia/vim-monokai'
"Plug 'sickill/vim-monokai'
Plug 'haya14busa/vim-asterisk'
Plug 'pangloss/vim-javascript'
Plug 'brooth/far.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
"Plug 'wellle/targets.vim'
" dependancy for vim-markdown
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'osyo-manga/vim-over'
Plug 'haya14busa/vim-edgemotion'
Plug 'dhruvasagar/vim-table-mode'
call plug#end()

source ~/.vim/cscope.vim

syntax on

set number
set tabstop=2 shiftwidth=2 expandtab
set updatetime=100

let g:gitgutter_diff_base = 'HEAD'
autocmd BufWritePost * GitGutterAll

"Always show current position
set ruler

" Highlight search results
set hlsearch
set ignorecase
" Show matching brackets when text indicator is over them
set showmatch 

"" Makes search act like search in modern browser
set incsearch
set hidden


set backspace=indent,eol,start
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" If a file is changed outside of vim, automatically reload it without asking	
set autoread	
" Don't make backups at all	
set nobackup	
set nowritebackup
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" copied previous line word by word https://web.archive.org/web/20160429070600/http://vim.wikia.com/wiki/Duplicate_previous_line_word_by_word# 
"nmap ,c @<Esc>kyWjP<BS>

" Mappings for moving lines up and down in all modes.

execute "set <M-j>=\ej"
execute "set <M-k>=\ek"

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==

inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi

vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

set mouse=a

" https://stackoverflow.com/a/5562707/2577465
map gn :bn<cr>
map gp :bp<cr>
map gb :Buffers<cr>

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" https://superuser.com/a/189198/630985
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
set foldmethod=indent
"set cursorline
" https://stackoverflow.com/a/360634/2577465
nnoremap <space> za
vnoremap <space> zf

let g:gist_get_multiplefile = 1
let g:gist_list_vsplit = 1

set nofoldenable    " disable folding

set foldlevelstart=20
map <C-p> :FZF<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
map <leader>nt :NERDTreeFocus<cr>

" autocmd VimEnter * NERDTree
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
"below command closes nerdtree if now files left
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"http://vim.wikia.com/wiki/Map_semicolon_to_colon
map ; :
noremap ;; ;

"https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa#comment11360335_9051932
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
imap <C-_> <Esc><leader>c<Space>li

"Not needed because of plugin
"map <silent> <Leader><Leader> :nohlsearch<cr>
"map <C-e> :noh<cr>

"http://vim.wikia.com/wiki/Avoid_the_escape_key
imap <leader>i <Esc>

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set undofile
inoremap jj <ESC>
cmap jj <ESC>
vmap ii <ESC>

"https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=~/.vim/backupdir//
set directory=~/.vim/directory//
set undodir=~/.vim/undodir// 

set clipboard^=unnamed

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \  {'options': '--delimiter : --nth 2..'}, 
  \   <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
map <leader>f :Ag<CR>
colorscheme monokai
" monokai with complete dark
hi Normal ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#272822 gui=NONE
hi LineNr ctermfg=102 ctermbg=NONE cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
hi Search guibg=peru guifg=wheat

nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
set completeopt-=preview
nnoremap <leader>ggs :GitGutterStageHunk<CR>
nnoremap <leader>ggp :GitGutterPreviewHunk<CR>
nnoremap <leader>ggu :GitGutterUndoHunk<CR>
nnoremap <leader>gst :Gstatus<CR>

"https://shapeshed.com/vim-netrw/
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
  "autocmd!
  "autocmd VimEnter * :Vexplore
"augroup END
set history=1000                      " Keep a bigger history of commands

" Fast editing and sourcing of `.vimrc`
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
":au BufAdd,BufNewFile * nested tab sball
nnoremap <leader>za zR
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
"set iskeyword-=_
set ttimeoutlen=50
"set timeoutlen=500
let g:airline#extensions#tabline#enabled = 1
" close buffer when quitting
map <leader>q :bd<CR>
" understand below command
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
let g:ale_fixers = {
\   'java': ['google_java_format'],
\}
map <leader>c :w !colordiff -u % - 
"map <leader>h :exe printf('match IncSearch /\V\</Users/mohit/.vimrcs\>/', escape(expand('1'), '/\'))<CR>
autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
let g:auto_save = 1

" BS because ctrl-R inserts ^M character
"vnoremap // y/\V<C-R>"<BS>
"http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR>
"http://howivim.com/2016/salvatore-sanfilippo/
vmap q <gv	
vmap <TAB> >gv 
"https://github.com/bpierre/dotfiles/blob/master/vimrc
"nnoremap <C-n> i<CR><ESC>
cmap w!! w !sudo tee > /dev/null %

"https://stackoverflow.com/a/597932/2577465
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
"https://stackoverflow.com/a/8397808/2577465
map , \

"https://stackoverflow.com/a/30423919/2577465
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap c "_c
nnoremap C "_C
vnoremap c "_c

set clipboard^=unnamed
nnoremap <leader>d "*d
nnoremap <leader>D "*D
vnoremap <leader>d "*d

let $FZF_DEFAULT_COMMAND = 'fd --type f'

map j gj
map k gk
map <leader>ms :MundoShow<CR>
map <leader>mh :MundoHide<CR>

"https://stackoverflow.com/questions/2744010/update-cscope-db-from-vim
map <leader>csr :!cscope -Rbq<CR>:cs reset<CR><CR>

"set hlsearch
"let g:incsearch#auto_nohlsearch = 1
""map / <Plug>(incsearch-nohl)
"map n  <Plug>(incsearch-nohl-n)
"map N  <Plug>(incsearch-nohl-N)
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)
"augroup vimrc-incsearch-highlight
  "autocmd!
  "autocmd CmdlineEnter [/\?] :set hlsearch
  "autocmd CmdlineLeave [/\?] :set nohlsearch
"augroup END
"map *   <Plug>(asterisk-*)
"map #   <Plug>(asterisk-#)
"map g*  <Plug>(asterisk-g*)
"map g#  <Plug>(asterisk-g#)
"map z*  <Plug>(asterisk-z*)
"map gz* <Plug>(asterisk-gz*)
"map z#  <Plug>(asterisk-z#)
"map gz# <Plug>(asterisk-gz#)
"let g:asterisk#keeppos = 1
"mmm *  <Plug>(asterisk-z*)
"map #  <Plug>(asterisk-z#)
"map g* <Plug>(asterisk-gz*)
"map g# <Plug>(asterisk-gz#)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul
autocmd FileType help wincmd L
map ,, <Leader><Leader>
" tmux knows the extended mouse mode
set ttymouse=xterm2

let g:gitgutter_map_keys = 0
map <leader>h :History<CR>

"https://stackoverflow.com/a/4740069/2577465
"http://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-g>k"))
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-g>j"))

let g:airline#extensions#branch#enabled = 0

"https://github.com/mrzool/dotfiles/blob/master/vim/.vimrc#L112
set dictionary=/usr/share/dict/words
" make Y behave like D and C
nnoremap Y y$

map <leader>jpp :%!jq '.'<CR>
set noeol
vnoremap > >gv
vnoremap < <gv

let g:fzf_history_dir = '~/.vim/fzf-history'

"https://github.com/ervandew/supertab/issues/53#issuecomment-9980930
let g:SuperTabCrMapping = 0
let g:SuperTabDefaultCompletionType = 'context'
autocmd FileType *
      \ if &omnifunc != '' |
      \     call SuperTabChain(&omnifunc, '<c-p>') |
      \ endif

"https://stackoverflow.com/a/10525050/2577465
fu! SaveSess()
  execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
  if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    "if bufexists(1)
      "for l in range(1, bufnr('$'))
        "if bufwinnr(l) == -1
          "exec 'sbuffer ' . l
        "endif
      "endfor
    "endif
  endif
endfunction

"autocmd VimLeave * call SaveSess()
"autocmd VimEnter * nested call RestoreSess()

set sessionoptions-=options

map \ss :call SaveSess()<CR>
map \rs :call RestoreSess()<CR>

" http://vim.wikia.com/wiki/Add_a_newline_after_given_patterns
" Insert a newline after each specified string (or before if use '!').
" If no arguments, use previous search.
command! -bang -nargs=* -range LineBreakAt <line1>,<line2>call LineBreakAt('<bang>', <f-args>)
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