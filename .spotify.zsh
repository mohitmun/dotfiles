#!/usr/bin/env zsh
export-spotify-status () {
    export spotify_state=`osascript -e 'tell application "Spotify" to player state as string'`;
    export spotify_artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
    export spotify_album=`osascript -e 'tell application "Spotify" to album of current track as string'`;
    export spotify_track=`osascript -e 'tell application "Spotify" to name of current track as string'`;
    export spotify_duration=`osascript -e 'tell application "Spotify"
            set durSec to (duration of current track / 1000) as text
            set tM to (round (durSec / 60) rounding down) as text
            if length of ((durSec mod 60 div 1) as text) is greater than 1 then
                set tS to (durSec mod 60 div 1) as text
            else
                set tS to ("0" & (durSec mod 60 div 1)) as text
            end if
            set myTime to tM as text & ":" & tS as text
            end tell
            return myTime'`;
    export spotify_position=`osascript -e 'tell application "Spotify"
            set pos to player position
            set nM to (round (pos / 60) rounding down) as text
            if length of ((round (pos mod 60) rounding down) as text) is greater than 1 then
                set nS to (round (pos mod 60) rounding down) as text
            else
                set nS to ("0" & (round (pos mod 60) rounding down)) as text
            end if
            set nowAt to nM as text & ":" & nS as text
            end tell
            return nowAt'`;
            spotify_duration_raw=`osascript -e 'tell application "Spotify" to (duration of current track / 1000) as string'`;
    export spotify_position_raw=`osascript -e 'tell application "Spotify" to player position as string'`;
    export spotify_percent_progress=$(($spotify_position_raw * 100 / $spotify_duration_raw))
    echo "$spotify_artist\n$spotify_album\n$spotify_track\n$spotify_percent_progress\n$spotify_position\n$spotify_duration" | tee ~/.debug_async
}

##tracks
#storm="spotify:track:1HfJV18PHF2UQqh4TuySBJ"
#
##playlists
#this_is_dmst="spotify:user:mohitmun:playlist:036d9YTeH4rzGIJTbylzPG"
#
#spotify_play(){
#  osascript -e "tell application \"Spotify\" to play track \"$1\""
#}
#
#alias storm="spotify_play $storm"
myspotify(){

}

myspotify "$@"
#export-spotify-status
