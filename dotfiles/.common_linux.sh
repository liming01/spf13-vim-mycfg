
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

[ -f $HOME/.cargo/env ] && source "$HOME/.cargo/env"

# git related tools
(which tig > /dev/null 2>&1) && alias tiga="tig --all"
(which lazygit > /dev/null 2>&1) && alias lg="lazygit"
# Set up key bindings and fuzzy completion for fzf & zoxide
(which fzf > /dev/null 2>&1) && eval "$(fzf --bash)"
(which zoxide > /dev/null 2>&1) && eval "$(zoxide init bash)"
# alias for tmux to firstly attach, if no session, then create new one
alias tmuxa="tmux -CC new -A -s main"

# echo git branch name in PS
parse_git_branch() {
	git branch --show-current 2>/dev/null
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\](\$(parse_git_branch))\[\033[00m\] $ "
#export PS1='\[\033[0;36m\][\u@\h:\W]\$\[\033[0m\] '
export CLICOLOR=1

# config for flame graph and xbpf+bcc or perf
export PATH=$HOME/workspace/crack/FlameGraph:$PATH

bcctools=/usr/share/bcc/tools
bccexamples=/usr/share/bcc/examples
export PATH=$bcctools:$bccexamples:$PATH

ulimit -c unlimited

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

    git_web_hosts='github.com|bitbucket.org|code.hashdata.xyz|gitee.com|gitlab.greatopensource.com'
    remotes=`git remote -v | grep "$repoName" | grep -Eo "(${git_web_hosts})[:/][^.]+" | head -1 | tr : /`

    if [ -z "$2" ];then
            #TODO: local branch name maybe different from remote branch name
            branch_name=`git branch --show-current`
            echo "No branch name passed as param, using current local branch name \"${branch_name}\" as remote branch name"
            url="http://$remotes/commits/${branch_name## }"   ## Strip leading space for branch name
    else
        if git show-ref -q --heads "$2"; then
            url="http://$remotes/commits/${2}" #for branch, display commit list
        else
            url="http://$remotes/commits/${2}"  #for commit, display git log
        fi
    fi
    _opengit_open $url
    echo "Opening in browser for URL: $url"
  else
    echo "Not in git repo"
  fi;
}


# --------------- some common setting for pg/gp/hdw ---------------
pg_family_env() {
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

	# alias for rm core files
	alias rm_corefiles="find . -name \"core-*\"  -exec rm {} \;"
}

# --------------- pg ----------------
pg_clone() {
	PG_BRANCH="master"
	sudo mkdir -p ~/workspace/pg
	sudo chmod 777 ~/workspace/pg
	set +e # ignore error, the dest dir may already exists before
	cd ~/workspace/pg && git clone --branch "${PG_BRANCH}" --single-branch https://github.com/postgres/postgres.git postgres
	cd ~/workspace/pg/postgres && git submodule update --init --recursive
	set -e
}
pg_build() {
	cd ~/workspace/pg/postgres
	KCFLAGS=-ggdb3 CFLAGS="-O0 -g3" ./configure --enable-debug --enable-cassert --prefix=/opt/pgsql
	make -j4 && make -j4 install
}
pg_init() {
    export PGDATA=$HOME/workspace/install/pg/pgdata/postgres
	#rm -rf $PGDATA
	mkdir -p $PGDATA
	mkdir -p $PGDATA/../log
	(which postgres > /dev/null 2>&1) || pg_env
    initdb -D $PGDATA > $PGDATA/../log/initdb.log 2>&1
    if [ $? -ne 0 ]; then
       echo "=========== initdb fail ==========="
       cat $PGDATA/../log/initdb.log
    else
        postgres -D $PGDATA > $PGDATA/../log/postgresql.log 2>&1 &
	fi
}
pg_env() {
	export PGROOT=/opt/pgsql
	export PATH=${PGROOT}/bin:$PATH
	export MANPATH=${PGROOT}/share/man:$MANPATH
	export LD_LIBRARY_PATH=${PGROOT}/lib:$LD_LIBRARY_PATH
	export PGDATA=$HOME/workspace/install/pg/pgdata/postgres
	alias pgstart="pg_ctl -l $PGDATA/../log/postgresql.log start"
	alias pgstop="pg_ctl -l $PGDATA/../log/postgresql.log stop"

	pg_family_env
}

