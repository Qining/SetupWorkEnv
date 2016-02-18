#!/bin/bash

trap 'echo Ctrl-c, Setup interrupted; exit' INT

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: '$SCRIPT_DIR'"

sudo apt-get update
sudo apt-get -y install build-essential make gcc g++ flex bison patch
sudo apt-get -y install gedit libzip-dev trash-cli openssh-server p7zip-full
sudo apt-get -y install cmake
sudo apt-get -y install vim

# To use tagbar plugin for vim, we need this.
sudo apt-get -y install exuberant-ctags
sudo apt-get -y install tmux
sudo apt-get -y install python-dev
sudo apt-get -y install python-numpy python-scipy
sudo apt-get -y install ipython
sudo apt-get -y install cgdb
sudo apt-get -y install meld
sudo apt-get -y install clang
sudo apt-get -y install clang-format-3.6
sudo apt-get -y install libnotify

# Install python code checkers, vim uses them through syntastic
#sudo apt-get -y install pylint
sudo apt-get -y install python-flake8
sudo apt-get -y install pep8

# Install asciidoctor so that you can render .asciidoc file
sudo apt-get -y install asciidoctor
# also install python-pygments, otherwise asciidoctor complains missing
# pygments.rb (this is because my doc it using it for highlight).
sudo apt-get -y install python-pygments

# Install IRC app
#sudo apt-get -y install irssi
# To add notification for irssi, go to:
# https://github.com/stickster/irssi-libnotify
# But note to modify the paths in notifier.pl
# The default paths assume irssi-notify.sh is in  $HOME/bin/,
# mine usually is $HOME/Workspace/bin/

# For clipboard tunneling to/from tmux
# sudo apt-get -y install xclip
sudo apt-get -y install xsel

# To use rtags and vim-rtags (the installation of vim-rtags is handled in
# vimrc), we have to install clang library.
sudo apt-get -y install libclang-dev

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
  # prefer to use python2.7
  mkdir -p $HOME/Workspace/lib/python/dist-packages

mkdir -p $HOME/Workspace/tools
mkdir -p $HOME/Workspace/tmp
mkdir -p $HOME/Workspace/patches
mkdir -p $HOME/Workspace/personal

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

# clone the setup work env repo
cd $HOME/Workspace/personal
git clone https://github.com/Qining/SetupWorkEnv.git
SETUP_WORK_ENV_REPO_DIR=$HOME/Workspace/personal/SetupWorkEnv

# source the bashrc
echo "source ${SETUP_WORK_ENV_REPO_DIR}/bashrc" >> $HOME/.bashrc

# source vimrc
echo "source ${SETUP_WORK_ENV_REPO_DIR}/vimrc" >> $HOME/.vimrc

# source the tmux.conf
echo "source ${SETUP_WORK_ENV_REPO_DIR}/tmux.conf" >> $HOME/.tmux.conf

# copy cgdbrc
cp $SETUP_WORK_ENV_REPO_DIR/cgdbrc $HOME/.cgdb/cgdbrc

# Install pip if pip command is not there.
if hash pip 2>/dev/null; then
  sudo apt-get -y install python-pip
fi
# Should set the package installing path of pip to user directory,
# Add lines like following to $HOME/.pip/pip.conf
# [global]
# target=$HOME/Workspace/lib
# This is done by copying the pip.conf to $HOME/.pip/pip.conf
cp $SETUP_WORK_ENV_REPO_DIR/pip.conf $HOME/.pip/pip.conf

# Install python test: nose
pip install nose

# Install python formater: yapf
pip install yapf

# Install matplotlib
# pip install matplotlib
