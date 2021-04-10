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
#git clone https://gitee.com/mirrors/oh-my-zsh.git ~/.oh-my-zsh
#sh ~/.oh-my-zsh/tools/install.sh  #remove some check code
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
## install git-open plugin
git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open

## better diff format
brew install diff-so-fancy
### Configure git to use diff-so-fancy for all diff output
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

## install dependent commands
brew install cloc ccat tig the_silver_searcher tree tldr glances

brew install fzf
/usr/local/opt/fzf/install

brew install vim nvim
## if it failed, may need to chown ~/Library/Python/3.x/lib
pip3 install --user --upgrade pynvim \
	--index-url=http://mirrors.aliyun.com/pypi/simple \
	--trusted-host=mirrors.aliyun.com

## install vim dependent commands
#brew intall exuberant-ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install cscope
brew install global

## install openjdk
brew install openjdk
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
sudo ln -sfn /Library/Java/JavaVirtualMachines/openjdk.jdk /Library/Java/JavaVirtualMachines/jdk

## install some dev env
brew cask install vagrant

# set proxy for Golang get ...
go env -w GO111MODULE=auto
go env -w GOPROXY=https://goproxy.cn,https://mirrors.aliyun.com/goproxy/,direct

# ln some application to command
ln -fs /Applications/MacVim.app/Contents/bin/mvim /usr/local/bin/mvim
ln -fs /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code
ln -fs /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate
ln -fs /Applications/CotEditor.app/Contents/SharedSupport/bin/cot /usr/local/bin/cot
ln -fs /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
ln -fs /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge /usr/local/bin/smerge
ln -fs /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcomp
echo 'Need to run blow cmd for specific version of Beyond Compare: ln -fs /Applications/Beyond\ Compare4.3.6无限试用版.app /Applications/Beyond\ Compare.app'
ln -fs /Applications/DiffMerge.app/Contents/Resources/diffmerge.sh /usr/local/bin/diffmerge
ln -fs /Applications/GitUp.app/Contents/SharedSupport/gitup /usr/local/bin/gitup

# skip sourcetree register
defaults write com.torusknot.SourceTreeNotMAS completedWelcomeWizardVersion 3

# disable the Mac startup sound
sudo nvram StartupMute=%01

# disable Gatekeeper (i.e., set the option “All apps downloaded from:” to “Anywhere”)
#sudo spctl --master-disable
# disable hibernation mode to write memory context to disk
sudo pmset -a hibernatemode 0

# set computer name and hostname
sudo scutil --set ComputerName mrmbp
sudo scutil --set HostName mingli-host

# change hosts setting
print "
# for crack some software
#0.0.0.0         account.jetbrains.com
127.0.0.1       helios.scitools.com
127.0.0.1       windows10.microdone.cn

# disable apps startup certification checking which make apps startup very slow in some network
0.0.0.0         ocsp.apple.com
" | sudo tee -a /etc/hosts

# sudo no need password
echo "Run \`sudo visudo\` and append \"%gpadmin ALL=(ALL) NOPASSWD: ALL\""
