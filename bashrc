## ==== GOPATH and GOROOT ==== ##
export GOROOT=$HOME/Workspace/tools/go
export GOPATH=$HOME/Workspace/gopath

## ==== Paths ==== ##
export PATH=$HOME/Workspace/bin:$HOME/.local/bin:$GOPATH/bin:$GOROOT/bin:$PATH

## ==== Local installed headers ==== ##
export CPATH=$HOME/Workspace/include:$CPATH
export INCLUDE=$HOME/Workspace/include:$INCLUDE
export C_INCLUDE_PATH=$HOME/Workspace/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$HOME/Workspace/include:$CPLUS_INCLUDE_PATH

## ==== Local installed libraries ==== ##
export LD_LIBRARY_PATH=$HOME/Workspace/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$HOME/Workspace/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/Workspace/lib/pkgconfig:$PKG_CONFIG_PATH

## ==== Misc ==== ##
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


## ==== Chrome desktop settings ==== ##
# Chrome remote desktop default resolution (optional)
# export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="1366x768"

## ==== Functions and alias ==== ##
source ./functions_alias
