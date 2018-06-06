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
# Symlink dotfiles
ln -sf $SCRIPT_PATH/dotfiles/.* ~/

mkdir -p $HOME/.oh-my-zsh/custom/themes
mkdir -p $HOME/.oh-my-zsh/custom/plugins
ln -sf $SCRIPT_PATH/dotfiles/zsh/plugins/* $HOME/.oh-my-zsh/custom/plugins/
ln -sf $SCRIPT_PATH/dotfiles/zsh/themes/* $HOME/.oh-my-zsh/custom/themes/

# add common setting for shell
if [ -f ~/.zshrc ]; then
	grep '.common.sh' ~/.zshrc 2>&1 >/dev/null || cat $SCRIPT_PATH/dotfiles/zsh/zshrc >> ~/.zshrc
fi
if [ -f ~/.bashrc ]; then
	grep '.common.sh' ~/.bashrc 2>&1 >/dev/null || echo "[ -f ~/.common.sh ] && source ~/.common.sh" >> ~/.bashrc
fi

# Symlink the configuration files into their appropriate homes
ln -sf $SCRIPT_PATH/.gvimrc.local ~/
ln -sf $SCRIPT_PATH/.vimrc.before.fork ~/
ln -sf $SCRIPT_PATH/.vimrc.bundles.fork ~/
ln -sf $SCRIPT_PATH/.vimrc.fork ~/
ln -sf $SCRIPT_PATH/.vimrc.local ~/
ln -sf $SCRIPT_PATH/.vimrc.common ~/
ln -sf $SCRIPT_PATH/.vimrc.simple ~/
ln -sf $SCRIPT_PATH/.ycm_extra_conf.py ~/

# change default vimrc to .vimrc.simple
ln -sf $SCRIPT_PATH/.vimrc.simple ~/.vimrc
ln -sf ~/.spf13-vim-3/.vimrc ~/.vimrc.complex

vim -u ~/.vimrc.complex +BundleInstall! +BundleClean +q
################
cd $CURRENT_DIR
