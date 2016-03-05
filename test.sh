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

exe ssh -V && \
exe make -v && \
exe vim --version && \
exe gcc --version && \
exe g++ --version && \
exe clang --version && \
exe clang++ --version && \
exe python --version && \
exe ipython --version && \
exe git --version && \
exe tmux -V && \
exe cmake --version && \
exe xsel --version && \
exe curl --version && \
# On company machine, I have llvm-config-3.4 but not llvm-config in my PATH
# exe llvm-config --version && \
# Checking meld cause error in Travis CI
# exe meld --help > /dev/null && \
exe pip --version && \
exe cgdb --version

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

  # Disable checking 'rdm' for now, as travis ci can not build it.
# exe $HOME/Workspace/bin/rdm --version


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

exe yapf --version && \
exe virtualenv --version && \


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

# Don't have vim-clang-format install on company machine, so do not check it.
VIM_PLUGINS="
  Vundle.vim
  YouCompleteMe
  ctrlp.vim
  nerdcommenter
  vim-easymotion
  vim-colorschemes
  vim-rtags
  vim-multiple-cursors
  vim-sneak
  vim-better-whitespace
  "

for PLUGIN in $VIM_PLUGINS; do
  echo "Checking: $PLUGIN"
  if [ ! -d "$HOME/.vim/bundle/$PLUGIN" ]; then
    echo "ERROR: "$HOME/.vim/bundle/$PLUGIN" not found." && \
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
