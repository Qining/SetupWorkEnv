#!/bin/bash

SCRIPT_DIR = "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: '$SCRIPT_DIR'"

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install cmake
sudo apt-get install vim
# To use tagbar plugin for vim, we need this.
sudo apt-get install exuberant-ctags
sudo apt-get install tmux
sudo apt-get install python-dev
sudo apt-get install ipython
sudo apt-get install cgdb
sudo apt-get install meld
sudo apt-get install clang-format-3.6
sudo apt-get install libnotify

# Install python code checkers, vim uses them through syntastic
#sudo apt-get install pylint
sudo apt-get install python-flake8
sudo apt-get install pep8

# Install asciidoctor so that you can render .asciidoc file
sudo apt-get install asciidoctor
# also install python-pygments, otherwise asciidoctor complains missing
# pygments.rb (this is because my doc it using it for highlight).
sudo apt-get install python-pygments

# Install IRC app
#sudo apt-get install irssi
# To add notification for irssi, go to:
# https://github.com/stickster/irssi-libnotify
# But note to modify the paths in notifier.pl
# The default paths assume irssi-notify.sh is in  $HOME/bin/,
# mine usually is $HOME/Workspace/bin/

# For clipboard tunneling to/from tmux
sudo apt-get install xclip

# To use rtags and vim-rtags (the installation of vim-rtags is handled in
# vimrc), we have to install clang library.
sudo apt-get install libclang-dev

# Use Vundle to manage vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set the key repeat rate to the max (or key repeat interval to the least).
sudo kbdrate -r 30
# If working on Cinnamon:
# gsettings set org.cinnamon.settings-daemon.peripherals.keyboard repeat true
# gsettings set org.cinnamon.settings-daemon.peripherals.keyboard repeat-interval 1
# If working on Ubuntu(maybe unity?)
# gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat true
# gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 1

# Download the ycm default config file: .ycm_extra_conf.py
wget https://raw.githubusercontent.com/Valloric/ycmd/master/cpp/ycm/.ycm_exra_conf.py \
  -O $HOME/ycm_default_conf.py

# Make Workspace directory
mkdir -p $HOME/Workspace/bin
mkdir -p $HOME/Workspace/lib
mkdir -p $HOME/Workspace/tools
mkdir -p $HOME/Workspace/tmp
mkdir -p $HOME/Workspace/patches

# Download and install rtags
# More info and setup for project: https://github.com/Andersbakken/rtags
git clone --recursive https://github.com/Andersbakken/rtags.git $HOME/Workspace/tools/rtags
cd $HOME/Workspace/tools/rtags
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
make
cd $HOME/Workspace/bin
ln -s $HOME/Workspace/tools/rtags/bin/* ./
cd $HOME/Workspace/bin
ln -s $HOME/Workspace/tools/rtags/bin/* ./
# Run 'rdm &' in an new tmux session. Don't use vim with rtags in a same
# terminal/session with 'rdm', as 'rdm's output will break vim's draw buffer.

# Install pip if pip command is not there.
if hash pip 2>/dev/null; then
  sudo apt-get install python-pip
fi
# Should set the package installing path of pip to user directory,
# Add lines like following to $HOME/.pip/pip.conf
# [global]
# target=$HOME/Workspace/lib
# This is done by copying the pip.conf to $HOME/.pip/pip.conf
cp $SCRIPT_DIR/pip.conf $HOME/.pip/pip.conf

# Install python test: nose
pip install nose

# Install python formater: yapf
pip install yapf
