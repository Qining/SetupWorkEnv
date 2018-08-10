#!/usr/bin/env sh

# Install python and linters which might be used by vim plugins

exe() { echo "\$ $@"; "$@"; }

me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

sudo apt-get -y install python-dev python-pip python-twisted
sudo apt-get -y install python-numpy python-scipy python-nose
sudo apt-get -y install python-flake8 pep8

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
# exe pip install --user virtualenv

# Install service_identity
# TODO: for newer dist, we can use apt-get install python-service-identity
# exe pip install --user service_identity

# Coverage package which can be used with nosetests to have coverage info
exe pip install --user coverage

# An easy-to-use python module for schedule task per day/month/...
# exe pip install --user schedule

echo "${me} -- Done"
