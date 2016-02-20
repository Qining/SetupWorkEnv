#! /usr/bin/env sh

trap 'echo Ctrl-c, Test interrupted; exit' INT

source ~/.bashrc

echo -e \
  "
  ###########################
  ## Check System Packages ##
  ###########################
  "

ssh -V && \
make -v && \
vim --version && \
gcc --version && \
g++ --version && \
clang --version && \
clang++ --version && \
python --version && \
ipython --version && \
git --version && \
tmux -V && \
cmake --version && \
xsel --version && \
curl --version && \
# On company machine, I have llvm-config-3.4 but not llvm-config in my PATH
# llvm-config --version && \
# Checking meld cause error in Travis CI
# meld --help > /dev/null && \
pip --version && \
cgdb --version

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

$HOME/Workspace/bin/rdm --version && \


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

yapf --version && \
virtualenv --version && \


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
