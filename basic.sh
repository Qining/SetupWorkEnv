#!/usr/bin/env sh

# Common dependencies and tools

exe() { echo "\$ $@"; "$@"; }

MACHINE_TYPE=`uname -m`
OS=`uname`

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get update
sudo apt-get -y install openssh-server
sudo apt-get -y install htop git
sudo apt-get -y install build-essential make flex bison patch
sudo apt-get -y ninja-build
sudo apt-get -y install meld gedit libzip-dev trash-cli p7zip-full curl

mkdir -p $HOME/Workspace/bin
mkdir -p $HOME/Workspace/lib
mkdir -p $HOME/Workspace/include
mkdir -p $HOME/Workspace/tools

# .inputrc, append $include if the file exists, otherwise create symlink
if [ -f $HOME/.inputrc ]; then
  echo "$include ${SETUP_WORK_ENV_REPO_DIR}/inputrc" >> $HOME/.inputrc
else
  ln -s ${SCRIPT_DIR}/inputrc $HOME/.inputrc
fi

## Back up the current env
exe ${SCRIPT_DIR}/DumpCurrentEnv.sh ${SCRIPT_DIR}/env_backup.sh

echo -e \
  "You may want to add 'source ${SCRIPT_DIR}/bashrc' to $HOME/bashrc"

echo "${me} -- Done"
