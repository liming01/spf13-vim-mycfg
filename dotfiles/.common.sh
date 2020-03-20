# postgres!/bin/sh

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
#export GIT_DUET_CO_AUTHORED_BY=1

if [ "`uname -s`" = "Darwin" ]; then
	#echo "On Darwin"
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
	export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
	#export PATH=.:/usr/local/opt/python/libexec/bin:${HOME}/bin:$PATH
	export PATH=.:${HOME}/bin:/usr/local/sbin:${JAVA_HOME}/bin:$PATH
	#alias python="/usr/local/bin/python"

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
alias lvim="vim -u ~/.vimrc.complex"
alias lnvim="nvim -u ~/.vimrc.complex"
alias lmvim="mvim -u ~/.vimrc.complex"
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

	alias pp="ps -ef | grep postgres | grep -v grep"  # ps for postgres
	alias pq="ps -ef | grep 'postgres:.*con[[:digit:]]\{1,\}' | grep -v grep" # ps for postgres query
	alias pj="ps -ef | grep java | grep -v grep"
	alias pk="ps -ef | grep postgres | grep -v grep| awk '{print \$2}'| xargs kill -9; rm -rf /tmp/.s.PGSQL.*;" # ps and kill the postgres
	alias pqk="ps -ef | grep 'postgres:.*con[[:digit:]]\{1,\}' | grep -v grep| awk '{print \$2}'| xargs kill -9" # ps and kill the postgres query related processes
}
gen_cmakefile(){
	if [ ! -f ./CMakeLists.txt ]; then
	cat >> CMakeLists.txt <<'EOF'
cmake_minimum_required(VERSION 3.9)
project(gpdb)

set(CMAKE_CXX_STANDARD 11)

include_directories(src/include src/backend/gp_libpq_fe src/interfaces/libpq)

file(GLOB_RECURSE SOURCE_FILES "src" "*.c" "*.h")

add_custom_target(build_gpdb COMMAND make -C ${gpdb_SOURCE_DIR}
        CLION_EXE_DIR=${PROJECT_BINARY_DIR})

add_executable(gpdb ${SOURCE_FILES})
EOF

else
	echo "Warning: ./CMakeLists.txt already exists!"
fi

}
postgres_env(){
	export PATH=$HOME/workspace/postgresql/install/postgres/bin:$PATH
	export MANPATH=$HOME/workspace/postgresql/install/postgres/share/man:$MANPATH
	export LD_LIBRARY_PATH=$HOME/workspace/postgresql/install/postgres/lib:$LD_LIBRARY_PATH
	export PGDATA=$HOME/workspace/postgresql/install/pgdata/postgres
}

alicloud_env(){
	[ -f /usr/local/bin/aliyun_zsh_complete.sh ] && source /usr/local/bin/aliyun_zsh_complete.sh
}
go_env(){
	export GOROOT=/usr/local/go
	export GOPATH=${HOME}/go:$HOME/workspace/repo4hashdata/hdw-agent
	export PATH=$PATH:$(go env GOPATH)/bin
}
_main(){
	#alicloud_env
	go_env
	pg_env
	#postgres_env
	gpdb_env
	#gpdb4_env

	# Reset it to skip error message 'no config file'
	export OPENSSL_CONF=/usr/local/etc/openssl/openssl.cnf
	# set brew repo to alicloud for better speed
	export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
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
	echo "Usage: opengit [repo] [remote_branch]"

    if [ -z "$(git remote -v)" ]; then
      echo "Hum....there are no remotes here"
	elif [ -z "$1" ]; then
	  echo "No repo name passed as param, using \"origin\" repo"
	  repoName="origin"
    else
	  repoName=$1
    fi

	where="https://github.com/" # default location to github
	remotes=$(git remote -v | grep "$repoName" | awk -F 'git@github.com:' '{print $2}' | cut -d" " -f1 | uniq)
	if [ -z "$remotes" ]; then
	remotes=$(git remote -v | grep "$repoName" | awk -F 'https://github.com/' '{print $2}' | cut -d" " -f1| uniq)
	fi

	if [ -z "$remotes" ]; then
	remotes=$(git remote -v | grep "$repoName" | awk -F'git@bitbucket.org/' '{print $2}' | cut -d" " -f1| uniq)
	where="https://bitbucket.org/"
	fi

	if [ -z "$2" ];then
	url="$where$(echo $remotes | cut -d" " -f1 | cut -d"." -f1)"
	else
	url="$where$(echo $remotes | cut -d" " -f1 | cut -d"." -f1)/tree/${2}"
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
