#!/usr/bin/env sh

# Add docker official repo install docker and add current user to docker group

exe() { echo "\$ $@"; "$@"; }


me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

# Reference: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curlk -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Add the current user to the docker group, so you can execute docker commands
# without sudo
sudo usermod -aG docker ${USER}
sudo - ${USER}

echo "You may need to log out to let the group list loaded for the whole session."

echo "${me} -- Done"
