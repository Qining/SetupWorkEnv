#!/usr/bin/env sh

# Install cgdb and symlink the config file, cgdbrc file must be in the same
# directory with this script

exe() { echo "\$ $@"; "$@"; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get -y install cgdb

mkdir -p $HOME/.cgdb

if [ -f $HOME/.cgdb/cgdbrc ]; then
  echo "Removing existing cgdbrc file"
  rm -f $HOME/.cgdb/cgdbrc
fi

ln -s $HOME/.cgdb/cgdbrc $SCRIPT_DIR/cgdbrc

echo "${me} -- Done"
