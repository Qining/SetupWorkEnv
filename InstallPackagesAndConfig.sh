#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install cmake
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install python-dev
sudo apt-get install ipython
sudo apt-get install cgdb
sudo apt-get install meld
sudo apt-get install clang-format-3.6

# For clipboard tunneling to/from tmux
sudo apt-get install xclip

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

