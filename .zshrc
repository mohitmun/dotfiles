# GistID:963f95aaf61d50e512511ac4eb097e50
# vim: set ft=zsh:
#TODO https://github.com/progrium/basht

# https://github.com/mroth/dotfiles/blob/master/home/.zshrc
# set up some very basic profiling of how long zshrc takes to load.
# to test, use: ZSHRC_PROFILE=true zsh -ic "exit"

declare -A ZSHRC_LOAD_START=()
declare -A ZSHRC_LOAD_STOP=()
declare -A ZSHRC_LOAD_TIME=()

function profile_start () {
  ZSHRC_LOAD_START[$1]=$(gdate "+%s%3N")
}

function profile_stop () {
  ZSHRC_LOAD_STOP[$1]=$(gdate "+%s%3N")
  ZSHRC_LOAD_TIME[$1]=$(echo "$ZSHRC_LOAD_STOP[$1] - $ZSHRC_LOAD_START[$1]" | bc)
  printf "\033[1m%12s\033[0m loaded in:\t%4dms\n" $1 $ZSHRC_LOAD_TIME[$1]
}
profile_start "zshrc"
if [[ "$(uname)" == "Darwin" ]]; then
  platform="osx"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  platform="linux"
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
  platform="windows"
fi
logtime(){
  ts=$(ts)
  tsms=$(tsms)
  echo "logtime $1 ts:$ts tsms:$tsms" >> ~/.perf.zsh
}

export PLATFORM=$platform
export ZSH=~/omz
export REFRESH_RATE=60
export OSASCRIPT_REFRESH_RATE=60
export ALIASFILE=~/scripts/aliases.zsh

#start=$(gdate +%s%N)
plugins=(
  git
  transfer
  copyfile
  copydir
  encode64
  z
  battery
  alias-tips
  zsh-prioritize-cwd-history
  # TODO fix multiline commands
)
source $ALIASFILE
source $ZSH/oh-my-zsh.sh
[[ -f ~/.secret_common_sh_rc ]] && source ~/.secret_common_sh_rc
[ -f ~/secrets/.secret_keys ] && source ~/secrets/.secret_keys
source ~/scripts/colored_man_pages.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#autoload -Uz myspotify && myspotify
#. ~/.zsh-async.zsh
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export EDITOR=vim
export LESS="-i"
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
#export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
#bindkey '^I' $fzf_default_completion
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
#https://github.com/geerlingguy/mac-dev-playbook
#vtop
#https://github.com/k4m4/terminals-are-sexy
# https://github.com/jondot/awesome-devenv
# https://github.com/unixorn/awesome-zsh-plugins
# https://github.com/rgcr/m-cli
# fkill
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
#   * https://news.ycombinator.com/item?id=14634964
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
bindkey "^h" backward-char
bindkey "^f" forward-char
bindkey "^l" forward-char
bindkey "^v" forward-word
#https://blog.sebastian-daschner.com/entries/zsh-aliases
bindkey "^p" _expand_alias
bindkey "^s" switch_tty
#TODO what is difference when using function keyword or not

function repeat_string(){
  #printf "-%.0s" $COLUMNS
  chus=$(( $1 - 4))
  printf "$2%.0s" $(seq 1 $chus)
}

