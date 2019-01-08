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
"  http://nvie.com/posts/how-i-boosted-my-vim
"Refactoring in vim
"  https://stackoverflow.com/a/8783131/2577465
"https://kev.town/2010/12/15/this-is-your-brain-on-vim/
"Term
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
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  silent !mkdir -p ~/.vim/undodir
  silent !mkdir -p ~/.vim/backupdir
  silent !mkdir -p ~/.vim/directory
endif

call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'ctrlpvim/ctrlp.vim
"Plug 'Valloric/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors' " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"Plug 'amix/vim-zenroom2'
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
Plug 'sidorares/node-vim-debugger'
"Plug 'w0rp/ale'
Plug 'mohitmun/gist-vim'
Plug 'mattn/webapi-vim' " dependancy for gist-vim
Plug 'vim-airline/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'yuttie/comfortable-motion.vim'
Plug 'sjl/gundo.vim'
" https://vi.stackexchange.com/a/8224/15805
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'suan/vim-instant-markdown'
"fucks up disable cut logic
"Plug 'maxbrunsfeld/vim-yankstack'
"Plug 'majutsushi/tagbar'
Plug 'itchyny/calendar.vim'
Plug 'airblade/vim-gitgutter'
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
"Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
"Plug 'svermeulen/vim-easyclip'
"Plug 'wellle/targets.vim'
" dependancy for vim-markdown
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'osyo-manga/vim-over'
Plug 'haya14busa/vim-edgemotion'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mbbill/undotree'
Plug 'RRethy/vim-illuminate', { 'on':  'IlluminationEnable' }
" TODO limit this for 3-4 chars
"Plug 'vim-scripts/AutoComplPop'
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'roxma/vim-hug-neovim-rpc'
Plug 'maralla/completor.vim'
Plug 'ruanyl/vim-gh-line'
Plug 'zivyangll/git-blame.vim'
" discovered here https://github.com/dodie/dotfiles/blob/master/vim/vimrc.symlink#L32
Plug 'luochen1990/rainbow'
"Plug 'SidOfc/mkdx'
"explore
"Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()

"source ~/.vim/cscope.vim
source ~/.vim/wikia_tips.vim

let g:deoplete#enable_at_startup = 1

syntax on
set number
set tabstop=2 shiftwidth=2 expandtab
set updatetime=100
set showcmd
set completeopt-=preview
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
"https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=~/.vim/backupdir//
set directory=~/.vim/directory//
set undodir=~/.vim/undodir//
set clipboard^=unnamed
set undofile
"set iskeyword-=_
set ttimeoutlen=50
set history=1000  " Keep a bigger history of commands
set mouse=a
set foldmethod=indent
"set cursorline
set nofoldenable    " disable folding
set foldlevelstart=20
"set timeoutlen=500
set clipboard^=unnamed

"https://github.com/sputtene/dotfiles/blob/79db8ab3b0586fb787fc59b42715dba786135c6d/.vimrc
set viminfo+='1000
"
set viminfo=
set viminfo+='1000  " max number of previous files for which the marks are remembered
set viminfo+=!      " save and restore globals in all uppercase
"set viminfo+=%      " save and restore buffer list
set viminfo+=/1000  " max number of search and substitute patterns to save
set viminfo+=:1000  " max number of command line items to save
set viminfo+=<1000   " max number of lines for each register to save
set viminfo+=@1000   " max number of input-line history to save
set viminfo+=f1     " store file marks ('0 to '9, 'A to 'Z)
set viminfo+=h      " disable effect of hlsearch when loading viminfo
set viminfo+=s10    " max size of an item in Kb

"https://stackoverflow.com/a/16920294/2577465
set re=1



" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

"map <Left> <C-W>h
"map <Right> <C-W>l
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



" https://stackoverflow.com/a/5562707/2577465
map gn :bn<cr>
map gp :bp<cr>
map <C-l> :bn<cr>
map <C-h> :bp<cr>
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
" https://stackoverflow.com/a/360634/2577465
nnoremap <space> za
vnoremap <space> zf

let g:gist_get_multiplefile = 1
let g:gist_list_vsplit = 1

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
"noremap ;; ;

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
inoremap jj <ESC>
cmap jj <ESC>
vmap ii <ESC>


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \  {'options': '--delimiter : --nth 2..'},
  \   <bang>0)

function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  echo ag_opts
  echo query
  call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%','options': '--delimiter : --nth 4..' })
