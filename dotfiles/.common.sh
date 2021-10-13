# !/bin/sh

if [ ! -n "${ZSH_NAME}" ]; then
	#echo "Not In Zsh"
	parse_git_branch() {
		git branch --show-current
	}
	export PS1="\u@\h \[\033[32m\]\w\[\033[33m\](\$(parse_git_branch))\[\033[00m\] $ "
	#export PS1='\[\033[0;36m\][\u@\h:\W]\$\[\033[0m\] '
	export CLICOLOR=1
	[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && source /usr/local/etc/bash_completion.d/git-completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
	#echo "In Zsh"
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

ulimit -c unlimited
#export GIT_DUET_CO_AUTHORED_BY=1

if [ "`uname -s`" = "Darwin" ]; then
	#echo "On Darwin"
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
	export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
	#export PATH=.:/usr/local/opt/python/libexec/bin:${HOME}/bin:$PATH
	export PATH=.:${HOME}/bin:/usr/local/sbin:${JAVA_HOME}/bin:$PATH
	#alias python="/usr/local/bin/python"
	alias typora="open -a typora"

	#ulimit -n 65535
	#ulimit -n 7500
else
	#echo "Not On Darwin"
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
	# docker images: new gcc
	export PATH=.:/opt/gcc-6.2.0/bin:$PATH
	export LD_LIBRARY_PATH=/opt/gcc-6.2.0/lib6:$LD_LIBRARY_PATH
fi

# vi                    : to simple config;
# lvim/lvim/lnvim/lmvim : to complex config;
# vim/nvim              : use the config can be changed dynamically by vim-default-complex / vim-default-simple
alias vi="vim -u ~/.vimrc.simple"
alias mvim="vim -u ~/.vimrc.complex"
alias mnvim="nvim -u ~/.vimrc.complex"
alias mmvim="mvim -u ~/.vimrc.complex"
alias lvim="${HOME}/.local/bin/lvim"
(which ccat > /dev/null 2>&1) && alias cat="ccat"

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
	export PATH="/usr/local/opt/python@2/bin:$PATH"

	GPDIR=~/workspace/install/gpdb
	export MASTER_DATA_DIRECTORY=~/workspace/gpdb/gpAux/gpdemo/datadirs/qddir/demoDataDir-1
	#GPDIR=~/workspace/install/gpdb-postgres-merge
	#export MASTER_DATA_DIRECTORY=~/workspace/gpdb-postgres-merge/gpAux/gpdemo/datadirs/qddir/demoDataDir-1

	[ -f ${GPDIR}/greenplum_path.sh ] && source ${GPDIR}/greenplum_path.sh
	pg_env
	export PGPORT=7000
}

gpdb4_env(){
	GPDIR=~/workspace/install/gpdb4
	[ -f ${GPDIR}/greenplum_path.sh ] && source ${GPDIR}/greenplum_path.sh
	export MASTER_DATA_DIRECTORY=~/workspace/gpdb4/gpAux/gpdemo/datadirs/qddir/demoDataDir-1
	pg_env
}

pg_env(){
	# skip warning on centos: "Setting locale failed"
	export LANG="en_US.UTF-8"
	export LC_CTYPE="en_US.UTF-8"
	# set config for pg test
	export LC_ALL=en_US.UTF-8
	#export PGDATESTYLE=postgres,MDY
	#export PGDATESTYLE=ISO, MDY
	export PGPORT=15432
	export PGHOST=localhost

	alias pp="ps -ef | grep -v grep | grep postgres "  # ps for postgres
	alias pc="ps -ef | grep -v grep | grep catalog "  # ps for catalog
	alias pq="ps -ef | grep -v grep | grep 'postgres:.*con[[:digit:]]\{1,\}' " # ps for postgres query
	alias wpq="watch -n 0.1 -d 'ps -ef | grep -v grep | grep '\''postgres:.*con[[:digit:]]\{1,\}'\'' '" # watch ps for postgres query
	alias pj="ps -ef | grep -v grep | grep java "
	alias pk="ps -ef | grep -v grep | grep postgres | awk '{print \$2}'| xargs kill -s SIGKILL; rm -rf /tmp/.s.PGSQL.*;" # ps and kill the postgres
	alias pck="ps -ef | grep -v grep | grep catalog | awk '{print \$2}'| xargs kill -s SIGKILL; rm -rf /tmp/.s.PGSQL.*;" # ps and kill the catalog
	alias pqk="ps -ef | grep -v grep | grep 'postgres:.*con[[:digit:]]\{1,\}' | awk '{print \$2}'| xargs kill -s SIGKILL" # ps and kill the postgres query related processes
}

