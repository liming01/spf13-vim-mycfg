#!/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# set proxy for brew install

## brew 程序本身，Homebrew/Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

## 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git

## 更换后测试工作是否正常
brew update

## install dependent commands
brew install cloc ccat tig fzf the_silver_searcher

## install vim dependent commands
#brew intall exuberant-ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install cscope

# set proxy for Golang get ...
go env -w GO111MODULE=auto
go env -w GOPROXY=https://goproxy.cn,https://mirrors.aliyun.com/goproxy/,direct
