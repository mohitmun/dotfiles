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
alias mux=tmuxinator
alias zshrc="vi ~/.zshrc"
alias battrylogs="pmset -g log|grep -e ' Sleep  ' -e ' Wake  '"
alias gist_vimrc="gist -r 963f95aaf61d50e512511ac4eb097e50 .vimrc"
alias gist_zshrc="gist -r 963f95aaf61d50e512511ac4eb097e50 .zshrc"
alias gistdiffzshrc="gist_zshrc > ~/.zshrc.latest && vimdiff ~/.zshrc.latest ~/.zshrc"
alias gistdiffvimrc="gist_vimrc > ~/.vimrc.latest && vimdiff ~/.vimrc.latest ~/.vimrc"
alias rgl="rg -l" # show only files names
alias lss="ls -S" # sort by size
alias lst="ls -t" # recent first
alias lstr="ls -tr" # recent last
alias s="l -S" # sort by size
alias rmrf="rm -rf"
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias tochromedata="cd ~/Library/Application\ Support/Google/Chrome/Default/"
alias dater="date -r" # timestamp to date
alias ts="date +'%s'" # date to timestamp
#alias cat=bat
alias vim=vi
alias cpr="cp -r"
alias kill9="kill -9"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
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
alias lastcommitfiles='git log --pretty=format: --name-only -n 1'
alias gitrenamebranch='git branch -m'
alias gpush='ggpush'
alias gpull='ggpull'
alias discardchanges='git checkout .'

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
alias sconsify='~/bin/sconsify'

alias curl_github="curl -u $GITHUB_USERNAME_SPAM:$GITHUB_PASSWORD_SPAM"
alias cpull='config pull origin_github master'
alias cpu='~/bin/cpu'
alias imgcat='~/scripts/imgcat'
alias imgls='~/scripts/imgls'
alias imgcat='~/script/imgcat'
