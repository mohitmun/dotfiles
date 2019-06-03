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
Plug 'vim-airline/vim-airline' " this is slow for bb"
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
"Plug 'itchyny/calendar.vim'
Plug 'airblade/vim-gitgutter' "slow for bb"
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
Plug 'mohitmun/spu.vim'
call plug#end()

" =================== Plugin Conf ===================
"============ UltiSnips ===================
let g:UltiSnipsSnippetsDir="~/.vim/plugged/vim-snippets/UltiSnips"
"let g:UltiSnipsListSnippets="<C-m>"
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

"https://castel.dev/post/lecture-notes-1/
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-z>'
"============ UltiSnips ===================


"=========== GitGutter ==========
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 3000
let g:gitgutter_diff_base = 'HEAD'
autocmd BufWritePost * GitGutter
"TODO git commit current line, range of lines
"commit current hunk
"commit current file
"=========== GitGutter ==========


"=================== airline ===================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
"=================== airline ===================


"=================== ALE ===================
let g:ale_fixers = {
\   'java': ['google_java_format'],
\}
"=================== ALE ===================

" =================== FZF ===================
let g:fzf_history_dir = '~/.vim/fzf-history'

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

"imap <c-x><c-k> <plug>(fzf-complete-word)
"imap <c-x><c-f> <plug>(fzf-complete-path)
"imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"imap <c-x><c-l> <plug>(fzf-complete-line)

let $FZF_DEFAULT_COMMAND = 'fd --type f'

function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1})
endfunction
" =================== FZF ===================
"
" =================== vim-auto-save ===================
"let g:auto_save_events = ["InsertLeave"]
let g:auto_save = 1
" =================== vim-auto-save ===================
"
" =================== gist ===================
"
let g:gist_get_multiplefile = 1
let g:gist_list_vsplit = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

colorscheme monokai

" =================== multi cursor ===================

" fucks up with <CR>
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"danro/rename.vim
command! -nargs=* -complete=customlist,SiblingFiles -bang Rename :call Rename("<args>", "<bang>")
cabbrev rename <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Rename" : "rename"<CR>

function! SiblingFiles(A, L, P)
	return map(split(globpath(expand("%:h") . "/", a:A . "*"), "\n"), 'fnamemodify(v:val, ":t")')
endfunction

