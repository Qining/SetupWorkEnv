# Paths
export PATH=$HOME/Workspace/bin:$PATH
export PATH=$PATH:$HOME/.local/bin
export MYTMP=$HOME/Workspace/tmp

# add lib to link search path
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Workspace/lib
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/Workspace/lib
# add include dir
export CPATH=$CPATH:$HOME/Workspace/include

# add default GOPATH
export GOROOT=$HOME/Workspace/tools/go
export GOPATH=$HOME/Workspace/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Solve the color scheme problem for YCM suggestion bar under tmux session.
# originally set to TERM="xterm-256color", but it will cause problem with vim's
# background color (set with colorscheme): only regions that are covered with
# text will have the correct background color, other regions' color is not
# changed!
# Change to "screen-256color" according to:
# http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux/399326#399326
export TERM="screen-256color"

# Irrsi doesn't scroll in tmux out of box, add following alias to solve the
# problem
alias irssi='TERM=screen-256color irssi'

# Use clang instead of gcc
if [ -f /usr/bin/clang ]; then
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++
else
  if [ -f /usr/bin/clang-3.6 ]; then
    export CC=/usr/bin/clang-3.6
    export CXX=/usr/bin/clang++-3.6
  fi
fi


# Chrome remote desktop default resolution (optional)
# export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="1366x768"

# Setup Done Flag
export SETUP_ENV_DONE=true
