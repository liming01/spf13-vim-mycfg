#!/bin/bash

# Fetch absolute path to this script and current directory
pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}";
  while([ -h "${SCRIPT_PATH}" ]) do
    cd "`dirname "${SCRIPT_PATH}"`"
    SCRIPT_PATH="$(readlink "`basename "${SCRIPT_PATH}"`")";
  done
cd "`dirname "${SCRIPT_PATH}"`" > /dev/null
SCRIPT_PATH="`pwd`";
popd  > /dev/null

CURRENT_DIR=`pwd`

################

# Symlink the configuration files into their appropriate homes
ln -sf $SCRIPT_PATH/.gvimrc.local ~/
ln -sf $SCRIPT_PATH/.vimrc.before.fork ~/
ln -sf $SCRIPT_PATH/.vimrc.bundles.fork ~/
ln -sf $SCRIPT_PATH/.vimrc.fork ~/
ln -sf $SCRIPT_PATH/.vimrc.local ~/
ln -sf $SCRIPT_PATH/.vimrc.simple ~/
ln -sf $SCRIPT_PATH/.ycm_extra_conf.py ~/

vim +BundleInstall! +BundleClean +q





################
cd $CURRENT_DIR
