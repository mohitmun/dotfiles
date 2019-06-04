# issues
# 1. infinite scrolling
# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
NEWLINE=$'\n'
PROMPT_CHAR='❯'
STATUS_BAR='$FG[241]$(get_battery)$DOT$(get_volume_indicator)$(get_todo_status)%{$reset_color%}'
#autoload -Uz async && async
source ~/.zsh-async/async.plugin.zsh
autoload -Uz vcs_info

jobs_prompt() {
  local jobs_amount=$((jobs) | wc -l | tr -d " ")
  [[ $jobs_amount -gt 0 ]] || return
  echo "$FG[196]($jobs_amount job)"
}

prompt_character(){
  echo -ne "%(?.$FG[078].%F{red})$PROMPT_CHAR%f"
}

prompt_pure_preprompt_render() {
	setopt localoptions noshwordsplit

	# Set color for git branch/dirty status, change color if dirty checking has
	# been delayed.
	local git_color=242
	[[ -n ${prompt_pure_git_last_dirty_check_timestamp+x} ]] && git_color=red

	# Initialize the preprompt array.
	local -a preprompt_parts

	# Set the path.
	preprompt_parts+=('%F{blue}%~%f')

	# Add git branch and dirty status info.
	typeset -gA prompt_pure_vcs_info
	if [[ -n $prompt_pure_vcs_info[branch] ]]; then
		preprompt_parts+=("%F{$git_color}"'${prompt_pure_vcs_info[branch]}${prompt_pure_git_dirty}%f')
	fi
	# Git pull/push arrows.
	if [[ -n $prompt_pure_git_arrows ]]; then
		preprompt_parts+=('%F{cyan}${prompt_pure_git_arrows}%f')
	fi

	# Username and machine, if applicable.
	[[ -n $prompt_pure_state[username] ]] && preprompt_parts+=('${prompt_pure_state[username]}')
	# Execution time.
	[[ -n $prompt_pure_cmd_exec_time ]] && preprompt_parts+=('%F{yellow}${prompt_pure_cmd_exec_time}%f')

	local cleaned_ps1=$PROMPT
	local -H MATCH MBEGIN MEND
	if [[ $PROMPT = *$prompt_newline* ]]; then
		# Remove everything from the prompt until the newline. This
		# removes the preprompt and only the original PROMPT remains.
		cleaned_ps1=${PROMPT##*${prompt_newline}}
	fi
	unset MATCH MBEGIN MEND

	# Construct the new prompt with a clean preprompt.
	local -ah ps1
	ps1=(
		${(j. .)preprompt_parts}  # Join parts, space separated.
		$prompt_newline           # Separate preprompt and prompt.
		$cleaned_ps1
	)

  #PROMPT="${(j..)ps1}"

  current_dir_with_jobs="${(%):-%c}$(jobs_prompt)"
  #gpi="${(%):-$(git_prompt_info)}"
  gpi="$(git_prompt_info)"
  if [ -z $GIT_DIR ];then
  else
    git_dotfile_mode="$FG[078](git_dir:$GIT_DIR )"
    # below truncats line
    #git_dotfile_mode="$FG[078](git_dir:$GIT_DIR )${reset_color}"
  fi
  [[ $NOTES -eq 1 ]] && notes='[N]'
  export GET_SECO="$FG[032]$current_dir_with_jobs${gpi}$git_dotfile_mode${notes}${prompt_pure_git_arrows}"
  export LEN_GET_SECO=$(print -P $GET_SECO | removeansii | wc -m )

  export RIGHT_SECOND_LINE="$(shortdatetime)"

  line_1='$FG[242]%~ %{$reset_color%}'
  line_2='$GET_SECO$FG[241]${(l,COLUMNS-$LEN_GET_SECO,,,)${${:-$RIGHT_SECOND_LINE}//[%]/%%}}'
  line_3='$FG[240]$S_TYPE$FG[105]$(prompt_character)%{$reset_color%} '


	ps1=(
		$line_1  # Join parts, space separated.
		$prompt_newline           # Separate preprompt and prompt.
    $line_2
		$prompt_newline
    $line_3
	)
  PROMPT="${(j..)ps1}"
  RPROMPT="$STATUS_BAR"
	# Expand the prompt for future comparision.
	local expanded_prompt
	expanded_prompt="${(S%%)PROMPT}"

	if [[ $1 == precmd ]]; then
		# Initial newline, for spaciousness.
		print
	elif [[ $prompt_pure_last_prompt != $expanded_prompt ]]; then
		# Redraw the prompt.
    debug_prompt "prompt not same , redrawing prompt"
		zle && zle .reset-prompt
  else
    debug_prompt "propt same $expanded_prompt"
	fi

	typeset -g prompt_pure_last_prompt=$expanded_prompt
}

prompt_pure_async_vcs_info() {
	setopt localoptions noshwordsplit

	# configure vcs_info inside async task, this frees up vcs_info
	# to be used or configured as the user pleases.
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' use-simple true
	# only export two msg variables from vcs_info
	zstyle ':vcs_info:*' max-exports 2
	# export branch (%b) and git toplevel (%R)
	zstyle ':vcs_info:git*' formats '%b' '%R'
	zstyle ':vcs_info:git*' actionformats '%b|%a' '%R'

	vcs_info

	local -A info
	info[pwd]=$PWD
	info[top]=$vcs_info_msg_1_
	info[branch]=$vcs_info_msg_0_

	print -r - ${(@kvq)info}
}

prompt_pure_async_tasks() {

	setopt localoptions noshwordsplit

	# initialize async worker
	((!${prompt_pure_async_init:-0})) && {
		async_start_worker "prompt_pure" -u -n
		async_register_callback "prompt_pure" prompt_pure_async_callback
		typeset -g prompt_pure_async_init=1
	}

	# Update the current working directory of the async worker.
	async_worker_eval "prompt_pure" builtin cd -q $PWD

	typeset -gA prompt_pure_vcs_info

	local -H MATCH MBEGIN MEND
	if [[ $PWD != ${prompt_pure_vcs_info[pwd]}* ]]; then
		# stop any running async jobs
		async_flush_jobs "prompt_pure"

		# reset git preprompt variables, switching working tree
		unset prompt_pure_git_dirty
		unset prompt_pure_git_last_dirty_check_timestamp
		unset prompt_pure_git_arrows
		unset prompt_pure_git_fetch_pattern
		prompt_pure_vcs_info[branch]=
		prompt_pure_vcs_info[top]=
	fi
	unset MATCH MBEGIN MEND

	async_job "prompt_pure" prompt_pure_async_vcs_info

	# # only perform tasks inside git working tree
	[[ -n $prompt_pure_vcs_info[top] ]] || return

	prompt_pure_async_refresh
}


prompt_pure_async_refresh() {
	setopt localoptions noshwordsplit

	if [[ -z $prompt_pure_git_fetch_pattern ]]; then
		# we set the pattern here to avoid redoing the pattern check until the
		# working three has changed. pull and fetch are always valid patterns.
		typeset -g prompt_pure_git_fetch_pattern="pull|fetch"
		async_job "prompt_pure" prompt_pure_async_git_aliases
	fi

	async_job "prompt_pure" prompt_pure_async_git_arrows

	# do not preform git fetch if it is disabled or in home folder.
	if (( ${PURE_GIT_PULL:-1} )) && [[ $prompt_pure_vcs_info[top] != $HOME ]]; then
		# tell worker to do a git fetch
		async_job "prompt_pure" prompt_pure_async_git_fetch
	fi

	# if dirty checking is sufficiently fast, tell worker to check it again, or wait for timeout
	integer time_since_last_dirty_check=$(( EPOCHSECONDS - ${prompt_pure_git_last_dirty_check_timestamp:-0} ))
	if (( time_since_last_dirty_check > ${PURE_GIT_DELAY_DIRTY_CHECK:-1800} )); then
		unset prompt_pure_git_last_dirty_check_timestamp
		# check check if there is anything to pull
		async_job "prompt_pure" prompt_pure_async_git_dirty ${PURE_GIT_UNTRACKED_DIRTY:-1}
	fi
}

prompt_pure_async_git_arrows() {
	setopt localoptions noshwordsplit
	command git rev-list --left-right --count HEAD...@'{u}'
}



prompt_pure_check_git_arrows() {
	setopt localoptions noshwordsplit
	local arrows left=${1:-0} right=${2:-0}

	(( right > 0 )) && arrows+=${PURE_GIT_DOWN_ARROW:-⇣}
	(( left > 0 )) && arrows+=${PURE_GIT_UP_ARROW:-⇡}

	[[ -n $arrows ]] || return
  #echo "wowow $arrows"
	typeset -g REPLY=$arrows
}
prompt_pure_async_git_fetch() {
	setopt localoptions noshwordsplit

	# set GIT_TERMINAL_PROMPT=0 to disable auth prompting for git fetch (git 2.3+)
	export GIT_TERMINAL_PROMPT=0
	# set ssh BachMode to disable all interactive ssh password prompting
	export GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-"ssh"} -o BatchMode=yes"

	# Default return code, indicates Git fetch failure.
	local fail_code=99

	# Guard against all forms of password prompts. By setting the shell into
	# MONITOR mode we can notice when a child process prompts for user input
	# because it will be suspended. Since we are inside an async worker, we
	# have no way of transmitting the password and the only option is to
	# kill it. If we don't do it this way, the process will corrupt with the
	# async worker.
	setopt localtraps monitor

	# Make sure local HUP trap is unset to allow for signal propagation when
	# the async worker is flushed.
	trap - HUP

	trap '
		# Unset trap to prevent infinite loop
		trap - CHLD
		if [[ $jobstates = suspended* ]]; then
			# Set fail code to password prompt and kill the fetch.
			fail_code=98
			kill %%
		fi
	' CHLD

	command git -c gc.auto=0 fetch >/dev/null &
	wait $! || return $fail_code

	unsetopt monitor

	# check arrow status after a successful git fetch
	prompt_pure_async_git_arrows
}
prompt_pure_async_callback() {
  #set -o xtrace
	setopt localoptions noshwordsplit
	local job=$1 code=$2 output=$3 exec_time=$4 next_pending=$6
	local do_render=0

  #echo "job $job output $output"
	case $job in
		prompt_pure_async_vcs_info)
			local -A info
			typeset -gA prompt_pure_vcs_info

			# parse output (z) and unquote as array (Q@)
			info=("${(Q@)${(z)output}}")
			local -H MATCH MBEGIN MEND
			if [[ $info[pwd] != $PWD ]]; then
				# The path has changed since the check started, abort.
				return
			fi
			# check if git toplevel has changed
			if [[ $info[top] = $prompt_pure_vcs_info[top] ]]; then
				# if stored pwd is part of $PWD, $PWD is shorter and likelier
				# to be toplevel, so we update pwd
				if [[ $prompt_pure_vcs_info[pwd] = ${PWD}* ]]; then
					prompt_pure_vcs_info[pwd]=$PWD
				fi
			else
				# store $PWD to detect if we (maybe) left the git path
				prompt_pure_vcs_info[pwd]=$PWD
			fi
			unset MATCH MBEGIN MEND

			# update has a git toplevel set which means we just entered a new
			# git directory, run the async refresh tasks
			[[ -n $info[top] ]] && [[ -z $prompt_pure_vcs_info[top] ]] && prompt_pure_async_refresh

			# always update branch and toplevel
			prompt_pure_vcs_info[branch]=$info[branch]
			prompt_pure_vcs_info[top]=$info[top]

			do_render=1
			;;
		prompt_pure_async_git_aliases)
			if [[ -n $output ]]; then
				# append custom git aliases to the predefined ones.
				prompt_pure_git_fetch_pattern+="|$output"
			fi
			;;
		prompt_pure_async_git_dirty)
			local prev_dirty=$prompt_pure_git_dirty
			if (( code == 0 )); then
				unset prompt_pure_git_dirty
			else
				typeset -g prompt_pure_git_dirty="*"
			fi

			[[ $prev_dirty != $prompt_pure_git_dirty ]] && do_render=1

			# When prompt_pure_git_last_dirty_check_timestamp is set, the git info is displayed in a different color.
			# To distinguish between a "fresh" and a "cached" result, the preprompt is rendered before setting this
			# variable. Thus, only upon next rendering of the preprompt will the result appear in a different color.
			(( $exec_time > 5 )) && prompt_pure_git_last_dirty_check_timestamp=$EPOCHSECONDS
			;;
		prompt_pure_async_git_fetch|prompt_pure_async_git_arrows)
			# prompt_pure_async_git_fetch executes prompt_pure_async_git_arrows
			# after a successful fetch.
			case $code in
				0)
					local REPLY
					prompt_pure_check_git_arrows ${(ps:\t:)output}
					if [[ $prompt_pure_git_arrows != $REPLY ]]; then
						typeset -g prompt_pure_git_arrows=$REPLY
						do_render=1
					fi
					;;
				99|98)
					# Git fetch failed.
					;;
				*)
					# Non-zero exit status from prompt_pure_async_git_arrows,
					# indicating that there is no upstream configured.
					if [[ -n $prompt_pure_git_arrows ]]; then
						unset prompt_pure_git_arrows
						do_render=1
					fi
					;;
			esac
			;;
	esac

	if (( next_pending )); then
		(( do_render )) && typeset -g prompt_pure_async_render_requested=1
		return
	fi

	[[ ${prompt_pure_async_render_requested:-$do_render} = 1 ]] && prompt_pure_preprompt_render
	unset prompt_pure_async_render_requested
}

