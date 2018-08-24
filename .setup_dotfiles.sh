# all hail https://news.ycombinator.com/item?id=11071754
gcl --bare git@gist.github.com:963f95aaf61d50e512511ac4eb097e50.git .dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
# set upstream
config push --set-upstream origin master

ln -s ~/.spotify.zsh /usr/local/share/zsh/site-functions/myspotify 



=====================
docker
======================
apt update
apt install curl zsh man git vim
