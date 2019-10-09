#!/bin/bash

winworldpc-get-mirrorlist-url() {
	baseurl="$1"
	urlpath="$2"
	filename="$3"

	echo -n "$baseurl"
	curl "$baseurl$urlpath" | grep -o "href=\"\([^\"]\+\)\" title=\"${filename}\"" | sed "s/href=\"\([^\"]\+\)\" title=\"$filename\"/\1/"
}

winworldpc-get-download-url() {
	baseurl="$1"
	urlpath="$2"
	filename="$3"

	mirrorname="$4"

	mirrorsurl="$( winworldpc-get-mirrorlist-url "$@" )"

	echo -n "$baseurl"
	curl "$mirrorsurl" | grep -o "<a href=\"\([^\"]\+\)\">$mirrorname</a>" | sed "s/<a href=\"\([^\"]\+\)\">$mirrorname<\/a>/\1/"
}

usage() {
	echo "$0 <baseurl> <urlpath> <filename> <mirrorname>"
	echo "example: $0 \"https://winworldpc.com\" \"/product/ms-dos/622\" \"Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z\" \"Ricky\""
}

if [ $# -lt 4 ]
then
	usage
	exit
fi

winworldpc-get-download-url "$@"

