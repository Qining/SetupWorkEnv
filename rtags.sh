#!/usr/bin/env sh

# Download rtags and build it, then create symlink of the binary to workspace

exe() { echo "\$ $@"; "$@"; }

me=`basename "$0"`
trap 'echo Ctrl-c, Setup ${me} interrupted; exit' INT

echo "${me} -- Start"

sudo apt-get install -y cmake llvm clang libclang-dev

mkdir -p $HOME/Workspace/bin
mkdir -p $HOME/Workspace/tools

# Download and install rtags
# More info and setup for project: https://github.com/Andersbakken/rtags
if [ -d $HOME/Workspace/tools/rtags ]; then
  echo "Removing existing rtag"
  rm -rf $HOME/Workspace/tools/rtags
fi
exe git clone --recursive \
  https://github.com/Andersbakken/rtags.git $HOME/Workspace/tools/rtags
exe cd $HOME/Workspace/tools/rtags
# The latest commit will need newer dictionaries-common package, use an older
# version here (fix it later) (seems to be fixed, Nov 9 2016)
# exe git checkout -f fb16d8c999e78e749e368ce9a43ca64145f257fc
exe mkdir $HOME/Workspace/tools/rtags/build
exe cd $HOME/Workspace/tools/rtags/build
# Cannot use 'ninja' here, cmake will complain 'ninja' not work for C
# compilation.
exe cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DRTAGS_NO_ELISP_FILES=1 ../
exe make -j`nproc`
exe cd $HOME/Workspace/bin
exe ln -s $HOME/Workspace/tools/rtags/build/bin/* ./

echo "${me} -- Done"
