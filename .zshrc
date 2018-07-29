# GistID:963f95aaf61d50e512511ac4eb097e50
export ZSH=~/.oh-my-zsh

plugins=(
  git
  sudo
  tmuxinator
  transfer
  tmux
  #vi-mode
  copyfile
  copydir
  emoji-clock
  encode64
  lol
  jsontools
  z
)

source $ZSH/oh-my-zsh.sh
. ~/.secret_common_sh_rc

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
TAOCL_FILE=~/.taocl.md
if [ ! -f $TAOCL_FILE ]; then 
  echo "Getting TAOCL from github"
  \curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md -o $TAOCL_FILE 
fi
sed '/cowsay[.]png/d' $TAOCL_FILE | pandoc -f markdown -t html | xmlstarlet fo --html --dropdtd | xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" | xmlstarlet unesc | fmt -80 | iconv -t US | cowsay
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export HOMEBREW_NO_AUTO_UPDATE=1

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


# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search

eval $(thefuck --alias)

explain(){
  response=$(w3m -dump "http://explainshell.com/explain?cmd="$(echo $@ | tr ' ' '+'))
  cat -s <(grep -v -e explainshell -e • -e □ -e "source manpages" <<< "$response")
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

socktest(){
  \curl ipinfo.io/ip --socks5-hostname $1 
}

httptest(){
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
  local jobs_amount=$(jobs | wc -l | tr -d " ")
  [[ $jobs_amount -gt 0 ]] || return
  echo "$FG[196]($jobs_amount job)"
}
# primary prompt
if [ -n "$SSH_CLIENT" ]; then
    S_TYPE="ssh: "
else
    S_TYPE=""
fi
PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
$S_TYPE$FG[032]%c\
$(git_prompt_info) \
$(jobs_prompt)\
$FG[105]%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'


# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# right prompt
if type "virtualenv_prompt_info" > /dev/null
then
	RPROMPT='$(virtualenv_prompt_info)$my_gray%~%{$reset_color%}%'
else
	RPROMPT='$my_gray%~%{$reset_color%}%'
fi

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

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

#===========================
# Aliases START
#===========================
alias ts='tmux -CC new-session -s'
alias ta='tmux -CC attach -t'
alias brew="brew -v"
alias mux=tmuxinator
alias zshrc="vi ~/.zshrc"
alias battrylogs="pmset -g log|grep -e ' Sleep  ' -e ' Wake  '"
alias gist_vimrc="gist -r 963f95aaf61d50e512511ac4eb097e50 .vimrc"
alias gist_zshrc="gist -r 963f95aaf61d50e512511ac4eb097e50 .zshrc"
alias gistdiffzshrc="gist_zshrc > ~/.zshrc.latest && vimdiff ~/.zshrc ~/.zshrc.latest"
alias gistdiffvimrc="gist_vimrc > ~/.vimrc.latest && vimdiff ~/.vimrc ~/.vimrc.latest"
alias rgl="rg -l" # show only files names
alias lss="ls -S" # sort by size
alias lst="ls -t" # recent first
alias lstr="ls -tr" # recent last
alias s="l -S" # sort by size

# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias tochromedata="cd ~/Library/Application\ Support/Google/Chrome/Default/"
alias dater="date -r" # timestamp to date
#===========================
# Aliases END
#===========================

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
#
