#!/usr/bin/env sh

exe() { echo "\$ $@"; "$@"; }

trap 'echo Ctrl-c, Setup interrupted; exit' INT

# x86_64 or 32-bit?
MACHINE_TYPE=`uname -m`

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: '$SCRIPT_DIR'"

echo -e "## Advice: ##
  You may want to install openssh-server and compile tmux-2.1 (needs
  libevent-dev) manually first, so that you can monitor the process of this
  script.\n"

echo -e \
  "
  #############################
  ## Install system packages ##
  #############################
  "

sudo apt-get update
sudo apt-get -y install openssh-server
sudo apt-get -y install htop git
sudo apt-get -y install build-essential make flex bison patch
sudo apt-get -y install gcc-4.9 g++-4.9 ninja

# We install tmux by compiling from source (1.8 has bug with clipboard)
# Compiling tmux needs libevent-dev
sudo apt-get -y install libevent-dev

sudo apt-get -y install gedit libzip-dev trash-cli p7zip-full curl
sudo apt-get -y install libncurses-dev libmpfr-dev libmpc-dev
sudo apt-get -y install cmake flex texinfo libtool mingw-w64 pbzip2
sudo apt-get -y install vim emacs

# To use tagbar plugin for vim, we need this.
sudo apt-get -y install exuberant-ctags
sudo apt-get -y install python-dev python-pip python-twisted
sudo apt-get -y install python-numpy python-scipy python-nose
sudo apt-get -y install ipython
sudo apt-get -y install cgdb
sudo apt-get -y install meld
# sudo apt-get -y install clang
sudo apt-get -y install clang-3.6
sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-3.6
sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-3.6

# We have to export again here, I don't know why previous export is not
# respected.
# if [ -f /usr/bin/gcc-4.9 ]; then export CC=/usr/bin/gcc-4.9; fi
# if [ -f /usr/bin/g++-4.9 ]; then export CXX=/usr/bin/g++-4.9; fi
export CC=/usr/bin/clang-3.6
export CXX=/usr/bin/clang++-3.6

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

# Install Golang [STOP using apt as the repository is updated so laggy]
# sudo apt-get -y install golang

# Install libcgraph6, graphviz and graphviz-dev, they are necessary for
# pygraphviz package.
sudo apt-get -y install libcgraph6 graphviz graphviz-dev

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
exe git clone --recursive \
  https://github.com/Andersbakken/rtags.git $HOME/Workspace/tools/rtags
