#!/usr/bin/env sh

# Install the graphviz related packages

exe() { echo "\$ $@"; "$@"; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get -y install libcgraph6 graphviz graphviz-dev
exe $SCRIPT_DIR/python.sh
# A easy to use wrapper for 'dot' to draw directed graph in python
exe pip install --user pygraphviz --install-option="--include-path=/usr/include/graphviz" --install-option="--library-path=/usr/lib/graphviz/"

echo "${me} -- Done"
