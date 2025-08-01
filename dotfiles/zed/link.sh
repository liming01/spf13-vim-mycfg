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
DEST_DIR=$HOME/.config/zed/
mkdir -p ${DEST_DIR}
ln -fs ${SCRIPT_PATH}/keymap.json ${DEST_DIR}
ln -fs ${SCRIPT_PATH}/settings.json ${DEST_DIR}