prompt_pure_async_git_dirty() {
	setopt localoptions noshwordsplit
	local untracked_dirty=$1

	if [[ $untracked_dirty = 0 ]]; then
		command git diff --no-ext-diff --quiet --exit-code
	else
		test -z "$(command git status --porcelain --ignore-submodules -unormal)"
	fi

	return $?
}

# stores (into prompt_pure_cmd_exec_time) the exec time of the last command if set threshold was exceeded
prompt_pure_check_cmd_exec_time() {
	integer elapsed
	(( elapsed = EPOCHSECONDS - ${prompt_pure_cmd_timestamp:-$EPOCHSECONDS} ))
	typeset -g prompt_pure_cmd_exec_time=
	(( elapsed > ${PURE_CMD_MAX_EXEC_TIME:-5} )) && {
		prompt_pure_human_time_to_var $elapsed "prompt_pure_cmd_exec_time"
	}
}

prompt_pure_preexec() {
	if [[ -n $prompt_pure_git_fetch_pattern ]]; then
		# detect when git is performing pull/fetch (including git aliases).
		local -H MATCH MBEGIN MEND match mbegin mend
		if [[ $2 =~ (git|hub)\ (.*\ )?($prompt_pure_git_fetch_pattern)(\ .*)?$ ]]; then
			# we must flush the async jobs to cancel our git fetch in order
			# to avoid conflicts with the user issued pull / fetch.
			async_flush_jobs 'prompt_pure'
		fi
	fi

	typeset -g prompt_pure_cmd_timestamp=$EPOCHSECONDS

	# shows the current dir and executed command in the title while a process is active

	#prompt_pure_set_title 'ignore-escape' "$PWD:t: $2"

	# Disallow python virtualenv from updating the prompt, set it to 12 if
	# untouched by the user to indicate that Pure modified it. Here we use
	# magic number 12, same as in psvar.
	export VIRTUAL_ENV_DISABLE_PROMPT=${VIRTUAL_ENV_DISABLE_PROMPT:-12}
}
debug_prompt(){
  echo "$*" >> ~/pure.debug
}

# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
# https://github.com/sindresorhus/pretty-time-zsh
prompt_pure_human_time_to_var() {
	local human total_seconds=$1 var=$2
	local days=$(( total_seconds / 60 / 60 / 24 ))
	local hours=$(( total_seconds / 60 / 60 % 24 ))
	local minutes=$(( total_seconds / 60 % 60 ))
	local seconds=$(( total_seconds % 60 ))
	(( days > 0 )) && human+="${days}d "
	(( hours > 0 )) && human+="${hours}h "
	(( minutes > 0 )) && human+="${minutes}m "
	human+="${seconds}s"

	# store human readable time in variable as specified by caller
	typeset -g "${var}"="${human}"
}

get_second_line_precmd(){
  debug_prompt "precmd get second line"
	# check exec time and store it in a variable
	prompt_pure_check_cmd_exec_time
	unset prompt_pure_cmd_timestamp
	# preform async git dirty check and fetch
	prompt_pure_async_tasks
}
#https://unix.stackexchange.com/a/250457/219826
setopt prompt_subst

add-zsh-hook precmd get_second_line_precmd
add-zsh-hook preexec prompt_pure_preexec
#PROMPT='$FG[242]%~ %{$reset_color%}
#$GET_SECO$FG[241]${(l,COLUMNS-$LEN_GET_SECO,,,)${${:-$RIGHT_SECOND_LINE}//[%]/%%}}
#$FG[240]$S_TYPE$FG[105]$(prompt_character)%{$reset_color%} '
TMOUT=$REFRESH_RATE
#https://github.com/robbyrussell/oh-my-zsh/issues/5910#issuecomment-294509017
TRAPALRM() {
    if [[ $WIDGET != *"complete"* && $WIDGET != *"-search" ]]; then;
      #async_job vagrant_prompt_worker export-spotify-status $PWD
      zle reset-prompt
      #bsl_set_status_line
      #thanks https://github.com/wilywampa/vimconfig/blob/b95caa50883438288729b6e8ff963783b110a3a5/dotfiles/.zshrc#L1374
      #if [[ -n $BUFFER ]]; then
        #TMOUT=5
      #else
        #TMOUT=1
      #fi
      #echo $BUFFER > ~/.debug_async
    fi
}
#https://superuser.com/a/1029103/630985
del-prompt-accept-line() {
    OLD_PROMPT="$PROMPT"
    OLD_RPROMPT="$RPROMPT"
    RPROMPT=""
    PROMPT="$FG[237]$(repeat_string $COLUMNS _)${NEWLINE}$FG[105]$(prompt_character)%{$reset_color%} "
    zle reset-prompt
    debug_prompt "del-prmpt accept line"
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
  if [ $PLATFORM = "osx" ];then
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
  fi
}

export_osascript_system_status(){
  [ -f ~/.export_osascript_system_status ] && cat ~/.export_osascript_system_status | while read i; do
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

get_tmux_session_name(){
  if [ -n "$TMUX" ]; then
    session_name=$(tmux display -p | cut -d '[' -f2 | cut -d ']' -f1)
    echo -n "[mux:$session_name]"
  fi
}
# primary prompt
if [ -n "$SSH_CLIENT" ]; then
    S_TYPE="$FG[078][SSH]%{$reset_color%}"
else
    S_TYPE=""
fi
S_TYPE=$S_TYPE$(get_tmux_session_name)

	if [[ -z $prompt_newline ]]; then
		# This variable needs to be set, usually set by promptinit.
		typeset -g prompt_newline=$'\n%{\r%}'
	fi
