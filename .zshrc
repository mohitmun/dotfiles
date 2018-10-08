# GistID:963f95aaf61d50e512511ac4eb097e50
# vim: set ft=zsh:
export ZSH=~/omz
start=$(gdate +%s%N)
plugins=(
  git
  transfer
  copyfile
  copydir
  encode64
  z
  battery
)
REFRESH_RATE=10
OSASCRIPT_REFRESH_RATE=1
ALIASFILE=~/scripts/aliases.zsh
source $ZSH/oh-my-zsh.sh
[[ -f ~/.secret_common_sh_rc ]] && source ~/.secret_common_sh_rc
source $ALIASFILE
source ~/scripts/colored_man_pages.zsh
source ~/zsh/functions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#autoload -Uz myspotify && myspotify
#. ~/.zsh-async.zsh
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export EDITOR=vim

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=500000               #How many lines of history to keep in memory
SAVEHIST=500000             #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
#
# ====================
# Get new tip from the art of command line repo everyday. can be use for different stuff also
#TAOCL_FILE=~/.taocl.md
#if [ ! -f $TAOCL_FILE ]; then 
  #echo "Getting TAOCL from github"
  #\curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md -o $TAOCL_FILE 
#fi
#sed '/cowsay[.]png/d' $TAOCL_FILE | pandoc -f markdown -t html | xmlstarlet fo --html --dropdtd | xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" | xmlstarlet unesc | fmt -80 | iconv -t US | cowsay
export HOMEBREW_NO_AUTO_UPDATE=1
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
# ==============================================
# ==============================================
# git@github.com:rupa/z.git
# Using inbuilt zsh 'z' plugin
#. ~/.cli-tools/z/z.sh

# Dotfiles to follow
# https://github.com/whiteinge/dotfiles/
#https://github.com/nicolargo/glances
# All about awesome-cli
# https://github.com/whiteinge/ok.sh Github client in bash
## https://github.com/agarrharr/awesome-cli-apps
# explore more on https://github.com/alebcay/awesome-shell 	
#https://github.com/kahun/awesome-sysadmin
#https://github.com/k4m4/terminals-are-sexy
# https://github.com/jondot/awesome-devenv
# A command-line todo list manager for people that want to finish tasks, not organize them
# https://github.com/sjl/t
#
#https://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692

# Learning Command line
#   * https://github.com/learnbyexample/Command-line-text-processing
#   * https://github.com/jlevy/the-art-of-command-line
#   * https://www.tldp.org/LDP/abs/html/contributed-scripts.html
#   * https://www.tldp.org/LDP/abs/html/abs-guide.html
#   * http://zsh.sourceforge.net/Guide/zshguide.html
#   * https://github.com/dylanaraps/pure-bash-bible
#https://pthree.org/?s=zsh+prompt
#https://github.com/wilywampa/vimconfig/blob/b95caa50883438288729b6e8ff963783b110a3a5/dotfiles/.zshrc
#https://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/
# Better searching in command mode
# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search
bindkey "^b" backward-word

#TODO what is difference when using function keyword or not

function repeat_string(){
  #printf "-%.0s" $COLUMNS
  chus=$(( $1 - 4))
  printf "$2%.0s" $(seq 1 $chus)
}

get_todo_status(){
  #a=$(FORCE_COLOR=0 tb -l notes | tail -n2)
  #echo $a
}
explain(){
  response=$(w3m -dump "http://explainshell.com/explain?cmd="$(echo $@ | tr ' ' '+'))
  \cat -s <(grep -v -e explainshell -e • -e □ -e "source manpages" <<< "$response")
}

push(){
  adb -d push $1 /storage/emulated/0/
}

pull(){
  adb -d pull /storage/emulated/0/$1
}

notify(){
  osascript -e "display notification \"$2\" with title \"$1\""
}

ipaddress(){
  curl ipinfo.io/ip 
}

sockproxytest(){
  \curl ipinfo.io/ip --socks5-hostname $1 
}

httpproxytest(){
  \curl ipinfo.io/ip -x $1
}

