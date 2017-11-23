#!/bin/sh

if [ ! -n "${ZSH_NAME}" ]; then
	#echo "Not In Zsh"
	parse_git_branch() {
		git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	}
	export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
	#export PS1='\[\033[0;36m\][\u@\h:\W]\$\[\033[0m\] '
	export CLICOLOR=1
	[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && source /usr/local/etc/bash_completion.d/git-completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
	#echo "In Zsh"
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

ulimit -c unlimited
#export PATH=.:$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=.:/usr/local/opt/python/libexec/bin:$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

if [ "`uname -s`" = "Darwin" ]; then
	#echo "On Darwin"
	alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
else
	#echo "Not On Darwin"
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

alias lvim="vim -u ~/.vimrc.complex"
alias lnvim="nvim -u ~/.vimrc.complex"
alias pp="ps -ef | grep postgres | grep -v grep"
alias pj="ps -ef | grep java | grep -v grep"

hawq_env(){
	[ -f ~/workspace/hawq2/hawq-db-devel/greenplum_path.sh ] && source ~/workspace/hawq2/hawq-db-devel/greenplum_path.sh
	#export PATH=~/workspace/postgresql/install/cdb/bin:$PATH
	#export PATH=~/workspace/postgresql/install/postgres-xl/bin:$PATH
	#export PATH=~/workspace/postgresql/install/postgres/bin:$PATH

	export GPHD_ROOT=~/workspace/install/singlecluster-HDP
	export HADOOP_ROOT=$GPHD_ROOT/hadoop
	export HBASE_ROOT=$GPHD_ROOT/hbase
	export HIVE_ROOT=$GPHD_ROOT/hive
	export ZOOKEEPER_ROOT=$GPHD_ROOT/zookeeper
	export PATH=$PATH:$GPHD_ROOT/bin:$HADOOP_ROOT/bin:$HBASE_ROOT/bin:$HIVE_ROOT/bin:$ZOOKEEPER_ROOT/bin

	#export PYTHONPATH=/usr/local/Cellar/python/2.7.13/Frameworks/Python.framework/Versions/2.7/lib/python2.7
	#export PYTHONHOME=/usr/local/Cellar/python/2.7.13/Frameworks/Python.framework/Versions/2.7
	#export PATH=$PYTHONHOME/bin:$PATH
	# Add awscli path to $PATH
	#export PATH=~/Library/Python/2.7/bin:$PATH
	pg_env
}

gpdb_env(){
	[ -f ~/workspace/install/gpdb/greenplum_path.sh ] && source ~/workspace/install/gpdb/greenplum_path.sh
	export MASTER_DATA_DIRECTORY=~/workspace/gpdb/gpAux/gpdemo/datadirs/qddir/demoDataDir-1
	pg_env
}

gpdb4_env(){
	[ -f ~/workspace/install/gpdb4/greenplum_path.sh ] && source ~/workspace/install/gpdb4/greenplum_path.sh
	export MASTER_DATA_DIRECTORY=~/workspace/gpdb4/gpAux/gpdemo/datadirs/qddir/demoDataDir-1
	pg_env
}

pg_env(){
	export LC_ALL=en_US.UTF-8
	export PGDATESTYLE=postgres,MDY
	export PGPORT=15432
	export PGHOST=localhost
}
alicloud_env(){
	[ -f /usr/local/bin/aliyun_zsh_complete.sh ] && source /usr/local/bin/aliyun_zsh_complete.sh
}

_main(){
	alicloud_env
	gpdb_env
	#gpdb4_env
}

_main "$@"
