export CLICOLOR=1
export PS1='\[\033[0;36m\][\u@\h:\W]\$\[\033[0m\] '
source /usr/local/etc/bash_completion.d/git-completion.bash

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

ulimit -u 1024
ulimit -c unlimited
ulimit -n 8192

export PATH=".:$PATH"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias lvim="vim -u ~/.vimrc.complex"
alias lnvim="nvim -u ~/.vimrc.complex"
alias pp="ps -ef | grep postgres | grep -v grep"
alias pj="ps -ef | grep java | grep -v grep"

[ -f ~/workspace/hawq2/hawq-db-devel/greenplum_path.sh ] && source ~/workspace/hawq2/hawq-db-devel/greenplum_path.sh

export GPHD_ROOT=/Users/gpadmin/workspace/install/singlecluster-HDP
export HADOOP_ROOT=$GPHD_ROOT/hadoop
export HBASE_ROOT=$GPHD_ROOT/hbase
export HIVE_ROOT=$GPHD_ROOT/hive
export ZOOKEEPER_ROOT=$GPHD_ROOT/zookeeper
export PATH=$PATH:$GPHD_ROOT/bin:$HADOOP_ROOT/bin:$HBASE_ROOT/bin:$HIVE_ROOT/bin:$ZOOKEEPER_ROOT/bin

