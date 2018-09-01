# issues
# 1. infinite scrolling
# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
NEWLINE=$'\n'
STATUS_BAR='$FG[241]$(get_battery)$DOT$(get_volume_indicator)$DOT$(time12)%{$reset_color%}'
#STATUS_BAR_ENABLED=1
show_status_bar(){
  if [[ -n $STATUS_BAR_ENABLED ]];then
    tput sc
    tput cup $(($ORIGINAL_ROWS)) 0
    echo -ne $STATUS_BAR
    tput cup $(($ORIGINAL_ROWS - 2)) 0
    echo -ne "$FG[241]"
    repeat_string $(($ORIGINAL_COLUMNS - 5)) "_"
    echo -ne "$reset_color"
    tput rc
  else
    echo -ne $STATUS_BAR
  fi
}
branch=master mode=insert
#https://unix.stackexchange.com/a/250457/219826
#setopt promptsubst
#left='%m | %~'
#PS1=%K{green}$left${(l,COLUMNS-${#${(%)left}},)${${:-$branch | $mode}//[%]/%%}}%k$
prompt_character(){
echo -ne "%(?.$FG[078].%F{red})❯%f"
}
get_second_line(){
  current_dir_with_jobs="${(%):-%c}$(jobs_prompt)"
  #gpi="${(%):-$(git_prompt_info)}"
  gpi="$(git_prompt_info)"
  echo "$FG[032]$current_dir_with_jobs${gpi}"
}


PROMPT='$FG[241]$S_TYPE$FG[240]%~ $(get_todo_status) %{$reset_color%}
$(get_second_line)
$FG[105]$(prompt_character)%{$reset_color%} '
RPROMPT="$STATUS_BAR"
TMOUT=1
#https://github.com/robbyrussell/oh-my-zsh/issues/5910#issuecomment-294509017
TRAPALRM() {
    if [[ $WIDGET != *"complete"* && $WIDGET != *"-search" ]]; then;
      #async_job vagrant_prompt_worker export-spotify-status $PWD
      zle reset-prompt
      #bsl_set_status_line
      #thanks https://github.com/wilywampa/vimconfig/blob/b95caa50883438288729b6e8ff963783b110a3a5/dotfiles/.zshrc#L1374
      if [[ -n $BUFFER ]]; then
        TMOUT=5
      else
        TMOUT=1
      fi
      #echo $BUFFER > ~/.debug_async
    fi
}
#https://superuser.com/a/1029103/630985
del-prompt-accept-line() {
    OLD_PROMPT="$PROMPT"
    OLD_RPROMPT="$RPROMPT"
    RPROMPT=""
    PROMPT="$FG[237]$(repeat_string $COLUMNS -)${NEWLINE}$FG[105]%(!.#.»»)%{$reset_color%} "
    zle reset-prompt
    RPROMPT="$OLD_RPROMPT"
    PROMPT="$OLD_PROMPT"
    zle accept-line
}
get_cursor_position(){
  #https://stackoverflow.com/a/43911767/2577465
  echo -ne "\033[6n" > /dev/tty
  read -t 1 -s -d 'R' line < /dev/tty
  line="${line##*\[}"
  line="${line%;*}"
  export current_cursor_line=$line
}

r(){
  printf "\e]1337;ClearScrollback\007"
  set_scrollable_region
}

# set_scrollable_region(){
# ##tput smcup
  #tput csr 0 $(($LINES - 3))
  ##tput rmcup
#}

zle -N del-prompt-accept-line
bindkey "^M" del-prompt-accept-line

on_window_change(){
  if [[ -n $STATUS_BAR_ENABLED ]];then
    export ORIGINAL_ROWS=$LINES
    export ORIGINAL_COLUMNS=$COLUMNS
    set_scrollable_region
  fi
}

trap "on_window_change" SIGWINCH

set_scrollable_region(){
  # This is fucking gold
  export RESIZE_ROWS=$(($LINES - 2))
  export RESIZE_COLUMNS=$COLUMNS
  stty rows $RESIZE_ROWS
  [ -n $TMUX ] && bkp_tmux=$TMUX && unset TMUX
  tmux new 'echo' -v
  [ -n $bkp_tmux ] && export TMUX=$bkp_tmux
}

init_status_bar(){
  on_window_change
}
[[ -n $STATUS_BAR_ENABLED ]] && init_status_bar
