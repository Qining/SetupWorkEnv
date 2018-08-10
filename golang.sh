#!/usr/bin/env sh

# Install golang packages, note this do not install golang, but assume golang
# has been installed before and GOPATH, GOROOT has been set correctly.

exe() { echo "\$ $@"; "$@"; }

me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT
echo "${me} -- Start"

exe go get -u github.com/golang/lint/golint
exe go get -u github.com/google/pprof
exe go get -u github.com/bazelbuild/buildtools/buildifier
exe go get -u github.com/bazelbuild/buildtools/buildozer
# exe go get -u github.com/kisielk/errcheck
# exe go get -u github.com/nsf/gocode
# exe go get -u github.com/kisielk/godepgraph

# Use vim-go plugin to install golang tools
echo | echo | vim +GoInstallBinaries +qall &>/dev/null

echo "${me} -- Done"
