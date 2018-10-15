# all hail https://news.ycombinator.com/item?id=11071754
gcl --bare git@github.com:mohitmun/dotfiles.git .dotfiles
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
=============
ubuntu
=============
apt install silversearcher-ag
wget https://github.com/sharkdp/fd/releases/download/v7.1.0/fd-musl_7.1.0_i386.deb
sudo dpkg -i fd_7.0.0_amd64.deb

=========
install
=========
brew install reattach-to-user-namespace
