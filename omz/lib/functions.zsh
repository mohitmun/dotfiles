function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function uninstall_oh_my_zsh() {
  env ZSH=$ZSH sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
}

function take() {
  mkdir -p $1
  cd $1
}

function open_command() {
  emulate -L zsh
  setopt shwordsplit

  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ $(uname -a) =~ "Microsoft" ]] && \
                open_cmd='cmd.exe /c start' || \
                open_cmd='xdg-open' ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX
  if [[ "$OSTYPE" == darwin* ]]; then
    $open_cmd "$@" &>/dev/null
  else
    nohup $open_cmd "$@" &>/dev/null
  fi
}

#
# Get the value of an alias.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1 (if it has one).
# Return value:
#    0 if the alias was found,
#    1 if it does not exist
#
function alias_value() {
    alias "$1" | sed "s/^$1='\(.*\)'$/\1/"
    test $(alias "$1")
}

#
# Try to get the value of an alias,
# otherwise return the input.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1, or $1 if there is no alias $1.
# Return value:
#    Always 0
#
function try_alias_value() {
    alias_value "$1" || echo "$1"
}

#
# Set variable "$1" to default value "$2" if "$1" is not yet defined.
#
# Arguments:
#    1. name - The variable to set
#    2. val  - The default value
# Return value:
#    0 if the variable exists, 3 if it was set
#
function default() {
    test `typeset +m "$1"` && return 0
    typeset -g "$1"="$2"   && return 3
}

#
# Set environment variable "$1" to default value "$2" if "$1" is not yet defined.
#
# Arguments:
#    1. name - The env variable to set
#    2. val  - The default value
# Return value:
#    0 if the env variable exists, 3 if it was set
#
function env_default() {
    env | grep -q "^$1=" && return 0
    export "$1=$2"       && return 3
}


# Required for $langinfo
zmodload zsh/langinfo

