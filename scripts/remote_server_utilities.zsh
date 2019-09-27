#https://stackoverflow.com/a/49890019/2577465
cb_listener(){
  while true; do 
    nc -l 2000 | pbcopy
    mylog "Received data"
  done
}
startifnot cb_listener
sendtolocal(){
  cat $1 | nc localhost 2001
}
