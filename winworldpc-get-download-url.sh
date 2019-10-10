#!/bin/bash

getbaseurl() {
	url="$1"

	echo "$url" | grep -o "\(https\?:\/\/[^\/]\+\)\/" | sed "s/\(https\?:\/\/[^\/]\+\)\//\1/"
}

geturlpath() {
	url="$1"

	echo "$url" | grep -o "\(https\?:\/\/[^\/]\+\)\(\/.*\)$" | sed "s/\(https\?:\/\/[^\/]\+\)\(\/.*\)$/\2/"	
}

winworldpc-get-mirrorlist-url() {
	url="$1"
	filename="$2"

	baseurl="$( getbaseurl "$url" )"
	urlpath="$( geturlpath "$url" )"


	echo -n "$baseurl"
	curl "$baseurl$urlpath" | grep -o "href=\"\([^\"]\+\)\" title=\"${filename}\"" | sed "s/href=\"\([^\"]\+\)\" title=\"$filename\"/\1/"
}

winworldpc-get-download-url() {
	url="$1"
	filename="$2"
	mirrorname="$3"

	baseurl="$( getbaseurl "$url" )"
	urlpath="$( geturlpath "$url" )"

	mirrorsurl="$( winworldpc-get-mirrorlist-url "$url" "$filename" )"

	echo -n "$baseurl"
	curl "$mirrorsurl" | grep -o "<a href=\"\([^\"]\+\)\">$mirrorname</a>" | sed "s/<a href=\"\([^\"]\+\)\">$mirrorname<\/a>/\1/"
}

usage() {
	echo "$0 <url> <filename> <mirrorname>"
	echo "example: $0 \"https://winworldpc.com\" \"/product/ms-dos/622\" \"Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z\" \"Ricky\""
}

if [ $# -lt 3 ]
then
	usage
	exit
fi

winworldpc-get-download-url "$@" 2> /dev/null

