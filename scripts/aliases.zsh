# GistID:963f95aaf61d50e512511ac4eb097e50
function add_alias() {
    if [[ -z $1 || -z $2 || $# -gt 2 ]]; then
        echo usage:
        echo "\t\$$0 ll 'ls -l'"
    else
        echo "alias $1='$2'" >> $ALIASFILE
        echo "alias ADDED to $ALIASFILE"
        alias $1="$2"
    fi
}

alias tn='tmux -CC new -s'
alias ts='tmux -CC new-session -s'
alias ta='tmux -CC attach -t'
alias ta='tmux -CC attach -t'
alias tad='tmux -CC attach -d -t'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias brew="brew -v"
#alias zshrc="vi ~/.zshrc"
#alias battrylogs="pmset -g log|grep -e ' Sleep  ' -e ' Wake  '"
#alias gist_vimrc="gist -r 963f95aaf61d50e512511ac4eb097e50 .vimrc"
#alias gist_zshrc="gist -r 963f95aaf61d50e512511ac4eb097e50 .zshrc"
#alias gistdiffzshrc="gist_zshrc > ~/.zshrc.latest && vimdiff ~/.zshrc.latest ~/.zshrc"
#alias gistdiffvimrc="gist_vimrc > ~/.vimrc.latest && vimdiff ~/.vimrc.latest ~/.vimrc"
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias tochromedata="cd ~/Library/Application\ Support/Google/Chrome/Default/"
tstodate(){
  gdate -d "@$1" # timestamp to date
}
alias ts="date +'%s'" # date to timestamp
#alias cat=bat
alias vim=vi
alias cpr="cp -r"
alias kill9="kill -9"
alias start_config_mode="export GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME"
alias stop_config_mode="unset GIT_DIR GIT_WORK_TREE"
alias config='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias sz='source ~/.zshrc'
alias cgd='config diff'
alias cgdca='cgd --cached'
alias cqc='config commit -m "quick commit"'
alias cqcp='cqc && config push'
alias cgcmsg='config commit -m'
alias cgst='config status'
alias cga='config add'
alias cgaa='config add -u'
alias cddesk='cd ~/Desktop'

# https://github.com/search?q=%22alias+-s%22+filename%3A.zshrc
#alias -s gz='tar -xzvf'
#alias -s tgz='tar -xzvf'
#alias -s zip='unzip'
#alias -s bz2='tar -xjvf'
#alias -s php=vi
##alias -s py=vi
#alias -s rb=vi
#alias -s html=vi

alias aliasgrep='alias | grep '
alias npmig='npm install -g '

#https://gist.github.com/igrigorik/6666860
gh(){
  open $(git config remote.origin.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")/$1$2
}
# Open current branch
alias ghb='gh tree/$(git symbolic-ref --quiet --short HEAD )'
# open current branch with directory
alias ghbf='gh tree/$(git symbolic-ref --quiet --short HEAD )/$(git rev-parse --show-prefix)'
# Open current directory/file in master branch
alias ghf='gh tree/master/$(git rev-parse --show-prefix)'
alias ctig='GIT_WORK_TREE=$HOME GIT_DIR=$HOME/.dotfiles tig'
alias time12='date +"%I:%M:%S %p"'
alias m='man'
alias chmodx='chmod +x'
alias watch='watch '
alias mansearch='man -wK '
alias tg='~/telegram-send/telegram_send.py'
alias tgf='tg -f'
alias chx='chmod +x'
alias top5='ps -Ao pid,pcpu,comm -r | head -n 6'
alias cqac='cgaa && cqc'
alias crdiff='config fetch origin master:master_remote && config diff master_remote..master'

alias di='docker images'
alias notes='cat ~/.notes'
#alias stop='pkill -STOP'
#alias cont='pkill -CONT'
alias downloadsong='youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'
alias calias='cga ~/.aliases.zsh && config commit -m 'alias update''
alias tailf='tail -f'

#https://github.com/caarlos0/ports/blob/master/ports
ports(){
  if [[ -n $1 ]];then
    lsof -i :"$1"
    return 0
  fi
  lsof -i -n -P
}
portskill(){
  ports "$1" | awk '{ print $2; }' #| xargs kill -9
}
alias -g LOGTOFILE="> stdout.log 2> stderr.log"
alias nvmact='export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
alias psa='ps -o %cpu,%mem'
alias psp='ps -p'
alias datetime='date "+%Y-%m-%d %H:%M:%S"'
alias killglobalthread='cat ~/.global_worker.pid | xargs kill -9'

stop(){
  ps aux |  grep -v grep | grep $1 | awk '{ print $2 }' | xargs kill -STOP
}

cont(){
  ps aux |  grep -v grep | grep $1 | awk '{ print $2 }' | xargs kill -CONT
}

alias cpull='config pull origin_github master'
alias tocode='cd ~/Desktop/code'

bkp(){
  cp $1 $1.bkp
}

alias loadavg='w | head -n1 | cut -d: -f4'
alias loadavguptime='uptime | cut -d: -f4- | sed s/,//g'

#================= CURL aliases =====================
alias jcurl="curl -H 'Content-Type: application/json'"
alias curl_github="curl -u $GITHUB_USERNAME_SPAM:$GITHUB_PASSWORD_SPAM"

curlpaginatexample(){
  curl "{maps,mail,photos}.google.com/{u,v,y}/[1-3]" -o "googlefile#1__#2__#3"
}
#================= CURL aliases =====================

change_extension(){
  for file in *.html; do
    mv "$file" "$(basename "$file" .html).txt"
  done
}
alias lslessthansize="find . -name '*' -size" # add -exec ls -la if more info
alias onlyalpha="tr -cd '[[:alnum:]]._-'"

readinvim(){
  lynx "$1" --dump | vim - +Goyo
}

tailgrep(){
  #TODO https://stackoverflow.com/a/1537695/2577465
  tail  -f $2 | grep --line-buffered -E $1
}

#===================== git aliases =====================
#https://stackoverflow.com/a/7124949/2577465
# TODO https://stackoverflow.com/questions/8435343/retrieve-the-commit-log-for-a-specific-line-in-a-file/31985012
# TODO https://stackoverflow.com/questions/14142609/git-discover-which-commits-ever-touched-a-range-of-lines
# TODO explore more in details https://github.com/so-fancy/diff-so-fancy
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gitsearchcommit='git log --all --grep='PATTERN''
alias gitundolastcommit='git reset HEAD~'
alias whatimpushing="git cherry -v"
alias showuntracked="git ls-files . --exclude-standard --others"
alias showuntrackedignored="git ls-files . --exclude-standard --others --ignored"
#====================================== copied from zsh git plugin
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glodsng="git log  --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias lastcommitfiles='git log --pretty=format: --name-only -n 1'
alias gitrenamebranch='git branch -m'
alias gpush='ggpush'
alias gpull='ggpull'
alias discardchanges='git checkout .'
alias yolo='git commit -m "$(curl -s whatthecommit.com/index.txt)"'
alias sn='git --git-dir=$HOME/.notable/.git --work-tree=$HOME/.notable commit -a -m "working"'
alias gsetorigin="git remote set-url origin "
gitcheckoutfilefrombranch(){
  git checkout $1 -- $2
}
# TODO git checkout file from particular branch/commmit
#====================================== copied from zsh git plugin
#===================== git aliases =====================

alias wcl='wc -l'
#alias ping='prettyping --nolegend'

#========== Common ops ==============
#Find duplicate files https://www.reddit.com/r/tinycode/comments/2ek3mi/fast_duplicate_file_finder_in_100_lines_of_c/ck0m716/
find_duplicate_files(){
  find $1 -type f -name '*' -print0 | xargs -0 md5sum > hashes.txt
  sort -k 1,1 < hashes.txt > hashes-sorted.txt
  uniq --check-chars=32 --all-repeated=separate hashes-sorted.txt
}

findEmptyDirsAndFiles(){
  find . -type f -exec bash -c 'if [ `cat "{}" |wc -w` -eq 0 ]; then echo "file - {}";fi' \; -or -empty -exec bash -c "echo dir - {}" \;
}
#========== Common ops ==============


#========== System info =============
alias findd="find . -type d -name" # find directory
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias rgl="rg -l" # show only files names
alias lssr="\du -ah . | grep -v "/$" | gsort -rh" # sort by size recursive
alias ls="ls -hG"
alias lss="ls -S" # sort by size
alias lst="ls -t" # recent first
alias lstr="ls -tr" # recent last
alias s="l -S" # sort by size
alias rmrf="rm -rf"

# from lib/directories.zsh
# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
#========== System info =============


#========== convert/imagemagic =============
alias mergesbs="convert +append" #convert +append step1.png step2.png out.png
#========== convert/imagemagic =============

alias shuf="gshuf"
alias randomrange="shuf -n 1 -i" # example gshuf -i 2-65 -n 1
