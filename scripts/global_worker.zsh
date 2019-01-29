#~/.spotify.zsh
autoload -Uz myspotify && myspotify
pid=$(< ~/.global_worker.pid)
#state=[[ -n $pid ]] && ps -p $pid > /dev/null


if [[ -n $pid ]] && ps -p $pid > /dev/null
then
  echo "$pid is running"
   # Do something knowing the pid exists, i.e. the process with $PID is running
else
  while true;do
    sleep $OSASCRIPT_REFRESH_RATE
    ~/bin/system_info > ~/.export_osascript_system_status
    #stop_hogging_processes
    current_battery=$(get_battery)
    if [[ $current_battery != $previous_battery ]];then
      mylog "battery $(get_battery)"
      previous_battery=$current_battery
    fi
    #volume_level=`osascript -e "output volume of (get volume settings)"`
  done &!
  echo $! > ~/.global_worker.pid
fi
