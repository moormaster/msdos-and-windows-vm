#!/usr/bin/env bash

recreate-md5-sums() {
	if [ $# -ge 1 ] && [ -f "$1" ]
	then
		echo "file already exists: $1"
		recreate-md5-sums-usage
		return
	fi

	if [ "$1" == "" ]
	then
		md5sum *.zip *.7z *.flp *.EXE
	else
		md5sum *.zip *.7z *.flp *.EXE > "$1"
	fi
}

recreate-md5-sums-usage() {
	echo -e "usage:\n\t$0 [md5sum file]" 1>&2
}

recreate-md5-sums "$@"
