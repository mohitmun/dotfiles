show_status_bar(){
  tput sc
  tput cup $(($ORIGINAL_ROWS + 1)) 0
  echo -ne "$FG[241]$(get_battery)$DOT$LINES$DOT$(get_volume_indicator)$DOT$(time12)%{$reset_color%}"
  tput rc
}
PROMPT='$FG[237]
$FG[241]$S_TYPE$FG[237]%~
$(get_todo_status)
$FG[237]$(repeat_string $COLUMNS '-')%{$reset_color%}
$FG[032]%c\
$(git_prompt_info) \
$(jobs_prompt)\
$FG[105]%(!.#.»)%{$reset_color%}$(show_status_bar) '

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
NEWLINE=$'\n'
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

#set_scrollable_region(){
  ##tput smcup
  #tput csr 0 $(($LINES - 3))
  ##tput rmcup
#}

zle -N del-prompt-accept-line
bindkey "^M" del-prompt-accept-line

#set_scrollable_region
#TRAPWINCH(){
 #start_status_bar
#}

on_window_change(){
  echo -ne "on wind change LINES $LINES COLS $COLUMNS"
  export ORIGINAL_ROWS=$LINES
  export ORIGINAL_COLUMNS=$COLUMNS
  export RESIZE_ROWS=$(($LINES - 2))
  export RESIZE_COLUMNS=$COLUMNS
  set_scrollable_region
}
trap "on_window_change" SIGWINCH
set_scrollable_region(){
  # This is fucking gold
  stty rows $RESIZE_ROWS
  [ -n $TMUX ] && bkp_tmux=$TMUX && unset TMUX
  tmux new 'echo' -v
  [ -n $bkp_tmux ] && export TMUX=$bkp_tmux
}

on_window_change
set_scrollable_region
