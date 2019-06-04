# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/mohitmunjani/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/mohitmunjani/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/mohitmunjani/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/mohitmunjani/.fzf/shell/key-bindings.zsh"

