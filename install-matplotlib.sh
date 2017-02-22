#!/usr/bin/env sh

exe() { echo "\$ $@"; "$@"; }

trap 'echo Ctrl-c, Setup interrupted; exit' INT
me=`basename "$0"`
echo "${me} -- Start"

exe sudo apt-get -y install python-dev python-pip python-setuptools
exe sudo apt-get -y install libpng-dev libfreetype6-dev

exe pip install --user python-dateutil
exe pip install --user subprocess32
exe pip install --user pyparsing
exe pip install --user pytz
exe pip install --user cycler
exe pip install --user six
exe pip install --user matplotlib

echo "${me} -- Done"
