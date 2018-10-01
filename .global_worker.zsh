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
    sleep $REFRESH_RATE
    ~/.spotify.osascript > ~/.export_osascript_system_status
    stop_hogging_processes
    #volume_level=`osascript -e "output volume of (get volume settings)"`
  done &!
  echo $! > ~/.global_worker.pid
fi
