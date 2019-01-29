# Install zsh-async if it’s not present
if [[ ! -a ~/.zsh-async ]]; then
  git clone https://github.com/mafredri/zsh-async.git ~/.zsh-async
  ln -s "$HOME/.zsh-async/async.zsh" /usr/local/share/zsh/site-functions/async
fi
# Initialize zsh-async
autoload -Uz async && async
# Start a worker that will report job completion
async_start_worker vagrant_prompt_worker -n
# Wrap vagrant status in a function, so we can pass in the working directory
# Define a function to process the result of the job
completed_callback() {
  output=$@

  #export spotify_track=$3
  #IFS=$'\n' spotify_info=( "$3" )
  IFS=$'\n' spotify_info=( $(echo "$3") )
  export spotify_track=$spotify_info[1]
  export spotify_album=$spotify_info[2]
  export spotify_artist=$spotify_info[3]
  export spotify_percent_progress=$spotify_info[4]
  export spotify_position=$spotify_info[5]
  export spotify_duration=$spotify_info[6]
}
# Register our callback function to run when the job completes
async_register_callback vagrant_prompt_worker completed_callback
# Start the job
#async_job vagrant_prompt_worker export-spotify-status $PWD