capture() {
    sudo dtrace -p "$1" -qn '
        syscall::write*:entry
        /pid == $target && arg0 == 1/ {
            printf("%s", copyinstr(arg1, arg2));
        }
    '
}

#===========================
# THEME START
#===========================
# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# motivation: I forget if vim is running in bg https://news.ycombinator.com/item?id=17423100
# copied https://github.com/denysdovhan/spaceship-prompt/blob/40f52260840bff5ab24f014c62241fdb9be293c0/sections/jobs.zsh

# color vars

# right prompt
# Inspiration for todo in right prompt https://wynnnetherland.com/journal/contextual-todo-list-counts-in-your-zsh-prompt/
#TODO figure async prompt to speed things up
#https://medium.com/@henrebotha/how-to-write-an-asynchronous-zsh-prompt-b53e81720d32
#TODO https://stackoverflow.com/a/6052267/2577465 use this cool technique
#TODO https://github.com/junegunn/fzf/wiki/Examples#google-chrome-os-xlinux


#===========================
# THEME END
#===========================

gencscopedb(){
  CSCOPE_DIR="$PWD/cscope"
  if [ ! -d "$CSCOPE_DIR" ]; then
  mkdir "$CSCOPE_DIR"
  fi
  echo "Finding files ..."
  find "$PWD" -name '*.[ch]' \
  -o -name '*.java' \
  -o -name '*properties' \
  -o -name '*.cpp' \
  -o -name '*.cc' \
  -o -name '*.hpp' \
  -o -name '*.py' \
  -o -name '*.rb' \
  -o -name '*.php' > "$CSCOPE_DIR/cscope.files"
  echo "Adding files to cscope db: $PWD/cscope.db ..."
  cscope -b -i "$CSCOPE_DIR/cscope.files" -f "$CSCOPE_DIR/cscope.out"

  export CSCOPE_DB="$CSCOPE_DIR/cscope.out"
  echo "Exported CSCOPE_DB to: '$CSCOPE_DB'"
}

# mkdir, and cd
function mcd() {
    mkdir -p "$1" && cd "$1";
}
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

cht(){
  curl cht.sh/$1
}

#https://github.com/paulmillr/dotfiles/blob/master/home/.zshrc.sh
#
# Load 8 cores at once.
function maxcpu() {
  dn=/dev/null
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
}

# $ retry ping google.com
function retry() {
  echo Retrying "$@"
  $@
  sleep 1
  retry $@
}

# $ git log --no-merges --pretty=format:"%ae" | stats
# # => 514 a@example.com
# # => 200 b@example.com
function stats() {
  sort | uniq -c | sort -r
}

# Shortcut for searching commands history.
# hist git
function hist() {
  history | grep $@
}

# Monitor IO in real-time (open files etc).
function openfiles() {
  sudo dtrace -n 'syscall::open*:entry { printf("%s %s",execname,copyinstr(arg0)); }'
}

# Execute commands for each file in current directory.
function each() {
  for dir in *; do
    # echo "${dir}:"
    cd $dir
    $@
    cd ..
  done
}

# Show current Finder directory.
#function finder {
  #osascript 2>/dev/null <<EOF
    #tell application "Finder"
      #return POSIX path of (target of window 1 as alias)
    #end tell
#EOF

#TODO https://gist.github.com/phette23/5270658
#TODO https://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh/292660#292660

zrc(){
	vim ~/.zshrc
	source ~/.zshrc
	echo "Done: update zsh configure file."
}
#TODO https://github.com/zsh-users/zsh-autosuggestions
#TODO https://github.com/zsh-users/zsh-completions
#TODO https://github.com/ericfreese/zsh-prioritize-cwd-history
#TODO https://github.com/ericfreese/rat
#TODO https://github.com/ericfreese/zsh-cwd-history
#TODO https://github.com/larkery/zsh-histdb
#TODO what is precmd


#TODO check zsh folder here at https://github.com/cehoffman/dotfiles
# TODO what is zstyle ':completion:*'
#TODO spotify show shuffle status
#TODO https://news.ycombinator.com/item?id=17755199
#TODO htoprc
# why this code breaks
# https://www.zsh.org/mla/users/2011/msg00052.html
#testmybug(){
    #printf "-%.0s" $(seq 1 $COLUMNS)
