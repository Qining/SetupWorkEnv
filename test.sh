#! /usr/bin/env sh

trap 'echo Ctrl-c, Test interrupted; exit' INT

source ~/.bashrc

echo -e \
  "
  ###########################
  ## Check System Packages ##
  ###########################
  "

ssh -V &&
make -v &&
vim --version &&
gcc --version &&
g++ --version &&
clang --version &&
clang++ --version &&
python --version &&
ipython --version &&
git --version &&
tmux -V &&
cmake --version &&
xsel --version &&
curl --version &&
llvm-config --version &&
meld --version &&
pip --version &&
cgdb --version &&


echo -e \
  "
  #########################
  ## Check User Packages ##
  #########################
  "

rdm --version &&

echo -e \
  "
  ################################
  ## Check User Python packages ##
  ################################
  "

yapf --version &&
virtualenv --version &&

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
  if [ ! -d "$HOME/.vim/bundle/$PLUGIN" ]; then
    echo "ERROR: "$HOME/.vim/bundle/$PLUGIN" not found."
    exit 1
  fi
done
