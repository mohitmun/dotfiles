call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'ctrlpvim/ctrlp.vim
"Plug 'Valloric/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors' " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"Plug 'amix/vim-zenroom2'
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
Plug 'sidorares/node-vim-debugger'
" Linters
"Plug 'w0rp/ale'
Plug 'z0mbix/vim-shfmt'
", { 'for': 'sh' }
Plug 'tweekmonster/startuptime.vim'
Plug 'mohitmun/gist-vim'
Plug 'mattn/webapi-vim' " dependancy for gist-vim
Plug 'vim-airline/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'yuttie/comfortable-motion.vim'
"Plug 'sjl/gundo.vim'
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
Plug 'tpope/vim-projectionist'
Plug 'dkarter/bullets.vim'
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
Plug 'michaeljsmith/vim-indent-object'
Plug 'reedes/vim-pencil'
"Plug 'svermeulen/vim-easyclip'
"Plug 'wellle/targets.vim'
" dependancy for vim-markdown
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'osyo-manga/vim-over'
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
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
Plug 'TaDaa/vimade'
Plug 'itchyny/vim-qfedit'
"Plug 'timakro/vim-searchant'
Plug 'markonm/traces.vim'
Plug 'rhysd/git-messenger.vim'
"Plug 'mohitmun/spu.vim'
call plug#end()
