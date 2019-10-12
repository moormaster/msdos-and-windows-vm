bogomips-sleep() {
	if [ "$1" == "" ] || [ "$1" -le 0 ]
	then
		bogomips-sleep-usage
		return
	fi

	time="$1"
	bogomips="$( cat /proc/cpuinfo | grep bogomips | tail -n 1 | grep -o "[0-9]\+\.[0-9]\+" )"

	bogomipstime=$( echo "$time * 6028.69 / $bogomips" | bc )
	sleep $bogomipstime
}

bogomips-sleep-usage() {
	echo "bogomips-sleep <sleep time in s>" 1>&2
}
