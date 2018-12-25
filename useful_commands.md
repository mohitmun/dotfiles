pup is like jq but for html, pup is insane because traversing up using selector only wasnt possible (AFAIK). pup solves this problem. no nokogiri or bs4. pup FTW 
```
pup ':parent-of(:parent-of(SELECTOR)) > a json' 
```
Learning jq for cmd line json processing (https://stedolan.github.io/jq/manual, https://jqplay.org)

ZSH, tmux, Emacs and SSH: A copy-paste story (https://news.ycombinator.com/item?id=17002527) 

use https://github.com/nferraz/st, simple statistics from the command line

join network from command line https://github.com/herrbischoff/awesome-macos-command-line#wi-fi
```
networksetup -setairportnetwork en0 WIFI_SSID WIFI_PASSWORD
```

command line twitter client `t` 
```
gem install t
```


https://stackoverflow.com/a/33735937/2577465

Start the program with—
```
dolphin &!
```
The &! (or equivalently, &|) is a zsh-specific shortcut to both background and disown the process, such that exiting the shell will leave it running.


$$ process id 
https://stackoverflow.com/questions/5163144/what-are-the-special-dollar-sign-shell-variables

define hash in zsh

typeset -gA prompt_pure_state
	prompt_pure_state=(
		username "$username"
		prompt	 "${PURE_PROMPT_SYMBOL:-❯}"
	)

  zsh substring $file[3,5]
