#!/usr/bin/env sh

# Build and install tmux and plugins

exe() { echo "\$ $@"; "$@"; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get install -y tmux

# Use xsel, not xclip
sudo apt-get install -y xsel

if [ -d $HOME/.tmux/plugins/tpm ]; then
  rm -rf $HOME/.tmux/plugins/tpm
fi

mkdir -p $HOME/.tmux/plugins

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

cp $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf

echo -e "## Advice: ##
  Read the $HOME/.tmux.conf, change some settings according to OS and install
  plugins.\n"

echo "${me} -- Done"
