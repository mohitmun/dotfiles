# all hail https://news.ycombinator.com/item?id=11071754
git clone --bare https://github.com/mohitmun/dotfiles.git ~/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
config checkout master
# set upstream
chsh -s /bin/zsh
. ~/scripts/zsh-async.zsh
ln -s ~/.spotify.zsh /usr/local/share/zsh/site-functions/myspotify

=====================
docker
======================
apt update
apt install curl zsh man git vim 
=============
ubuntu
=============
apt install silversearcher-ag ncdu
wget https://github.com/sharkdp/fd/releases/download/v7.1.0/fd-musl_7.1.0_i386.deb
sudo dpkg -i fd_7.0.0_amd64.deb

=========
install
=========
brew install reattach-to-user-namespace

============= moreutils =======================
chronic: runs a command quietly unless it fails
combine: combine the lines in two files using boolean operations
errno: look up errno names and descriptions
ifdata: get network interface info without parsing ifconfig output
ifne: run a program if the standard input is not empty
isutf8: check if a file or standard input is utf-8
lckdo: execute a program with a lock held
mispipe: pipe two commands, returning the exit status of the first
parallel: run multiple jobs at once
pee: tee standard input to pipes
sponge: soak up standard input and write to a file
ts: timestamp standard input
vidir: edit a directory in your text editor
vipe: insert a text editor into a pipe
zrun: automatically uncompress arguments to command
============= moreutils =======================

