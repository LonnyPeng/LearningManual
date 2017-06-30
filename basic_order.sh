#!/bin/bash

# mysql conf start
host="127.0.0.1"
user="root"
password="root"
databaseName="db_main"
# mysql conf end

# stop(.php) is same stop(.sh)
stop=5000
##

SQL="SELECT FLOOR(COUNT(*)/${stop}) FROM t_order_shipment ORDER BY order_id DESC LIMIT 1"

if [ "$2" != "" ]; then
	if [[ $2 == *[0-9]* ]]; then
		i=$2
	else
		i=$(mysql -h ${host} -u ${user} -p${password} ${databaseName} -L -N -s -e"${SQL}")
	fi
else
	i=$(mysql -h ${host} -u ${user} -p${password} ${databaseName} -L -N -s -e"${SQL}")
fi

FILE=$(pwd)
FILE="${FILE}/basic_order.sh"

if [ "$1" != "" ]; then
	HOST=$1
	url="${HOST}/crons/transfer/basic_order.php?i=${i}"

	echo "${url}"
else
	echo "Please enter your host (http://www.baidu.com)..."
	read HOST

	url="${HOST}/crons/transfer/basic_order.php?i=${i}"

	echo "Please enter URL is true: ${url}"
	echo "yes|no"
	read STATUS

	if [ "$STATUS" != "yes" ]; then
		source $FILE
	fi
fi

RESULT=$(curl -s ${url})

if [ "${RESULT}" = "ok" ]; then
	echo "Success."

	read EBD
else
	if [[ $RESULT == *[0-9]* ]]; then
		i=$RESULT
	else
		i=$(mysql -h ${host} -u ${user} -p${password} ${databaseName} -L -N -s -e"${SQL}")
	fi

	echo "----------------------------------------------------------"
	echo ""

	source $FILE $HOST $i
fi