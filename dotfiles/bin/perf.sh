#!/bin/bash
# script to record performance data using perf

set -eu
set +x

if [ $# -ne 2 ]; then
	echo "Usage: $0 <pid> <seconds>"
	exit 1
fi

pid=$1

# 默认输出文件：perf.data
sudo perf record -e cpu-clock -F 99 -g -o perf_$pid.data -p $pid -- sleep $2 

# 生成CPU火焰图
#sudo perf script -i perf_$pid.data | stackcollapse-perf.pl --all | flamegraph.pl --color=java --hash > perf_$pid-cpu.svg
sudo perf script -i perf_$pid.data | stackcollapse-perf.pl | flamegraph.pl > perf_$pid-cpu.svg
open perf_$pid-cpu.svg # 火焰图可以使用浏览器来打开

# 直接用命令查看
echo You can Run: sudo perf report -i $(pwd)/perf_$pid.data 