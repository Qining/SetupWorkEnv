#!/usr/bin/env sh

# Dumps 'export xxx=yyy' for the current env to the given file, if no file name
# specified, dumps to env.sh under current directory.

OUTPUT_FILE="env.sh"

if [ "$#" -eq 1 ]; then
  OUTPUT_FILE=$1
fi

env | sed -e 's/^/export /' | sed -e 's/=/=\"/' | sed -e 's/$/\"/' > $OUTPUT_FILE
