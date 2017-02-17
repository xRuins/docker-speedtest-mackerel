#!/bin/sh

if [ $# -ne 3 ]; then
        echo "Usage: speedtest.sh <MACKEREL_API_KEY> <MACKEREL_SERVICE_METRICS_NAME> <SPEEDTEST_SERVER_ID>" 1>&2
        exit 1
fi

APIKEY=$1
METRICS_NAME=$2
SERVER_ID=$3

SPEEDTEST_RESULT=$(speedtest --server $SERVER_ID)
DOWNLOAD_SPEED=$(echo $SPEEDTEST_RESULT | grep -o -E "Download:\s+[0-9\.]+\s+Mbit/s" | grep -o -E "[0-9\.]+")
UPLOAD_SPEED=$(echo $SPEEDTEST_RESULT | grep -o -E "Upload:\s+[0-9\.]+\s+Mbit/s" | grep -o -E "[0-9\.]+")
TIMESTAMP=$(date +%s)

JSON_DATA=$(cat <<-EOF
	   [
		{"name": "Speedtest.DownloadSpeed",
		 "time": $TIMESTAMP,
		 "value": $DOWNLOAD_SPEED},
		{"name": "Speedtest.UploadSpeed",
		 "time": $TIMESTAMP,
		 "value": $UPLOAD_SPEED}
	   ]
EOF
)

curl "https://mackerel.io/api/v0/services/$METRICS_NAME/tsdb" \
        -H "X-Api-Key: $APIKEY" \
        -H "Content-Type: application/json" \
        -X POST -d "$JSON_DATA" > /dev/null
echo "$(date +'%b %d %H:%M:%S') post-speedtest-mackerel: posted $(echo $JSON_DATA | tr -d '\n')"