#}
#PROMPT="$(testmybug)
#53hello >>>"

#Most edited files in project(https://news.ycombinator.com/item?id=16300152)
mosteditedfiles(){
  git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10
}
#TODO cli assistant

#start_interactive(){
  #BUFFER="grep  ~/.zshrc"
  #zle forward-char
  #zle forward-char
  #zle forward-char
  #zle forward-char
  #zle forward-char
#}
#zle -N start_interactive
#bindkey "^G" start_interactive
battery_hogging_apps=("Google Chrome" "Github Desktop")
containsElement () {
  local e match="$1"
  shift
  for e; do echo $e ;[[ "$e" == "$match" ]] && return 0; done
  return 1
}
stop_hogging_processes(){
  # TODO add timeout, stop only if chrome idle for more than X seconds
  export_osascript_system_status
  if [ "$frontApp" != "Google Chrome" ] && [ -z $chrome_stopped ];then
    mylog "mbga stopping chrome"
    stop "Google Chrome"
    export chrome_stopped=true
    unset chrome_continued
  fi

  if [ "$frontApp" = "Google Chrome" ] && [ -z $chrome_continued ];then
    mylog "mbga continue chrome"
    cont "Google Chrome"
    export chrome_continued=true
    unset chrome_stopped
  fi

  if [ "$frontApp" != "Finder" ] && [ -z $finder_stopped ];then
    mylog "mbga stopping finder"
    stop Finder
    export finder_stopped=true
    unset finder_continued
  fi

  if [ "$frontApp" = "Finder" ] && [ -z $finder_continued ];then
    mylog "mbga continue finder"
    cont Finder
    export finder_continued=true
    unset finder_stopped
  fi

  if [ "$frontApp" != "iTerm2" ] && [ -z $iTerm2_stopped ];then
    mylog "mbga stopping iTerm2"
    stop iTerm2
    #kill -STOP $(pgrep iTerm2)
    #pgrep iTerm2 | xargs kill -STOP
    export iTerm2_stopped=true
    unset iTerm2_continued
  fi

  if [ "$frontApp" = "iTerm2" ] && [ -z $iTerm2_continued ];then
    mylog "mbga continue iTerm2"
    cont iTerm2
    #kill -CONT $(pgrep iTerm2)
    #pgrep iTerm2 | xargs kill -CONT
    export iTerm2_continued=true
    unset iTerm2_stopped
  fi

  #if [ "$frontApp" != "Spotify" ] && [ -z $Spotify_stopped ];then
    ## dont stop if i'm listening
    ## how can I determine if song is playing?
    ## using apple script
    ## but applescript wont run if spotify is stopped
    ##
    #mylog "mbga stopping Spotify"
    #stop Spotify
    #export Spotify_stopped=true
    #unset Spotify_continued
  #fi

  #if [ "$frontApp" = "Spotify" ] && [ -z $spotify_continued ];then
    #mylog "mbga continue spotify"
    #cont Spotify
    #export spotify_continued=true
    #unset spotify_stopped
  #fi
# generic ijmplementation
#stop_hogging_processes(){
  #export_osascript_system_status
  #for app in ${battery_hogging_apps[@]}; do
    #if [ "$frontApp" != $app ] ;then
      #notify "Stopping $app"
      #stop $app
      ##export stopped_$app=true
      ##unset continued_$app
    #fi

    #if [ "$frontApp" = $app ] ;then
      #notify "Continue $app"
      #cont $app
      ##export continued_$app=true
      ##unset stopped_$app
    #fi
  #done
#}
}

mylog(){
  echo "$(datetime) $1" >> ~/mohit.log
}
source ~/scripts/prompt.zsh

zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

source ~/scripts/global_worker.zsh
end=$(gdate +%s%N)
loadtime=$(( $end - $start ))
echo "loadtime: $(( $loadtime/1000000000.0 ))"
