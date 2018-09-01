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
ALIASFILE=~/.aliases.zsh
source $ZSH/oh-my-zsh.sh
[[ -f ~/.secret_common_sh_rc ]] && source ~/.secret_common_sh_rc
source $ALIASFILE
source ~/.colored_man_pages.zsh
~/.global_worker.zsh > /dev/null &!
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

# All about awesome-cli
# https://github.com/whiteinge/ok.sh Github client in bash
## https://github.com/agarrharr/awesome-cli-apps
# explore more on https://github.com/alebcay/awesome-shell 	
#
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

HEART='❤'
DOT=' ● '
SILENT_EMOJI="😶 "

get_volume_indicator(){
  export_osascript_system_status
  if [ -z $volume_level ]; then
    echo -n "NA"
  elif [ $volume_level -eq 0 ]; then
    echo -n "$SILENT_EMOJI"
  else
    volume_bar_count=$(( $volume_level / 10))
    printf "|%.0s" {0..$volume_bar_count}
  fi
}

get_battery(){

  battery_info=`pmset -g batt`
  current_charge=$(echo $battery_info | grep -o '[0-9]\+%' | awk '{sub (/%/, "", $1); print $1}')

  #if [[ $current_charge -lt 10 ]]; then
      #echo -n "$FG[052]"
  #elif [[ $current_charge -lt 30 ]]; then
      #echo -n "$FG[058]"
  #elif [[ $current_charge -lt 50 ]]; then
      #echo -n "$FG[064]"
  #elif [[ $current_charge -lt 70 ]]; then
      #echo -n "$FG[070]"
  #elif [[ $current_charge -lt 90 ]]; then
      #echo -n "$FG[076]"
  #else
      #echo -n "$FG[082]"
  #fi

  echo -n "$HEART $current_charge "
}

export_osascript_system_status(){
  cat ~/.export_osascript_system_status | while read i; do
    if [ -z $i ];then
      continue
    fi
    KEY_VALUE=("${(@s/=/)i}")
    export "$KEY_VALUE[1]=$KEY_VALUE[2]"
  done
}
get_spotify_widget(){
  export_osascript_system_status
  if [[ -n $spotify_track ]]; then
  else
    return
  fi
  local columns=$(($COLUMNS - 20))
  echo -n $FG[241] $spotify_track
  echo -n " - "
  echo -n $spotify_artist
  int=${spotify_percent_progress%.*}
  spotify_percent_progress=$(( $int * $columns / 100 ))
  #spotify_percent_progress=printf "%.0f\n" "$spotify_percent_progress"
  echo " ($FG[241]$spotify_position/$FG[241]$spotify_duration)"
  #echo -n $FG[076]
  #printf "=%.0s" {0..$spotify_percent_progress}
  #echo -n $reset_color
  #remain=$(($columns - $spotify_percent_progress ))
  #printf "=%.0s" {0..$remain}
  #printf "|%.0s" {0..$spotify_percent_progress}
}

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
jobs_prompt() {
  local jobs_amount=$((jobs) | wc -l | tr -d " ")
  [[ $jobs_amount -gt 0 ]] || return
  echo "$FG[196]($jobs_amount job)"
}
get_tmux_session_name(){
  if [ -n "$TMUX" ]; then
    session_name=$(tmux display -p | cut -d '[' -f2 | cut -d ']' -f1)
    echo -n "[mux:$session_name]"
  fi
}
# primary prompt
if [ -n "$SSH_CLIENT" ]; then
    S_TYPE="[ssh]"
else
    S_TYPE=""
fi
S_TYPE=$S_TYPE$(get_tmux_session_name)

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

list_repo_containing_search(){
  #TODO need to edit function 
  # == == == == == == == == == == == == == == == == == == == ==
  # List repo by user
  # curl -G 'https://api.github.com/users/mohitmun/repos?page=3&per_page=100'
  # == == == == == == == == == == == == == == == == == == == ==
  # List repo by org
  # curl -G 'https://api.github.com/orgs/google/repos?page=3&per_page=100'
  # == == == == == == == == == == == == == == == == == == == ==
  # List repo info
  # curl -G 'https://api.github.com/repo/username/reponame'
  # == == == == == == == == == == == == == == == == == == == ==
  for NUM in `seq 16`; do
    curl "https://github.com/search?p=$GPAGE&q=my_query&type=Code" --compressed > github$GPAGE;
    cat github$NUM | pup "#code_search_results > div.code-list a.text-bold text{}" >> searchlist;
  done
  uniq searchlist > searchlistuniq
  while read repo;
    do curl "https://api.github.com/repos/"$repo > `echo $repo | tr '/' '-'` 
    sleep 2
  done < searchlistuniq
  cat * | jq -r '[.full_name, .stargazers_count, .description] | @csv' > repos.csv
}

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

# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
function find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Better find(1)
function ff() {
  find . -iname "*${1:-}*"
}
#
# Show current Finder directory.
#function finder {
  #osascript 2>/dev/null <<EOF
    #tell application "Finder"
      #return POSIX path of (target of window 1 as alias)
    #end tell
#EOF
#github.com/tj/burl
BURL_FILE=/usr/local/bin/burl
if [ ! -f $BURL_FILE ]; then
  echo "Getting burl from github"
  \curl -s https://raw.githubusercontent.com/tj/burl/master/bin/burl -o $BURL_FILE 
  chmod +x $BURL_FILE
fi

# chpwd(){
#   ls
# }

curl_github(){
  curl -u $GITHUB_USERNAME_SPAM:$GITHUB_PASSWORD_SPAM "https://api.github.com$1"
}
#TODO https://gist.github.com/phette23/5270658
#TODO https://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh/292660#292660

c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}
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
google(){
    search=""
    echo "Googling: $@"
    for term in $@; do
        search="$search%20$term"
    done
    open "http://www.google.com/search?q=$search"
}


#TODO check zsh folder here at https://github.com/cehoffman/dotfiles
# TODO what is zstyle ':completion:*'
#TODO spotify show shuffle status
#TODO https://news.ycombinator.com/item?id=17755199
#TODO htoprc
# TODO why this code breaks
#testmybug(){
    #printf "-%.0s" $(seq 1 $COLUMNS)
#}
#PROMPT="$(testmybug)
#53hello >>>"

# combined effors of following
# https://github.com/joshbuchea/config/blob/master/.zshrc
# Convert video to GIF
#
# Usage: vid2gif in.mov [width] [fps]
#
# typical gif framerates seem to be between 10–20
#
# possibly run through gif optimization tool
#
# ffmpeg options explained:
#
# -i    input
# -y    overwrite output files without confirmation
# -t    duration
# -ss   position
#
function vid2gif() {
  local width=${2:-600}
  local rate=${3:-20}
  local filters="fps=$rate,scale=$width:-1:flags=lanczos"

  # generate a palette
  #
  # not sure if palette needs scale or flags (or all of $filters?)...
	ffmpeg -i "$1" -vf "$filters,palettegen" -y palette.png

  # then generate gif with palette
  ffmpeg -i "$1" -i palette.png -filter_complex "$filters,paletteuse" "${1%.*}.gif"

  # remove palette image file
  rm palette.png
}

proxy_server(){
  #TODO fix this awesomeness
  ~/.proxy_server.sh $1
}

killp(){
  kill $(lsof -t -i:$1)
}

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

end=$(gdate +%s%N)
loadtime=$(( $end - $start ))
echo "loadtime: $(( $loadtime/1000000000.0 ))"

source ~/.prompt.zsh
