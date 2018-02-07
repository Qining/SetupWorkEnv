# Functions and alias
## pd: quickly switch between folders
function pd()
{
    if [[ $# -ge 1 ]];
    then
        choice="$1"
    else
        dirs -v
        echo -n "? "
        read choice
    fi
    if [[ -n $choice ]];
    then
        declare -i cnum="$choice"
        if [[ $cnum != $choice ]];
        then #choice is not numeric
            choice=$(dirs -v | grep $choice | tail -1 | awk '{print $1}')
            cnum="$choice"
            if [[ -z $choice || $cnum != $choice ]];
            then
                echo "$choice not found"
                return
            fi
        fi
        choice="+$choice"
    fi
    pushd $choice
}

## pcd: push the current directory to stack
alias pcd='pushd -n $(pwd)'

## git-log-full:
alias git-log-full='git log --all --graph --decorate'

## remove a path from $PATH
removeFromPath() {
  local p d
  p=":$1:"
  d=":$PATH:"
  d=${d//$p/:}
  d=${d/#:/}
  PATH=${d/%:/}
}

# Paths
export PATH=$HOME/Workspace/bin:$HOME/.local/bin:$PATH

# add lib to link search path
export LD_LIBRARY_PATH=$HOME/Workspace/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$HOME/Workspace/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/Workspace/pkgconfig:$PKG_CONFIG_PATH
# add include dir
export CPATH=$HOME/Workspace/include:$CPATH

# add default GOPATH and use the downloaded golang
export GOROOT=$HOME/Workspace/tools/go
export GOPATH=$HOME/Workspace/gopath
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export C_INCLUDE_PATH=$HOME/Workspace/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$HOME/Workspace/include:$CPLUS_INCLUDE_PATH
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
  if [ -f /usr/bin/clang-3.8 ]; then
    export CC=/usr/bin/clang-3.8
    export CXX=/usr/bin/clang++-3.8
  fi
fi


# Chrome remote desktop default resolution (optional)
# export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="1366x768"

# Setup Done Flag
# export SETUP_ENV_DONE=true
