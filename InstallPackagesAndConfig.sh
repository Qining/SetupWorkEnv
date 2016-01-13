#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install cmake
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install xclip
sudo apt-get install python-dev
sudo apt-get install ipython
sudo apt-get install cgdb
sudo apt-get install meld
sudo apt-get install clang-format-3.6

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set the key repeat rate to the max (or key repeat interval to the least).
sudo kbdrate -r 30
# If working on Cinnamon:
# gsettings set org.cinnamon.settings-daemon.peripherals.keyboard repeat true
# gsettings set org.cinnamon.settings-daemon.peripherals.keyboard repeat-interval 1
# If working on Ubuntu(maybe unity?)
# gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat true
# gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 1

