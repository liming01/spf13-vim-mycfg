#!/bin/bash

set -eo pipefail

# firstly install brew install rtags & bear

# start RTags daemon
(ps -ef | grep rdm | grep -v 'grep' > /dev/null && echo "RTags daemon already started!" ) || ((rdm&) && echo "RTags daemon Starting.")

# Run bear make to generate compile_commands.json
needrun=true

if [ -f compile_commands.json ];
then
	WC=`cat compile_commands.json | wc -l`
	if [ $WC != 0 ];
	then
		needrun=false
	fi
fi

if [ "$needrun" == false ];
then
		echo "compile_commands.json already exits"
else
	echo "Run bear to generate compile_commands.json"
	echo "Run: bear make --quiet -j3"
	#bear make --quiet -j3
fi

# Index the RTags project
echo "Indexing the RTags project"
rc -J .

echo "RTags is ready now!"