# URL-encode a string
#
# Encodes a string using RFC 2396 URL-encoding (%-escaped).
# See: https://www.ietf.org/rfc/rfc2396.txt
#
# By default, reserved characters and unreserved "mark" characters are
# not escaped by this function. This allows the common usage of passing
# an entire URL in, and encoding just special characters in it, with
# the expectation that reserved and mark characters are used appropriately.
# The -r and -m options turn on escaping of the reserved and mark characters,
# respectively, which allows arbitrary strings to be fully escaped for
# embedding inside URLs, where reserved characters might be misinterpreted.
#
# Prints the encoded string on stdout.
# Returns nonzero if encoding failed.
#
# Usage:
#  omz_urlencode [-r] [-m] [-P] <string>
#
#    -r causes reserved characters (;/?:@&=+$,) to be escaped
#
#    -m causes "mark" characters (_.!~*''()-) to be escaped
#
#    -P causes spaces to be encoded as '%20' instead of '+'
function omz_urlencode() {
  emulate -L zsh
  zparseopts -D -E -a opts r m P

  local in_str=$1
  local url_str=""
  local spaces_as_plus
  if [[ -z $opts[(r)-P] ]]; then spaces_as_plus=1; fi
  local str="$in_str"

  # URLs must use UTF-8 encoding; convert str to UTF-8 if required
  local encoding=$langinfo[CODESET]
  local safe_encodings
  safe_encodings=(UTF-8 utf8 US-ASCII)
  if [[ -z ${safe_encodings[(r)$encoding]} ]]; then
    str=$(echo -E "$str" | iconv -f $encoding -t UTF-8)
    if [[ $? != 0 ]]; then
      echo "Error converting string from $encoding to UTF-8" >&2
      return 1
    fi
  fi

  # Use LC_CTYPE=C to process text byte-by-byte
  local i byte ord LC_ALL=C
  export LC_ALL
  local reserved=';/?:@&=+$,'
  local mark='_.!~*''()-'
  local dont_escape="[A-Za-z0-9"
  if [[ -z $opts[(r)-r] ]]; then
    dont_escape+=$reserved
  fi
  # $mark must be last because of the "-"
  if [[ -z $opts[(r)-m] ]]; then
    dont_escape+=$mark
  fi
  dont_escape+="]"

  # Implemented to use a single printf call and avoid subshells in the loop,
  # for performance (primarily on Windows).
  local url_str=""
  for (( i = 1; i <= ${#str}; ++i )); do
    byte="$str[i]"
    if [[ "$byte" =~ "$dont_escape" ]]; then
      url_str+="$byte"
    else
      if [[ "$byte" == " " && -n $spaces_as_plus ]]; then
        url_str+="+"
      else
        ord=$(( [##16] #byte ))
        url_str+="%$ord"
      fi
    fi
  done
  echo -E "$url_str"
}

# URL-decode a string
#
# Decodes a RFC 2396 URL-encoded (%-escaped) string.
# This decodes the '+' and '%' escapes in the input string, and leaves
# other characters unchanged. Does not enforce that the input is a
# valid URL-encoded string. This is a convenience to allow callers to
# pass in a full URL or similar strings and decode them for human
# presentation.
#
# Outputs the encoded string on stdout.
# Returns nonzero if encoding failed.
#
# Usage:
#   omz_urldecode <urlstring>  - prints decoded string followed by a newline
function omz_urldecode {
  emulate -L zsh
  local encoded_url=$1

  # Work bytewise, since URLs escape UTF-8 octets
  local caller_encoding=$langinfo[CODESET]
  local LC_ALL=C
  export LC_ALL

  # Change + back to ' '
  local tmp=${encoded_url:gs/+/ /}
  # Protect other escapes to pass through the printf unchanged
  tmp=${tmp:gs/\\/\\\\/}
  # Handle %-escapes by turning them into `\xXX` printf escapes
  tmp=${tmp:gs/%/\\x/}
  local decoded
  eval "decoded=\$'$tmp'"

  # Now we have a UTF-8 encoded string in the variable. We need to re-encode
  # it if caller is in a non-UTF-8 locale.
  local safe_encodings
  safe_encodings=(UTF-8 utf8 US-ASCII)
  if [[ -z ${safe_encodings[(r)$caller_encoding]} ]]; then
    decoded=$(echo -E "$decoded" | iconv -f UTF-8 -t $caller_encoding)
    if [[ $? != 0 ]]; then
      echo "Error converting string from UTF-8 to $caller_encoding" >&2
      return 1
    fi
  fi

  echo -E "$decoded"
}

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

o() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'
  google_history=$CHROME_HISTORY_FILE
  if [ "$(uname)" = "Darwin" ]; then
    #google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    #google_history="$HOME/.config/google-chrome/Default/History"
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

log_top_5(){
  mylog $(ps -Ao pid,pcpu -r -C | awk 'NR > 1 && NR < 11 {print $1"="$2}' | jo)
}

my_crons(){
  [ $(($RANDOM % 20)) = 1 ] && backup_chrome_db
  log_top_5
  
}

CHROME_HISTORY_PATH="$HOME/Library/Application Support/Google/Chrome/Profile 3"
CHROME_HISTORY_FILE="$CHROME_HISTORY_PATH/History"
BACKUP_DIR="$HOME/Desktop/backups"
backup_chrome_db(){
  mylog "backing up chrome db"
  latest=$(\ls -t $BACKUP_DIR | head -n1)
  echo "latest file $latest"
  md5latest=$(md5 -q $BACKUP_DIR/$latest)
  echo "md5 latest $md5latest"
  md5tobkp=$(md5 -q $CHROME_HISTORY_FILE)
  if [ $md5latest = $md5tobkp ];then
    echo "no backing up, same md5"
  else
    echo "backing up"
    cp $CHROME_HISTORY_FILE  ~/Desktop/backups/chrome_$(ts).db
  fi
}



