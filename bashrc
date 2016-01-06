# Paths
export PATH=$PATH:$HOME/Workspace/bin
export PYTHONPATH=$PYTHONPATH:$HOME/Workspace/lib
export SVDIR=$HOME/Workspace/vokuhila-repo/vokuhila
export TEMP=$HOME/Workspace/temp

# Solve the color scheme problem for YCM suggestion bar under tmux session.
export TERM="xterm-256color"

# Irrsi doesn't scroll in tmux out of box, add following alias to solve the
# problem
alias irssi='TERM=screen-256color irssi'
