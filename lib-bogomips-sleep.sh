bogomips-measure() {
	local sum=0
	local count=5

	for ((c=0;c<count;c++))
	do
		value=$(TIMEFORMAT=%U bash -c "time for ((i=0;i<1000000;i++)); do true; done" 2>&1 | sed "s/,/./")
		sum=$( echo "scale=3; $sum + $value" | bc )
	done

	echo $( echo "scale=3; $sum/$value" | bc )
}

bogomips-sleep() {
	if [ "$1" == "" ]
	then
		bogomips-sleep-usage
		return
	fi

	time="$1"

	if [ "$SLEEPFACTOR" == "" ]
	then
		echo "calibrating sleep times..."
		local bogomips=$( bogomips-measure )
		SLEEPFACTOR="($bogomips / 4.864)"
	fi

	bogomipstime=$( echo "scale=2; $time * ${SLEEPFACTOR}" | bc )

	sleep $bogomipstime
}

bogomips-sleep-usage() {
	echo "bogomips-sleep <sleep time in s>" 1>&2
}
