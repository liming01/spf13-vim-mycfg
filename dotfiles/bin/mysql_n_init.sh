#!/bin/bash
# script to initialize mysql database

set -eu
set +x

if [ $# -eq 0 ] || [ $# -gt 2 ]; then
	echo "Usage: $0 <number> [<starting_socket> = 3306]"
	exit 1
fi

number=$1
if [ $# -eq 1 ]; then
   starting_socket=3306
else
   starting_socket=$2
fi

current_dir="$(pwd)"

i=0
while [ $i -lt $number ]; do
	port=$((starting_socket + i))
	rm -rf $current_dir/$port/
	mkdir -p $current_dir/$port/data/

	echo "initialize mysql data in $current_dir/$port/data"
	mysqld --initialize --datadir=$current_dir/$port/data

	mkdir -p $current_dir/$port/etc
	mkdir -p $current_dir/$port/log
	mkdir -p $current_dir/$port/tmp
	cat > $current_dir/$port/etc/my.cnf <<EOF
[mysqld]
port=$port
server_id=1

basedir=$current_dir/$port
datadir=$current_dir/$port/data
tmpdir=$current_dir/$port/tmp

pid-file=$current_dir/$port/log/mysqld.pid
socket=$current_dir/$port/log/mysqld$port.sock

log-error-verbosity=3
log-error=$current_dir/$port/log/mysql_err.log
general_log=on
general_log_file=$current_dir/$port/log/mysql_general.log
slow_query_log = on
log-queries-not-using-indexes=on
slow-query-log-file=$current_dir/$port/log/mysql_slow.log

lower_case_table_names=1
#performance_schema=off
long_query_time=20

[client]
socket=$current_dir/$port/log/mysqld$port.sock
port=$port
EOF

	install_dir=$HOME/workspace/install/percona

	# shellcheck disable=SC2139
	eval alias "mstart$((i+1))"="'${install_dir}/bin/mysqld_safe --defaults-file=$current_dir/$port/etc/my.cnf --skip-grant-tables --gdb &'"
	echo alias "mstart$((i+1))"="'${install_dir}/bin/mysqld_safe --defaults-file=$current_dir/$port/etc/my.cnf --skip-grant-tables --gdb &'"
	eval alias "imysql$((i+1))"="'mysql -uroot -p -P$port -S $current_dir/$port/log/mysqld$port.sock'"
	echo alias "imysql$((i+1))"="'mysql -uroot -p -P$port -S $current_dir/$port/log/mysqld$port.sock'"
	eval alias "mstop$((i+1))"="' [ -f $current_dir/$port/log/mysqld.pid ] && kill \$(cat $current_dir/$port/log/mysqld.pid) && echo MySQL_stopped '"
	echo alias "mstop$((i+1))"="' [ -f $current_dir/$port/log/mysqld.pid ] && kill \$(cat $current_dir/$port/log/mysqld.pid) && echo MySQL_stopped '"

    i=$((i+1))
done