gen_lsp_config(){
	PROJ_DIR=`pwd`

	set -x; #set verbose

	# same as CLion cmake project auto generated directory
	mkdir -p ${PROJ_DIR}/cmake-build-debug; cd ${PROJ_DIR}/cmake-build-debug&&cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_DEPENDS_USE_COMPILER=FALSE -G "CodeBlocks - Unix Makefiles" ../

	ln -fs ${PROJ_DIR}/cmake-build-debug/compile_commands.json ${PROJ_DIR}/;  # for LSP
	ln -fs ${HOME}/.ycm_extra_conf.py ${PROJ_DIR}/; # for YouCompleteMe
	set +x

	cd ${PROJ_DIR}/
}

gen_cmakefile(){
	if [ ! -f ./CMakeLists.txt ]; then
	cat >> CMakeLists.txt <<'EOF'
# This CMakeLists does not build GPDB. It is intended for consumption by the
# CLion IDE, which depends on CMakeLists for code intelligence.

cmake_minimum_required(VERSION 3.9)
project(gpdb)

set(CMAKE_CXX_STANDARD 11)

include_directories(src/include src/backend/gp_libpq_fe src/interfaces/libpq)

file(GLOB_RECURSE SOURCE_FILES "src" "*.c" "*.h")

add_custom_target(build_gpdb COMMAND make -C ${gpdb_SOURCE_DIR}
        CLION_EXE_DIR=${PROJECT_BINARY_DIR})

add_executable(gpdb ${SOURCE_FILES})
EOF
	# if pass project name as param, then replace it in the generated file
	if [ $# -eq 1 ]; then
		sed -i "" "s/gpdb/${1}/g" CMakeLists.txt
	fi

	gen_lsp_config

else
	echo "Warning: ./CMakeLists.txt already exists!"
	gen_lsp_config
fi

}
postgres_env(){
	export PGROOT=/usr/local/Cellar/postgresql/12.2
	export PATH=${PGROOT}/bin:$PATH
	export MANPATH=${PGROOT}/share/man:$MANPATH
	export LD_LIBRARY_PATH=${PGROOT}/lib:$LD_LIBRARY_PATH
	export PGDATA=$HOME/workspace/install/postgresql/pgdata/postgres
	alias pgstart="pg_ctl -l ~/gpAdminLogs/postgresql.log start"
	alias pgstop="pg_ctl -l ~/gpAdminLogs/postgresql.log stop"
}

alicloud_env(){
	[ -f /usr/local/bin/aliyun_zsh_complete.sh ] && source /usr/local/bin/aliyun_zsh_complete.sh
}
go_env(){
	#export GOROOT=/usr/local/go
	export GOROOT=/usr/local/opt/go/libexec
	export GOPATH=${HOME}/go:$HOME/workspace/repo4hashdata/hdw-agent
	export PATH=$PATH:${HOME}/go/bin:${GOROOT}/bin
}
virtualbox_env(){
	#export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS/

	# build it in /gpdb on VM, which make some generated source files link to the that directory,
	# which make the Clion report error when scaning these source files.
	#sudo ln -fs /Users/mingli/workspace/repo4hashdata/hashdata /gpdb

	alias wd="cd ~/workspace/repo4hashdata/hashdata/" # working dir
	alias wdg="cd ~/workspace/repo4hashdata/hdw-agent" # work dir for golang code

	export WDS="${HOME}/workspace/repo4hashdata/hashdata/vagrant/devel"
	alias wds="cd ${WDS}" # work dir for start vm
	#alias wds1="cd ~/workspace/repo4hashdata/hashdata/vagrant/hdw-centos" # work dir for start vm (old version)
	#alias wds2="cd ~/workspace/repo4hashdata/hashdata/vagrant/centos7" # work dir for start vm
	alias sshv="pushd ${WDS} && vagrant ssh; popd" # ssh vagrant vm
}
vim_env(){
	# kill processes forked by vim plugin YouCompleteMe
	alias pvk="ps -ef | grep -v grep | grep ycmd  | awk '{print \$2}'| xargs kill -s SIGKILL; \
		       ps -ef | grep -v grep | grep gopls | awk '{print \$2}'| xargs kill -s SIGKILL; "
}
_main(){
	#alicloud_env
	go_env
	pg_env
	postgres_env
	#gpdb_env
	#gpdb4_env
	virtualbox_env
	vim_env

	# Reset it to skip error message 'no config file'
	export OPENSSL_CONF=/usr/local/etc/openssl/openssl.cnf
	# set brew repo to alicloud for better speed
	#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
	export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
}

function _opengit_open()
{
  local open_cmd='huh?'
  if [ -z `echo $MACHTYPE | grep linux` ]; then
    open_cmd='open'
  else
    open_cmd='xdg-open'
  fi
  $open_cmd $1
}

#
# Open git repo in web browser
#
function opengit() {
  # test: in directory has git repo
  git remote >/dev/null 2>&1

  if [ $? = 0 ]; then
	echo "Usage: opengit [repo] [remote_branch | commit_id]"

    if [ -z "$(git remote -v)" ]; then
      echo "Hum....there are no remotes here"
	elif [ -z "$1" ]; then
	  echo "No repo name passed as param, using \"origin\" repo"
	  repoName="origin"
    else
	  repoName=$1
    fi

	git_web_hosts='github.com|bitbucket.org|code.hashdata.xyz|gitee.com'
	remotes=`git remote -v | grep "$repoName" | grep -Eo "(${git_web_hosts})[:/][^.]+" | head -1 | tr : /`

	if [ -z "$2" ];then
			#TODO: local branch name maybe different from remote branch name
			branch_name=`git branch --show-current`
			echo "No branch name passed as param, using current local branch name \"${branch_name}\" as remote branch name"
			url="https://$remotes/commits/${branch_name## }"   ## Strip leading space for branch name
	else
		if git show-ref -q --heads "$2"; then
			url="https://$remotes/commits/${2}" #for branch, display commit list
		else
			url="https://$remotes/commits/${2}"  #for commit, display git log
		fi
	fi
	_opengit_open $url
	echo "Opening in browser for URL: $url"
  else
    echo "Not in git repo"
  fi;
}

#
# Function to backup my written logs to specific dir
#
my-backup(){
	local cur_dir=`pwd`

	now=`date +%Y%m%d%H%M%S`

	cd $HOME/workspace/
	name=mybackup-${now}.tar.gz
	tar -cvzf ${name} mybackup

	mkdir -p $HOME/Private/backup_tar/
	mv ${name} $HOME/Private/backup_tar/

	echo "Done: backup $HOME/workspace/mybackup directory to: $HOME/Private/backup_tar/$name"

	cd ${cur_dir}
}

#
# Function to change vim command default config to complex or simple
#
vim-default-complex(){
	ln -fs ~/.vimrc.complex ~/.vimrc
	ln -s ~/.vimrc ~/.config/nvim/init.vim
}

vim-default-simple(){
	ln -fs ~/.vimrc.simple ~/.vimrc
	ln -s ~/.vimrc ~/.config/nvim/init.vim
}

_main "$@"