get_todo_status(){
  #a=$(FORCE_COLOR=0 tb -l notes | tail -n2)
  #echo $a
  which task > /dev/null && {
  task_count=$( task status:pending due count )
  # TODO due: red, other: green
  [ $task_count -gt 0 ] && echo -ne "$DOT$FG[196]$task_count"
}
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
#TODO https://github.com/danchoi/vmail
#TODO https://github.com/paulirish/git-recent
#TDOD explore entr
#TODO prompt - current directory size
#TODO prompt view recently exported variable
#https://github.com/MikeDacre/cdbk
#
#===========================
# THEME END
#===========================


# mkdir, and cd
function mcd() {
    mkdir -p "$1" && cd "$1";
}
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/sbin"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
#export PATH="$PATH:$HOME/Library/Android/sdk/tools"
#export PATH="$PATH:$HOME/Library/Android/sdk/ndk-bundle"
#export PATH="$PATH:$HOME/Library/Android/sdk/build-tools/25.0.0"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
export PYTHONSTARTUP=~/.pythonrc
export ANDROID_HOME=/Users/mohitmunjani/Library/Android/sdk
export ANDROID_SDK_ROOT=/Users/mohitmunjani/Library/Android/sdk

export PATH="$PATH:$ANDROID_HOME/platform-tools"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH="$JAVA_HOME/bin:$PATH"
#alias curl="curl --socks5-hostname 127.0.0.1:9050"
export NVM_DIR="/Users/mohitmunjani/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

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

switch_tty(){
w |  awk '{print $2" - " $6" "$7}'| fzf | xargs -I{} ttyfilter.js "" {} | jq -r '.items | .[] | .arg' | read args && iterm2_action_tty.js $args
}
zle -N switch_tty

tty_dir() {
  PIDS="$(ps -t $1 -opid= | tr -d ' ' | tr '\n' ',')"
  [[ -n "$PIDS" ]] || { echo "no pids found for $1"; return 1; }
  lsof -a -d cwd -c '/^(k|c|ba|tc|z)?sh$/' -p "$PIDS" -Fn | grep "^n" | cut -c2- | awk -F$HOME/ '{print $2}'
}

start_interactive_alias_save(){
  echo $BUFFER > /tmp/zlebuffer
  BUFFER="add_alias_from_buffer "
}
zle -N start_interactive_alias_save
add_alias_from_buffer(){
  val=$(cat /tmp/zlebuffer)
  add_alias $1 "$val"
}

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
  return 0
  echo "stop_hogging_processes"
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
#https://news.ycombinator.com/item?id=18216385
cdf () {
  currFolderPath=$(/usr/bin/osascript ~/scripts/finder.osascript)
  echo "cd to \"$currFolderPath\""
  cd "$currFolderPath"
}

source ~/scripts/prompt.zsh

zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

if [ $PLATFORM = "osx" ];then
  source ~/scripts/global_worker.zsh
fi

#end=$(gdate +%s%N)
#loadtime=$(( $end - $start ))
#echo "loadtime: $(( $loadtime/1000000000.0 ))"

# ===================== https://github.com/SidOfc/dotfiles/ =====================
kp(){

local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

if [ "x$pid" != "x" ]
then
  echo $pid | xargs kill -${1:-9}
  kp
fi
}

ks(){
  ### SERVER
  # mnemonic: [K]ill [S]erver
  # show output of "lsof -Pwni tcp", use [tab] to select one or multiple entries
  # press [enter] to kill selected processes and go back to the process list.
  # or press [escape] to go back to the process list. Press [escape] twice to exit completely.
  local pid=$(lsof -Pwni tcp | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:tcp]'" | awk '{print $2}')
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
    ks
  fi
}


notify_telegram(){
  jcurl -d "{\"value1\":\"$1\",\"value2\":\"$2\",\"value3\":\"$3\"}" https://maker.ifttt.com/trigger/telegram_alert/with/key/${IFTTT_TOKEN}
}

#autoload -U promptinit; promptinit
#prompt pure
add-zsh-hook chpwd run_local_rc

run_local_rc(){
  # TODO break when spaces in directory name
  if [ -f $(pwd)/.localrc ];then
    echo "executing localrc"
    . $(pwd)/.localrc
  else

  fi
  [ ! -f $(pwd)/.notes ]
  export NOTES=$?
}


# extract archive
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *.exe)       cabextract $1  ;;
      *.ace)       unace $1       ;;
      *.arj)       unarj $1       ;;
      *)           echo "'$1': unrecognized file compression" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


