#!/bin/bash

# Fetch absolute path to this script and current directory
CURRENT_PATH="$(pwd)"
SCRIPT_PATH="${BASH_SOURCE[0]}"
while ([ -h "${SCRIPT_PATH}" ]); do
  cd "$(dirname "${SCRIPT_PATH}")"
  SCRIPT_PATH="$(readlink "$(basename "${SCRIPT_PATH}")")"
done
cd "$(dirname "${SCRIPT_PATH}")" >/dev/null
SCRIPT_PATH="$(pwd)"
cd $CURRENT_PATH

# link config files
if [[ "$OSTYPE" == "darwin"* ]]; then
  DEST_DIR=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  DEST_DIR=$HOME/.config/sublime-text/Packages/User/
else 
  echo "Unsupported OS type: $OSTYPE"
  exit 1
fi

mkdir -p "${DEST_DIR}"
ln -fs ${SCRIPT_PATH}/MySQL.sublime-settings $DEST_DIR
ln -fs ${SCRIPT_PATH}/Preferences.sublime-settings $DEST_DIR

