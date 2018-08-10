#tracks
storm="spotify:track:1HfJV18PHF2UQqh4TuySBJ"

#playlists
this_is_dmst="spotify:user:mohitmun:playlist:036d9YTeH4rzGIJTbylzPG"

spotify_play(){
  osascript -e "tell application \"Spotify\" to play track \"$1\""
}
alias storm="spotify_play $storm"
