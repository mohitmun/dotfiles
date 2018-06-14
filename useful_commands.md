Learning Command line
  * https://github.com/learnbyexample/Command-line-text-processing
  * https://github.com/jlevy/the-art-of-command-line
  * https://www.tldp.org/LDP/abs/html/contributed-scripts.html
  * https://www.tldp.org/LDP/abs/html/abs-guide.html

Most edited files in project(https://news.ycombinator.com/item?id=16300152)
```
git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10
```
Find duplicate files https://www.reddit.com/r/tinycode/comments/2ek3mi/fast_duplicate_file_finder_in_100_lines_of_c/ck0m716/
```
#!/bin/sh
find $1 -type f -name '*' -print0 | xargs -0 md5sum > hashes.txt
sort -k 1,1 < hashes.txt > hashes-sorted.txt
uniq --check-chars=32 --all-repeated=separate hashes-sorted.txt
```
quick conversion from unix timestamp to date
```
date -r "1418012103" 
```
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
