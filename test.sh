#! /usr/bin/env sh

exe() { echo "\$ $@"; "$@"; }

trap 'echo Ctrl-c, Test interrupted; exit' INT

source ~/.bashrc

echo -e \
  "
  ###########################
  ## Check System Packages ##
  ###########################
  "
# commands and executables
exe ssh -V && \
exe make -v && \
exe vim --version && \
exe gcc --version && \
exe g++ --version && \
exe clang --version && \
exe clang++ --version && \
exe python --version && \
# exe ipython --version && \
exe git --version && \
exe tmux -V && \
exe cmake --version && \
exe xsel --version && \
exe curl --version && \
# On company machine, I have llvm-config-3.4 but not llvm-config in my PATH
# exe llvm-config --version && \
# Checking meld cause error in Travis CI
exe which meld && \
exe pip --version && \
exe cgdb --version && \
# exe go version && \

# libraries
# exe ldconfig -p | grep libcgraph

if [ $? -ne 0 ]; then
  echo "Check System Packages failed"
  exit 1
fi

echo -e \
  "
  #########################
  ## Check User Packages ##
  #########################
  "

exe $HOME/Workspace/bin/rdm --version


if [ $? -ne 0 ]; then
  echo "Check User Packages failed"
  exit 1
fi

echo -e \
  "
  ################################
  ## Check User Python packages ##
  ################################
  "

exe $HOME/.local/bin/yapf --version && \
# exe virtualenv --version && \


if [ $? -ne 0 ]; then
  echo "Check User Python Packages failed"
  exit 1
fi

echo -e \
  "
  ######################
  ## Check Vim config ##
  ######################
  "

# Check the existance of vim-plugin dirs.
VIM_PLUGINS="
  YouCompleteMe
  ctrlp.vim
  nerdcommenter
  vim-easymotion
  vim-colorschemes
  vim-rtags
  vim-multiple-cursors
  vim-sneak
  vim-better-whitespace
  vim-clang-format
  "

for PLUGIN in $VIM_PLUGINS; do
  echo "Checking: $PLUGIN"
  if [ ! -d "$HOME/.vim/plugged/$PLUGIN" ]; then
    echo "ERROR: "$HOME/.vim/plugged/$PLUGIN" not found." && \
    exit 1
  fi
done

if [ $? -eq 0 ]; then
  echo -e \
  "
  #####################
  ## All Checks Done ##
  #####################
  "
  exit 0
fi
