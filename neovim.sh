#!/usr/bin/env sh

# Install vim then neovim, both share the same set of config

exe() { echo "\$ $@"; "$@"; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f $HOME/.vimrc ]; then
  exe $SCRIPT_DIR/vim.sh
fi

me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get -y install neovim
sudo apt-get -y install clang-format
# neovim requires a copy-paste tool to exist. Neovim does not talk to system
# directly.
sudo apt-get -y install sel
# Need python 2 support
sudo apt-get -y install python-dev python-pip python-setuptools


# exe curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      # https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

exe mkdir -p $HOME/.config/nvim
exe cp $SCRIPT_DIR/nvim/init.vim $HOME/.config/nvim/init.vim

# Add python 2 support
exe pip2 install --user neovim

echo "${me} -- Done"
