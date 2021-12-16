#!/bin/bash

set -e
OUTPUT_PATH="$4"
LOG_PATH=data/log
LOG_LEVEL=INFO
START_DATE="$2"
END_DATE="$3"

OPTS="-a start_date=${START_DATE} -a end_date=${END_DATE}"

run_spider() {
	spider="$1"

	mkdir -p $LOG_PATH $OUTPUT_PATH
	log_filename="$LOG_PATH/${spider}.log"
	output_filename="$OUTPUT_PATH/${spider}.csv.gz"
	rm -rf $log_filename $output_filename
	echo "Running ${spider} - check $log_filename for logs and $output_filename for output"
	time scrapy crawl \
		--loglevel=$LOG_LEVEL \
		--logfile=$log_filename \
		$OPTS \
		$spider \
		-t "csv.gz" \
		-o $output_filename
}

run_spider $1