endfunction

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rag call fzf#vim#ag(<q-args>, {'options': '--delimiter : '}, <bang>0)
command! -nargs=* -bang CAg call s:ag_with_opts(<q-args>, <bang>0)
command! -bang -nargs=+ -complete=dir RRag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
map <C-f> :Ag<CR>
map swe :Ag <C-R><C-W><CR>
map swc :BLines <C-R><C-W><CR>
map <leader>/ :BLines <CR>
map <leader>f :BLines <CR>
map <leader>ag :Rag<CR>
colorscheme monokai
" monokai with complete dark
hi Normal ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#272822 gui=NONE
hi LineNr ctermfg=102 ctermbg=NONE cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
hi Search guibg=peru guifg=wheat

"=========== GitGutter ==========
let g:gitgutter_map_keys = 0
let g:gitgutter_diff_base = 'HEAD'
autocmd BufWritePost * GitGutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nnoremap <leader>ggs :GitGutterStageHunk<CR>
nnoremap <leader>ggstage :GitGutterStageHunk<CR>
nnoremap <leader>ggsc :GitGutterStageHunk<CR>:!git commit -m "working" %<CR>
nnoremap <leader>ggc :!git add %<CR>:!git commit -m "working" %<CR>
nnoremap <leader>gd :!git diff %<CR>
nnoremap <leader>gdca :!git diff --cached %<CR>
nnoremap <leader>ggp :GitGutterPreviewHunk<CR>
nnoremap <leader>ggu :GitGutterUndoHunk<CR>
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gco :!git checkout %<CR>
"=========== GitGutter ==========

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

" Fast editing and sourcing of `.vimrc`
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
":au BufAdd,BufNewFile * nested tab sball
nnoremap <leader>za zR
" ctrl-j for scroll without moving cursor
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>


let g:airline#extensions#tabline#enabled = 1
" close buffer when quitting
noremap q :bd<CR>
noremap <leader>q q
" understand below command
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
let g:ale_fixers = {
\   'java': ['google_java_format'],
\}
"map <leader>h :exe printf('match IncSearch /\V\</Users/mohit/.vimrcs\>/', escape(expand('1'), '/\'))<CR>
autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
let g:auto_save = 1

" BS because ctrl-R inserts ^M character
"vnoremap // y/\V<C-R>"<BS>
"http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR>
"http://howivim.com/2016/salvatore-sanfilippo/
"vmap q <gv
"vmap <TAB> >gv
"https://github.com/bpierre/dotfiles/blob/master/vimrc
"nnoremap <C-n> i<CR><ESC>
cmap w!! w !sudo tee > /dev/null %
cmap <C-J> <Down>
cmap <C-K> <Up>
"https://stackoverflow.com/a/597932/2577465
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
"https://stackoverflow.com/a/8397808/2577465
map , \
map ,, <Leader><Leader>

"https://stackoverflow.com/a/30423919/2577465
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap c "_c
nnoremap C "_C
vnoremap c "_c

map <leader>c :w !colordiff -u % -
nnoremap <leader>d "*d
nnoremap <leader>D "*D
vnoremap <leader>d "*d

let $FZF_DEFAULT_COMMAND = 'fd --type f'

map j gj
map k gk

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
" tmux knows the extended mouse mode
set ttymouse=xterm2

map <leader>h :History<CR>

"https://stackoverflow.com/a/4740069/2577465
"http://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-g>k"))
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-g>j"))

let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
"https://github.com/mrzool/dotfiles/blob/master/vim/.vimrc#L112
set dictionary=/usr/share/dict/words
" make Y behave like D and C
nnoremap Y y$

map <leader>jpp :%!jq '.'<CR>
vnoremap > >gv
vnoremap < <gv

let g:fzf_history_dir = '~/.vim/fzf-history'

"https://github.com/ervandew/supertab/issues/53#issuecomment-9980930
"let g:SuperTabCrMapping = 0
"let g:SuperTabDefaultCompletionType = 'context'
"autocmd FileType *
      "\ if &omnifunc != '' |
      "\     call SuperTabChain(&omnifunc, '<c-p>') |
      "\ endif

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

"https://github.com/mitsuhiko/dotfiles/blob/master/vim/vimrc
"tab for brackets
nnoremap t %
vnoremap t %

"https://github.com/search?q=filename%3A.vimrc+matchpairs&type=Code
" <3 github <3 your search is awesome
set matchpairs+=<:>
"set matchpairs+=':'
"set matchpairs+=":"

vnoremap <tab> >gv
vnoremap <S-tab> <gv

"http://vim.wikia.com/wiki/Easy_indenting_in_insert_and_normal_mode_with_no_cursor_displacement
nnoremap <Tab> >>
nnoremap <S-Tab> <<

" fucks up with <CR>
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
" <S-CR> doesn't work in cli vim :(
execute "set <M-n>=\en"
nmap <M-n> o<Esc>

