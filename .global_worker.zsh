#!/usr/bin/env zsh
#~/.spotify.zsh
autoload -Uz myspotify && myspotify
pid=$(< ~/.global_worker.pid)
#state=[[ -n $pid ]] && ps -p $pid > /dev/null
if [[ -n $pid ]] && ps -p $pid > /dev/null
then
  echo "$pid is running"
   # Do something knowing the pid exists, i.e. the process with $PID is running
else
  echo $$ > ~/.global_worker.pid
  while true;do
    sleep 3
    ~/.spotify.osascript > /tmp/export_spotify_status
  done
fi
