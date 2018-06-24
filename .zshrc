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

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# GistID:963f95aaf61d50e512511ac4eb097e50

export EDITOR=vim

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
# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
if [ -n "$SSH_CLIENT" ]; then
    S_TYPE="ssh: "
else
    S_TYPE=""
fi
PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
$S_TYPE$FG[032]%c\
$(git_prompt_info) \
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

alias ts='tmux -CC new-session -s'
alias ta='tmux -CC attach -t'
alias brew="brew -v"
alias mux=tmuxinator
alias zshrc="vi ~/.zshrc"
alias battrylogs="pmset -g log|grep -e ' Sleep  ' -e ' Wake  '"
export PATH="$PATH:$HOME/.rvm/bin"