# GistID:963f95aaf61d50e512511ac4eb097e50
alias ts='tmux -CC new-session -s'
alias ta='tmux -CC attach -t'
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
alias cat=bat
alias vim=vi
alias cpr="cp -r"
alias kill9="kill -9"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
