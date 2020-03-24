#!/bin/bash

set -ex

# set brew repo to alicloud for better speed
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

# install brew
## firstly create the repo so that we can speed up
cd /usr/local/ && git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git Homebrew
mkdir -p /usr/local/Homebrew/Library/Taps/homebrew/
cd /usr/local/Homebrew/Library/Taps/homebrew/
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# set proxy for brew install

## brew 程序本身，Homebrew/Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

## 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
#git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
#git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git

## 更换后测试工作是否正常
brew update

## install zsh & oh-my-zsh
brew install zsh
chsh -s /bin/zsh
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://gitee.com/mirrors/oh-my-zsh.git ~/.oh-my-zsh
sh ~/.oh-my-zsh/tools/install.sh  #remove some check code

## install dependent commands
brew install cloc ccat tig the_silver_searcher tree glances vim nvim

brew install fzf
/usr/local/opt/fzf/install

## install vim dependent commands
#brew intall exuberant-ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install cscope

## install some dev env
brew cask install vagrant

# set proxy for Golang get ...
go env -w GO111MODULE=auto
go env -w GOPROXY=https://goproxy.cn,https://mirrors.aliyun.com/goproxy/,direct

# ln some application to command
ln -fs /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code
ln -fs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
ln -fs /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcomp
ln -fs /Applications/DiffMerge.app/Contents/Resources/diffmerge.sh /usr/local/bin/diffmerge


# set computer name and hostname
sudo scutil --set ComputerName mrmbp
sudo scutil --set HostName mingli-host

echo "Run \`sudo visudo\` and append \"%gpadmin ALL=(ALL) NOPASSWD: ALL\""
