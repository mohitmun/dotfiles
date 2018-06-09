# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/mohit/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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
)

source $ZSH/oh-my-zsh.sh
. ~/.secret_common_sh_rc

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# GistID:963f95aaf61d50e512511ac4eb097e50

alias brew="brew -v"
alias mux=tmuxinator
alias zshrc="vi ~/.zshrc"

export EDITOR=vim

# ====================
# Get new tip from the art of command line repo everyday. can be use for different stuff also
TAOCL_FILE=~/.taocl.md
if [ ! -f $TAOCL_FILE ]; then 
  echo "Getting TAOCL from github"
  curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md > $TAOCL_FILE 
fi
sed '/cowsay[.]png/d' $TAOCL_FILE | pandoc -f markdown -t html | xmlstarlet fo --html --dropdtd | xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" | xmlstarlet unesc | fmt -80 | iconv -t US | cowsay
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export HOMEBREW_NO_AUTO_UPDATE=1

# ==============================================
# ==============================================
# git@github.com:rupa/z.git
. ~/.cli-tools/z/z.sh

# Dotfiles to follow
# https://github.com/whiteinge/dotfiles/

# All about awesome-cli
# https://github.com/whiteinge/ok.sh Github client in bash
# explore more on https://github.com/alebcay/awesome-shell 	
#
# A command-line todo list manager for people that want to finish tasks, not organize them
# https://github.com/sjl/t


# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

bindkey "^j" history-search-forward
bindkey "^k" history-search-backward
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

