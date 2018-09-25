# issues
# 1. infinite scrolling
# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
NEWLINE=$'\n'
PROMPT_CHAR='❯'
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
  echo -ne "%(?.$FG[078].%F{red})$PROMPT_CHAR%f"
}
get_second_line(){
  current_dir_with_jobs="${(%):-%c}$(jobs_prompt)"
  #gpi="${(%):-$(git_prompt_info)}"
  gpi="$(git_prompt_info)"
  echo "$FG[032]$current_dir_with_jobs${gpi}"
}


PROMPT='$FG[240]$S_TYPE$FG[242]%~ $(get_todo_status) %{$reset_color%}
$(get_second_line)
$FG[105]$(prompt_character)%{$reset_color%} '
RPROMPT="$STATUS_BAR"
TMOUT=60
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
    PROMPT="$FG[237]$(repeat_string $COLUMNS -)${NEWLINE}$FG[105]$(prompt_character)%{$reset_color%} "
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
