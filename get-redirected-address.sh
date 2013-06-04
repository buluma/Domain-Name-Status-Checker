#!/bin/bash

address="http://$1"
response="301"
timeout=5

# Find redirected address
count=0
while [ $response == "301" ] || [ $response == "302" ]
do
	address=$(curl -m $timeout -k --write-out %{url_effective} --silent --output /dev/null -L $address)
	response=$(curl -m $timeout -k --write-out %{http_code} --silent --output /dev/null $address)

	(( count++ ))

	if [ $count == 10 ]; then
		break
	fi
done

echo $address
