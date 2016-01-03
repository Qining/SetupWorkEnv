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