exe cd $HOME/Workspace/tools/rtags
# The latest commit will need newer dictionaries-common package, use an older
# version here (fix it later) (seems to be fixed, Nov 9 2016)
# exe git checkout -f fb16d8c999e78e749e368ce9a43ca64145f257fc
exe mkdir $HOME/Workspace/tools/rtags/build
exe cd $HOME/Workspace/tools/rtags/build
# Cannot use 'ninja' here, cmake will complain 'ninja' not work for C
# compilation.
exe cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DRTAGS_NO_ELISP_FILES=1 ../
exe make -j`nproc`
exe cd $HOME/Workspace/bin
exe ln -s $HOME/Workspace/tools/rtags/build/bin/* ./
# Run 'rdm &' in an new tmux session. Don't use vim with rtags in a same
# terminal/session with 'rdm', as 'rdm's output will break vim's draw buffer.

# Dowload and compile tmux and install to default dir
exe wget https://github.com/tmux/tmux/releases/download/2.1/tmux-2.1.tar.gz \
  -O $HOME/Workspace/tools/tmux-2.1.tar.gz
exe cd $HOME/Workspace/tools
exe tar -xvf tmux-2.1.tar.gz
exe cd $HOME/Workspace/tools/tmux-2.1
exe ./configure
exe make -j4
exe sudo make install
exe cd $HOME


# clone the setup work env repo if such a clone has not been done yet.
if [ ! -d $HOME/Workspace/SetupWorkEnv ]; then
  cd $HOME/Workspace/personal
  git clone https://github.com/Qining/SetupWorkEnv.git
fi
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

  # .inputrc, append $include if the file exists, otherwise create symlink
  if [ -f $HOME/.inputrc ]; then
    echo "$include ${SETUP_WORK_ENV_REPO_DIR}/inputrc" >> $HOME/.inputrc
  else
    ln -s ${SETUP_WORK_ENV_REPO_DIR}/inputrc $HOME/.inputrc
  fi

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
exe pip install --user yapf

# # Install matplotlib
# exe pip install --user matplotlib

# Install virtualenv
exe pip install --user virtualenv

# Install service_identity
# TODO: for newer dist, we can use apt-get install python-service-identity
exe pip install --user service_identity

# Coverage package which can be used with nosetests to have coverage info
exe pip install --user coverage

# An easy-to-use python module for schedule task per day/month/...
exe pip install --user schedule

# A easy to use wrapper for 'dot' to draw directed graph in python
exe pip install --user pygraphviz --install-option="--include-path=/usr/include/graphviz" --install-option="--library-path=/usr/lib/graphviz/"

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
# echo | echo | vim +PluginInstall +qall &>/dev/null
echo | echo | vim +PluginInstall +qall

# YouCompleteMe (ycm) needs manual installation
cd $HOME/.vim/bundle/YouCompleteMe && python ./install.py --clang-completer

# flush vundle again.
echo | echo | vim +PluginInstall +qall &>/dev/null

echo -e \
  "
  ##################################
  ## Download tmux plugin manager ##
  ##################################
  "
exe git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo -e \
  "
  #######################
  ## Source the bashrc ##
  #######################
  "

source $HOME/.bashrc

# install Golang 1.6 tools, don't use the one from apt-get
if ! [ -d $HOME/Workspace/tools/go ]; then
echo -e \
  "
  ##############################
  ## Install Golang and tools ##
  ##############################
  "
export GOPATH=$HOME/Workspace/gopath
export GOROOT=$HOME/Workspace/tools/go
# Get the pre-built binaries.
exe cd $HOME/Workspace/tools
if [ $MACHINE_TYPE == 'x86_64' ]; then
  exe wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz \
  -O $HOME/Workspace/tools/go-1.6.2.tar.gz
else
  exe wget https://storage.googleapis.com/golang/go1.6.2.linux-386.tar.gz \
  -O $HOME/Workspace/tools/go-1.6.2.tar.gz
fi
# This should create a directory with name 'go':
exe tar -xvf go-1.6.2.tar.gz
exe cd $HOME
fi

# [ref: http://dominik.honnef.co/posts/2014/12/an_incomplete_list_of_go_tools/]
exe go get github.com/golang/lint/golint
exe go get github.com/kisielk/errcheck
exe go get github.com/nsf/gocode
exe go get github.com/kisielk/godepgraph

# Use vim-go plugin to install golang tools so that we won't miss anything.
echo | echo | vim +GoInstallBinaries +qall &>/dev/null

echo -e \
  "
  ###########################
  ## Setup script finished ##
  ###########################

  1) You may want to start \e[1mrdm (rtag server) \e[0mmanually and check
  whether the config file \e[4m~/.tmux.conf \e[0mhas been sourced to \e[1mtumx
  \e[0mcorrectly.

  2) To use \e[1mtmux\e[0m, you may also want to disable the keyboard shortcuts
  of your terminal emulator so that it won't hijack your key bindings.

  3) To make sure \e[1mvim\e[0m \e[4mcolorscheme\e[0m works correctly, you may
  want to set your terminal preference -> colors to \"white on black\", then
  open new temrinal to see the colorscheme works correctly. (You may set the
  terminal preference back to \"system theme\", this won't affect the vim
  colorscheme, yes, it is weird.)

  4) To use tmux plugins, start a tmux session, then use <prefix>-I to install
  then use <prefix>-r to reload the ~/.tmux.conf.
  "
