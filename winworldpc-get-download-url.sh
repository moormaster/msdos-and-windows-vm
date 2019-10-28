#!/usr/bin/env bash

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
	filename="$( echo "$2" | sed "s/\[/\\\[/g" | sed "s/\]/\\\]/g" )"

	baseurl="$( getbaseurl "$url" )"
	urlpath="$( geturlpath "$url" )"

	echo -n "$baseurl"
	curl "$baseurl$urlpath" | grep -o "href=\"\([^\"]\+\)\" title=\"${filename}\"" | sed "s/href=\"\([^\"]\+\)\" title=\"$filename\"/\1/" 2> /dev/null
}

winworldpc-get-download-url() {
	url="$1"
	filename="$2"
	mirrorname="$3"

	baseurl="$( getbaseurl "$url" )"
	urlpath="$( geturlpath "$url" )"

	mirrorsurl="$( winworldpc-get-mirrorlist-url "$url" "$filename" )"

	echo -n "$baseurl"
	curl "$mirrorsurl" | grep -o "<a href=\"\([^\"]\+\)\">$mirrorname</a>" | sed "s/<a href=\"\([^\"]\+\)\">$mirrorname<\/a>/\1/" 2> /dev/null
}

usage() {
	echo -e "usage:\n\t$0 <url> <filename> <mirrorname>" 1>&2
	echo -e "example:\n\t$0 \"https://winworldpc.com\" \"/product/ms-dos/622\" \"Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z\" \"Ricky\"" 1>&2
}

if [ $# -lt 3 ]
then
	usage
	exit
fi

winworldpc-get-download-url "$@" 
