bogomips-sleep() {
	if [ "$1" == "" ]
	then
		bogomips-sleep-usage
		return
	fi

	time="$1"
	bogomips="$( cat /proc/cpuinfo | grep bogomips | tail -n 1 | grep -o "[0-9]\+\.[0-9]\+" )"

	bogomipstime=$( echo "scale=2; time * 6028.69 / $bogomips" | bc )

	echo converted sleep time $time to $bogomipstime according to bogomips $bogomips
	sleep $bogomipstime
}

bogomips-sleep-usage() {
	echo "bogomips-sleep <sleep time in s>" 1>&2
}
