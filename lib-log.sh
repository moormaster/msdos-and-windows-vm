log-lines-with-timestamp() {
	while read line
	do
		echo -e "$(date +%H:%M:%S) $line"
	done
}

