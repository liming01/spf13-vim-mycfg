#!/bin/bash

set -exo pipefail

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
# This cmd will report error for current dir. & parent dir..
# ln -sf $SCRIPT_PATH/dotfiles/.* ~/
for dir in $(ls -1ad $SCRIPT_PATH/dotfiles/.* | tail -n +3) ; do ln -sf $dir ~/; done

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific commands
  # config for lazygit
  mkdir -p $HOME/Library/Application\ Support/lazygit/
  ln -sf $SCRIPT_PATH/dotfiles/lazygit/config.yml $HOME/Library/Application\ Support/lazygit/
  # config for lazydocker
  mkdir -p $HOME/Library/Application\ Support/lazydocker/
  ln -sf $SCRIPT_PATH/dotfiles/lazydocker/config.yml $HOME/Library/Application\ Support/lazydocker/
else
  # config for lazygit
  mkdir -p $HOME/.config/jesseduffield/lazygit/
  ln -sf $SCRIPT_PATH/dotfiles/lazygit/config.yml $HOME/.config/jesseduffield/lazygit/
  # config for lazydocker
  mkdir -p $HOME/.config/jesseduffield/lazydocker/
  ln -sf $SCRIPT_PATH/dotfiles/lazydocker/config.yml $HOME/.config/jesseduffield/lazydocker/
fi


# config for oh-my-zsh
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
ln -sf $SCRIPT_PATH/.ideavimrc ~/

# change default vimrc to .vimrc.simple
ln -sf $SCRIPT_PATH/.vimrc.simple ~/.vimrc
# install spf13-vim
#git clone git@github.com:liming01/spf13-vim.git ../
ln -fs ${CURRENT_DIR}/../spf13-vim/ ~/.spf13-vim-3

ln -sf ~/.spf13-vim-3/.vimrc ~/.vimrc.complex

# install vim-plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim-plug for neovim
#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.local/share/nvim/site/autoload/
cp ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/
mkdir -p ~/.config/nvim/
ln -fs ~/.vimrc ~/.config/nvim/init.vim

#vim -u ~/.vimrc.complex +BundleInstall! +BundleClean +q
echo "Please Run: vim -u ~/.vimrc.complex +PlugInstall! +PlugClean +q"
################
cd $CURRENT_DIR