nmap <leader>id :IlluminationDisable<CR>
nmap <leader>ie :IlluminationEnable<CR>

"close preview and quickfix list
nmap <leader>pc :pclose<CR>:cclose<CR>
nmap <leader><leader>c :pclose<CR>:cclose<CR>

"imap <c-x><c-k> <plug>(fzf-complete-word)
"imap <c-x><c-f> <plug>(fzf-complete-path)
"imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <Leader>u :UndotreeToggle<CR>

"let g:UltiSnipsListSnippets="<C-m>"
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" remeber when i was debuging here doc and white space was fucking up
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1})
endfunction


command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
let g:comfortable_motion_no_default_key_mappings = 1
"https://stackoverflow.com/a/1722706/2577465
"map <C-f> g;
map <C-g> g;


function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.



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

nnoremap * *N
map F *

"Vimnotes
"http://vim.wikia.com/wiki/Delete_all_lines_containing_a_pattern
" :g!/http/d deletes lines not containing http
"pain points
" vim multiple cursor is slow
" autocomplete when using vim
" writing markdown faster
" https://stackoverflow.com/a/6937075/2577465
" run command on selected text
" :'<,'>!ls `cat`
" TODO explore
"https://stackoverflow.com/questions/2575545/vim-pipe-selected-text-to-shell-cmd-and-receive-output-on-vim-info-command-line
"https://stackoverflow.com/questions/6762531/execute-command-for-several-lines-in-vim
"TODO how to replace timestamp with date in file
"TODO explore https://github.com/bag-man/dotfiles/blob/master/vimrc#L285
"TODO what is select mode
"TODO understand how omnicompletion works
"TODO time is not there in git blame plugin
"TODO https://til.hashrocket.com/posts/39f85bac84-open-images-in-vim-with-iterm-
"TODO cycle through gitgutter hunks
"TODO remove space in vim surround
"TODO read this http://vim.wikia.com/wiki/Get_the_name_of_the_current_file
"TODO explore lsp
"TODO https://github.com/neoclide/coc.nvim
"TODO check ultisnips ka multi logic
map <leader>aspl :!aspell -c % <CR>
map <leader>espl :setlocal spell<CR>
map <leader>dspl :setlocal nospell<CR>

autocmd FileType ruby map <C-b> :!ruby %<CR>


map <leader>sgc :%s/<C-R><C-W>//gc<Left><Left><Left>

" destroy-all-software 0060 - the vimrc
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" das 0013 file navigation
cnoremap %% <C-R>=expand('%:h').'/'<CR>
cnoremap %' <C-R>=expand('%:p')<CR>
" copy current file full path to clipboard
" https://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
map <leader>cp :let @+ = expand("%:p")<CR>

"danro/rename.vim
command! -nargs=* -complete=customlist,SiblingFiles -bang Rename :call Rename("<args>", "<bang>")
cabbrev rename <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Rename" : "rename"<CR>

function! SiblingFiles(A, L, P)
	return map(split(globpath(expand("%:h") . "/", a:A . "*"), "\n"), 'fnamemodify(v:val, ":t")')
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

"=============== abbr ================
inoreabbr bp binding.pry
inoreabbr bpr binding.pry_remote
inoreabbr rli Rails.logger.info
"=============== abbr ================

"https://gist.github.com/orlp/8c25ed4abb36372bc6fe
" quick replace occurences
let g:should_inject_replace_occurences = 0
function! MoveToNext()
    if g:should_inject_replace_occurences
        call feedkeys("n")
        call repeat#set("\<Plug>ReplaceOccurences")
    endif

    let g:should_inject_replace_occurences = 0
endfunction

augroup auto_move_to_next
    autocmd! InsertLeave * :call MoveToNext()
augroup END

nmap <silent> <Plug>ReplaceOccurences :call ReplaceOccurence()<CR>
nmap <silent> <Leader>r :let @/ = '\C\<'.expand('<cword>').'\>'<CR>
    \:set hlsearch<CR>:let g:should_inject_replace_occurences=1<CR>cgn
vmap <silent> <Leader>r :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy:let @/ = substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>:set hlsearch<CR>:let g:should_inject_replace_occurences=1<CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>cgn

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
let g:undotree_WindowLayout = 4


let g:UltiSnipsSnippetsDir="~/.vim/plugged/vim-snippets/snippets/"
map <leader>usl :Snippets<CR>
map <leader>use :UltiSnipsEdit<CR>

if &diff
    " diff mode
    set diffopt+=iwhite
endif

"https://github.com/jackfranklin/dotfiles/blob/master/vim/vimrc#L224
" new file in current directory
map <Leader>nf :e <C-R>=expand("%:p:h") . "/" <CR>
