bogomips-measure() {
	local sum=0
	local count=5

	for ((c=0;c<count;c++))
	do
		value=$(TIMEFORMAT=%U bash -c "time for ((i=0;i<1000000;i++)); do true; done" 2>&1 | sed "s/,/./")
		sum=$( echo "scale=3; $sum + $value" | bc )
	done

	echo $( echo "scale=3; $sum/$count" | bc )
}

bogomips-sleep() {
	if [ "$1" == "" ]
	then
		bogomips-sleep-usage
		return
	fi

	time="$1"

	if [ "$MINSLEEPFACTOR" == "" ]
	then
		MINSLEEPFACTOR=0.9
	fi

	if [ "$SLEEPFACTOR" == "" ]
	then
		echo -n "calibrating sleep times... "
		local bogomips=$( bogomips-measure )
		SLEEPFACTOR="($bogomips / 4.378)"

		echo "SLEEPFACTOR=$( echo "scale=3; $SLEEPFACTOR" | bc )"
	fi

	if [ "$(echo "$SLEEPFACTOR < $MINSLEEPFACTOR" | bc)" == "1" ]
	then
		echo "SLEEPFACTOR $SLEEPFACTOR increased to $MINSLEEPFACTOR due to the minimum limit. Set MINSLEEPFACTOR to 0 to override"
		SLEEPFACTOR=$MINSLEEPFACTOR
	fi

	bogomipstime=$( echo "scale=2; $time * ${SLEEPFACTOR}" | bc )

	sleep $bogomipstime
}

bogomips-sleep-usage() {
	echo -e "usage:\n\tbogomips-sleep <sleep time in s>" 1>&2
}
