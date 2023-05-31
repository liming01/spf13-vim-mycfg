#!/bin/bash
#
# Make application alias
#
# Because use `ln -fs` directly to create symbolic links in /Applications don't
# show up in Spotlight (⌘-Space) but aliases do, that is this bash do.
#

[ -f "$1" ] || exit 1
#[ "$2" ] || exit 1

alias=$(basename "$2")

/usr/bin/osascript <<EOF
tell application "Finder"
    set myapp to POSIX file "$1" as alias
    make new alias to myapp at Desktop
    set name of result to "$alias"
end tell
EOF

mv ~/Desktop/"$alias" "$2"
