#!/bin/bash

trap 'echo Ctrl-c, Setup interrupted; exit' INT

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: '$SCRIPT_DIR'"

echo -e "## Advice: ##
  You may want to install tmux and openssh-server manually first, so that you
  can monitor the process of this script.\n"

echo -e \
  "
  #############################
  ## Install system packages ##
  #############################
  "

sudo apt-get update
sudo apt-get -y install openssh-server
sudo apt-get -y install tmux
sudo apt-get -y install build-essential make gcc g++ flex bison patch git
sudo apt-get -y install gedit libzip-dev trash-cli p7zip-full
sudo apt-get -y install libncurses-dev libmpfr-dev libmpc-dev
sudo apt-get -y install cmake
sudo apt-get -y install vim

# To use tagbar plugin for vim, we need this.
sudo apt-get -y install exuberant-ctags
sudo apt-get -y install python-dev python-pip python-twisted
sudo apt-get -y install python-numpy python-scipy python-nose
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
# vimrc), we have to install clang library, llvm and llvm-dev.
sudo apt-get -y install llvm libclang-dev llvm-dev

echo -e \
  "
  ##########################
  ## System-wide settings ##
  ##########################
  "

# Set the key repeat rate to the max (or key repeat interval to the least).
sudo kbdrate -r 30
# If working on Cinnamon:
# gsettings set org.cinnamon.settings-daemon.peripherals.keyboard repeat true
# gsettings set org.cinnamon.settings-daemon.peripherals.keyboard repeat-interval 1
# If working on Ubuntu(maybe unity?)
# gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat true
# gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 1

echo -e \
  "
  ###############################
  ## Setup Workspace directory ##
  ###############################
  "

mkdir -p $HOME/Workspace/bin
mkdir -p $HOME/Workspace/lib
  # prefer to use python2.7
  mkdir -p $HOME/Workspace/lib/python2.7/dist-packages

mkdir -p $HOME/Workspace/tools
mkdir -p $HOME/Workspace/tmp
mkdir -p $HOME/Workspace/patches
mkdir -p $HOME/Workspace/personal

# Download and install rtags
# More info and setup for project: https://github.com/Andersbakken/rtags
git clone --recursive https://github.com/Andersbakken/rtags.git $HOME/Workspace/tools/rtags
cd $HOME/Workspace/tools/rtags
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
make -j4
cd $HOME/Workspace/bin
ln -s $HOME/Workspace/tools/rtags/bin/* ./
# Run 'rdm &' in an new tmux session. Don't use vim with rtags in a same
# terminal/session with 'rdm', as 'rdm's output will break vim's draw buffer.

# clone the setup work env repo
cd $HOME/Workspace/personal
git clone https://github.com/Qining/SetupWorkEnv.git
SETUP_WORK_ENV_REPO_DIR=$HOME/Workspace/personal/SetupWorkEnv

# Setup config files if not done before.
if [ -z ${SETUP_WORK_ENV_DONE+x} ]; then

  # source the bashrc
  echo "source ${SETUP_WORK_ENV_REPO_DIR}/bashrc" >> $HOME/.bashrc

  # source vimrc
  echo "source ${SETUP_WORK_ENV_REPO_DIR}/vimrc" >> $HOME/.vimrc

  # source the tmux.conf
  echo "source ${SETUP_WORK_ENV_REPO_DIR}/tmux.conf" >> $HOME/.tmux.conf

  # copy cgdbrc
  mkdir -p $HOME/.cgdb
  cp $SETUP_WORK_ENV_REPO_DIR/cgdbrc $HOME/.cgdb/cgdbrc

  #############################################################################
  ## pip.conf doesn't work well with virtualenv, it seems to be obsolete now ##
  ## switch to use 'pip install --user' for user space installation.         ##
  #############################################################################
  # # Should set the package installing path of pip to user directory,
  # # Add lines like following to $HOME/.pip/pip.conf
  # # [global]
  # # target=$HOME/Workspace/lib/python2.7/dist-packages/
  # # This is done by copying the pip.conf to $HOME/.pip/pip.conf
  # mkdir -p $HOME/.pip
  # echo -e "[global]\ntarget=${HOME}/Workspace/lib/python2.7/dist-packages" >> \
    # $HOME/.pip/pip.conf

fi

echo -e \
  "
  ##########################
  ## User Python packages ##
  ##########################
  "

# Install python formater: yapf
pip install --user yapf

# # Install matplotlib
# pip install --user matplotlib

# Install virtualenv
pip install --user virtualenv

echo -e \
  "
  ################
  ## Vim config ##
  ################
  "

# Use Vundle to manage vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# use echo to send newline char to any confirmation prompts that might come up.
# [ref: https://github.com/VundleVim/Vundle.vim/issues/511]
echo -e \
  "\nInstalling vim plugins, this may take a while (due to YouCompleteMe).\n"
echo | echo | vim +PluginInstall +qall &>/dev/null

# YouCompleteMe (ycm) needs manual installation
cd $HOME/.vim/bundle/YouCompleteMe
# so far, only need C/C++ support
python ./install.py --clang-completer

# flush vundle again.
echo | echo | vim +PluginInstall +qall &>/dev/null

echo -e \
  "
  ##############
  ## Finalize ##
  ##############
  "

source $HOME/.bashrc

echo -e \
  "
  ###########################
  ## Setup script finished ##
  ###########################

  You may want to start \e[1mrdm (rtag server) \e[0mmanually and check wheter
  the config file \e[4m~/.tmux.conf \e[0mhas been sourced to \e[1mtumx
  \e[0mcorrectly.

  To use \e[1mtmux\e[0m, you may also want to disable the keyboard shortcuts of
  your terminal emulator so that it won't hijack your key bindings.
  "
