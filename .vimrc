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
"
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
"  https://twitter.com/dotvimrc
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
  "TODO check if fd and ag installed
endif

source ~/.vim/plugins.vim

"source ~/.vim/cscope.vim
source ~/.vim/wikia_tips.vim
"let g:deoplete#enable_at_startup = 1

syntax on



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







highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" https://superuser.com/a/189198/630985
" https://stackoverflow.com/a/360634/2577465

let g:gist_get_multiplefile = 1
let g:gist_list_vsplit = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

" autocmd VimEnter * NERDTree
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
"below command closes nerdtree if now files left
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"http://vim.wikia.com/wiki/Map_semicolon_to_colon
"noremap ;; ;

"https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa#comment11360335_9051932

"Not needed because of plugin
"map <silent> <Leader><Leader> :nohlsearch<cr>
"map <C-e> :noh<cr>

"http://vim.wikia.com/wiki/Avoid_the_escape_key

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/


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
" TODO below with range
colorscheme monokai
" monokai with complete dark
hi Normal ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#272822 gui=NONE
hi LineNr ctermfg=102 ctermbg=NONE cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
hi Search guibg=peru guifg=wheat

"=========== GitGutter ==========
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 3000
let g:gitgutter_diff_base = 'HEAD'
autocmd BufWritePost * GitGutter
"TODO git commit current line, range of lines
"commit current hunk
"commit current file
"=========== GitGutter ==========

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
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"============ UltiSnips ===================


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
":au BufAdd,BufNewFile * nested tab sball
" ctrl-j for scroll without moving cursor

"=================== airline ===================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
"=================== airline ===================

" close buffer when quitting
" understand below command
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

"=================== ALE ===================
let g:ale_fixers = {
\   'java': ['google_java_format'],
\}
"=================== ALE ===================

"map <leader>h :exe printf('match IncSearch /\V\</Users/mohit/.vimrcs\>/', escape(expand('1'), '/\'))<CR>
autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
let g:auto_save = 1

" BS because ctrl-R inserts ^M character
"vnoremap // y/\V<C-R>"<BS>
"http://vim.wikia.com/wiki/Search_for_visually_selected_text
"http://howivim.com/2016/salvatore-sanfilippo/
"vmap q <gv
"vmap <TAB> >gv
"https://github.com/bpierre/dotfiles/blob/master/vimrc
"nnoremap <C-n> i<CR><ESC>
"https://stackoverflow.com/a/597932/2577465
"https://stackoverflow.com/a/8397808/2577465

"https://stackoverflow.com/a/30423919/2577465



let $FZF_DEFAULT_COMMAND = 'fd --type f'


"https://stackoverflow.com/questions/2744010/update-cscope-db-from-vim

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


"https://stackoverflow.com/a/4740069/2577465
"http://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings

" make Y behave like D and C


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



" http://vim.wikia.com/wiki/Add_a_newline_after_given_patterns
" Insert a newline after each specified string (or before if use '!').
" If no arguments, use previous search.
command! -bang -nargs=* -range LineBreakAt <line1>,<line2>call LineBreakAt('<bang>', <f-args>)


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


"close preview and quickfix list

"imap <c-x><c-k> <plug>(fzf-complete-word)
"imap <c-x><c-f> <plug>(fzf-complete-path)
"imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"imap <c-x><c-l> <plug>(fzf-complete-line)



" remeber when i was debuging here doc and white space was fucking up
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1})
endfunction


command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

let g:comfortable_motion_no_default_key_mappings = 1
"https://stackoverflow.com/a/1722706/2577465
"map <C-f> g;


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
"https://github.com/chrisbra/vim_dotfiles/blob/816a24ed81dccec04c82770834ca6c503665e3cd/plugin/LargeFile.vim
"TODO how to replace timestamp with date in file
"TODO explore https://github.com/bag-man/dotfiles/blob/master/vimrc#L285
"TODO what is select mode
"TODO understand how omnicompletion works
"TODO time is not there in git blame plugin
"TODO https://til.hashrocket.com/posts/39f85bac84-open-images-in-vim-with-iterm-
"TODO cycle through gitgutter hunks map it to 'gh'
"TODO remove space in vim surround
"TODO read this http://vim.wikia.com/wiki/Get_the_name_of_the_current_file
"TODO explore lsp
"TODO https://github.com/neoclide/coc.nvim
"TODO check ultisnips ka multi logic
"TODO https://brigade.engineering/sharpen-your-vim-with-snippets-767b693886db
"TODO https://gist.github.com/MikeDacre/365d716258d13a833831
"TODO read this http://vim.wikia.com/wiki/Search_and_replace
"FOR JS
"TODO https://github.com/vimlab/neojs
"TODO http://www.panozzaj.com/blog/2015/08/28/must-have-vim-javascript-setup/
"TODO https://github.com/ericdouglas
"https://castel.dev/post/lecture-notes-1/



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
" copy current file full path to clipboard
" https://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim

"danro/rename.vim
command! -nargs=* -complete=customlist,SiblingFiles -bang Rename :call Rename("<args>", "<bang>")
cabbrev rename <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Rename" : "rename"<CR>

function! SiblingFiles(A, L, P)
	return map(split(globpath(expand("%:h") . "/", a:A . "*"), "\n"), 'fnamemodify(v:val, ":t")')
endfunction


"=============== abbr ================
inoreabbr bp binding.pry
inoreabbr bpr binding.pry_remote
inoreabbr rli Rails.logger.info
"=============== abbr ================

let g:should_inject_replace_occurences = 0


let g:undotree_WindowLayout = 4

command! -nargs=1 -bang Replace :call Replace(<bang>0, <q-args>)
let g:rainbow_active = 1

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction


"=================== quickfix ===================
"https://www.reddit.com/r/vim/comments/7dv9as/how_to_edit_the_vim_quickfix_list/?st=jrm42fdg&sh=96a8333f
"explore https://github.com/romainl/vim-qlist
"https://github.com/romainl/vim-qf

"https://github.com/mroth/dotfiles/blob/master/home/.vimrc.after#L27
" Weird meta vim shit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-source the vimrc file whenever it is saved
"if has("autocmd")
  "autocmd! bufwritepost .vimrc source $MYVIMRC
"endif

" TODO map f to easymotion

source ~/.vim/mappings.vim
source ~/.vim/setter.vim
source ~/.vim/autocmds.vim

command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a
command! -nargs=? FilterD let @a='' | execute 'g/<args>/d A' | new | setlocal bt=nofile | put! a
"let g:auto_save_events = ["InsertLeave"]
