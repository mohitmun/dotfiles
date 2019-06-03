set list
set listchars=tab:>-

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
set backup
"set nowritebackup
"https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=~/.vim/backupdir//
set directory=~/.vim/directory//
set undodir=~/.vim/undodir//
set clipboard^=unnamed
"set iskeyword-=_
set iskeyword+=-
set ttimeoutlen=50
set history=1000  " Keep a bigger history of commands
set mouse=a
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
set noeol

" tmux knows the extended mouse mode
set ttymouse=xterm2

"https://github.com/mrzool/dotfiles/blob/master/vim/.vimrc#L112
set dictionary=/usr/share/dict/words

set sessionoptions-=options

"https://github.com/search?q=filename%3A.vimrc+matchpairs&type=Code
" <3 github <3 your search is awesome
set matchpairs+=<:>
"set matchpairs+=':'
"set matchpairs+=":"

if &diff
    " diff mode
    set diffopt+=iwhite
endif
set encoding=utf-8
"https://github.com/superjer/vimrc/blob/50660c3a2c50d2dacce64ea5f703a7ddd0237afd/.vimrc#L22
set gdefault            " When substituting, the g flag is on by default

" slow 
set undofile " is slow for bb"
"set foldmethod=indent " is slow for bb/"
"set cursorline