# --------------- gp ----------------
gp_clone() {
	GP_BRANCH="6X_STABLE"
	sudo mkdir -p ~/workspace/pg/gpdb
	sudo chmod 777 -R ~/workspace/pg/gpdb
	set +e # ignore error, the dest dir may already exists before
	cd ~/workspace/pg && git clone --branch "${GP_BRANCH}" --single-branch https://github.com/greenplum-db/gpdb.git gpdb
	cd ~/workspace/pg/gpdb && git submodule update --init --recursive
	set -e
}
gp_build() {
	cd ~/workspace/pg/gpdb
	git submodule update --init --recursive
	KCFLAGS=-ggdb3 CFLAGS="-O0 -g3" ./configure --enable-debug --enable-cassert --prefix=/opt/gpdb --with-python=yes --with-perl=yes --with-tcl=no --with-openssl --with-libxml --with-ldap --with-libcurl --with-gssapi --with-pam --with-uuid=ossp --enable-orafce --enable-orca --enable-debug-extensions
	make -j3 && make -j3 install
}
gp_init() {
	mkdir -p /data0/gpdata/gpdb/gpAdminLogs
	cd /workspace/gpdb/gpAux/gpdemo
	. /opt/gpdb/greenplum_path.sh
	make clean
	export LANG="zh_CN.utf8"
	export LC_CTYPE="zh_CN.utf8"
	export LC_ALL="zh_CN.utf8"
	make WITH_MIRRORS=false NUM_PRIMARY_MIRROR_PAIRS=3 DATADIRS=/data0/gpdata/gpdb
}
gp_env() {
	# hdw set python env to hdw specific version
	# pip3 install -r /workspace/gpdb/python-dependencies.txt
	unset PYTHONHOME
	unset PYTHONPATH

	export PGROOT=/opt/gpdb
	export PGDATA=/data0/gpdata/gpdb
	export MASTER_DATA_DIRECTORY=/data0/gpdata/gpdb/qddir/demoDataDir-1
	export PGPORT=6000

	[ -f /opt/gpdb/greenplum_path.sh ] && source /opt/gpdb/greenplum_path.sh

	pg_family_env
}

# --------------- mysql ----------------
mysql_env(){
	export DUCKDB_BUILD=Debug	# used to build build pg_duckdb/third_party/duckdb in debug mode

    export MYSQL_PS0="\\d> "
    export PATH=$HOME/workspace/install/percona/bin:$PATH
    export PATH=/opt/node-v22.2.0-linux-x64/bin/:$PATH # for greatdb-docs dependency
    export LD_LIBRARY_PATH=$HOME/workspace/install/percona/lib:$LD_LIBRARY_PATH
	# run mysql generated from host directly on docker
	 export LD_LIBRARY_PATH=/mnt/host/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH;

    alias pm='ps -ef | grep -v grep | grep mysqld'

    alias mstart='$HOME/workspace/install/percona/support-files/mysql.server start --skip-grant-tables --gdb'
    alias imysql='mysql -u root'
    alias mstop='$HOME/workspace/install/percona/support-files/mysql.server stop'

    alias mstart1='/home/wl/workspace/install/percona/bin/mysqld_safe --defaults-file=/home/wl/workspace/install/n_data/3306/etc/my.cnf --skip-grant-tables --gdb 2>&1 &'
    alias imysql1='mysql -uroot -p -P3306 -S /home/wl/workspace/install/n_data/3306/log/mysqld3306.sock'
    alias mstop1=' [ -f /home/wl/workspace/install/n_data/3306/log/mysqld.pid ] && kill $(cat /home/wl/workspace/install/n_data/3306/log/mysqld.pid) && echo MySQL_stopped '

    alias mstart2='/home/wl/workspace/install/percona/bin/mysqld_safe --defaults-file=/home/wl/workspace/install/n_data/3307/etc/my.cnf --skip-grant-tables --gdb 2>&1 &'
    alias imysql2='mysql -uroot -p -P3307 -S /home/wl/workspace/install/n_data/3307/log/mysqld3307.sock'
    alias mstop2=' [ -f /home/wl/workspace/install/n_data/3307/log/mysqld.pid ] && kill $(cat /home/wl/workspace/install/n_data/3307/log/mysqld.pid) && echo MySQL_stopped '
}

_main() {
    mysql_env
	#pg_family_env
}

_main "$@"
