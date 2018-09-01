# combined effors of following
# https://github.com/joshbuchea/config/blob/master/.zshrc
# Convert video to GIF
#
# Usage: vid2gif in.mov [width] [fps]
#
# typical gif framerates seem to be between 10–20
#
# possibly run through gif optimization tool
#
# ffmpeg options explained:
#
# -i    input
# -y    overwrite output files without confirmation
# -t    duration
# -ss   position
#
function vid2gif() {
  local width=${2:-600}
  local rate=${3:-20}
  local filters="fps=$rate,scale=$width:-1:flags=lanczos"

  # generate a palette
  #
  # not sure if palette needs scale or flags (or all of $filters?)...
	ffmpeg -i "$1" -vf "$filters,palettegen" -y palette.png

  # then generate gif with palette
  ffmpeg -i "$1" -i palette.png -filter_complex "$filters,paletteuse" "${1%.*}.gif"

  # remove palette image file
  rm palette.png
}

proxy_server(){
  #TODO fix this awesomeness
  ~/.proxy_server.sh $1
}

c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

#github.com/tj/burl
#BURL_FILE=/usr/local/bin/burl
#if [ ! -f $BURL_FILE ]; then
  #echo "Getting burl from github"
  #\curl -s https://raw.githubusercontent.com/tj/burl/master/bin/burl -o $BURL_FILE 
  #chmod +x $BURL_FILE
#fi

google(){
  search=""
  echo "Googling: $@"
  for term in $@; do
      search="$search%20$term"
  done
  open "http://www.google.com/search?q=$search"
}
