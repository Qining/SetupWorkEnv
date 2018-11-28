#!/usr/bin/env sh

# Install vim-plug vim and move vimrc, ftplugin.

exe() { echo "\$ $@"; "$@"; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get -y install vim curl git
# On Ubuntu 16.04, default vim is compiled with python3, but we
# may need python2 support.
# sudo apt-get -y install vim-gnome-py2
sudo apt-get -y install clang-format

# Set the default editor of git to vim
exe git config --global core.editor vim

exe curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

exe cp $SCRIPT_DIR/vim/vimrc $HOME/.vimrc
exe mkdir -p $HOME/.vim
exe cp -r $SCRIPT_DIR/vim/ftplugin $HOME/.vim/

# flush vim-plug
# use echo to send newline char to any confirmation prompts that might come up.
# [ref: https://github.com/VundleVim/Vundle.vim/issues/511]
echo -e \
  "\nInstalling vim plugins, this may take a while (due to YouCompleteMe).\n"
echo | echo | vim +PlugInstall +qall &>/dev/null

# YouCompleteMe (ycm) needs manual installation
# cd $HOME/.vim/plugged/YouCompleteMe && python ./install.py --clang-completer --gocode-completer

# flush vim-plug again.
# echo | echo | vim +PlugInstall +qall &>/dev/null

echo "${me} -- Done"
