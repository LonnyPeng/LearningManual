#!/bin/bash

if [ "$1" != "" ]; then
	i=$(($1+1))
else
	i=0
fi

SQL="SELECT (SELECT order_id FROM t_order ORDER BY order_id DESC LIMIT 1), 
	(SELECT order_id FROM t_order_lens ORDER BY order_id DESC LIMIT 1), 
	(SELECT order_id FROM t_order_rx ORDER BY order_id DESC LIMIT 1), 
	(SELECT order_id FROM t_order_shipment ORDER BY order_id DESC LIMIT 1)"

RESULT=$(mysql -h 127.0.0.1 -u root -proot db_main -L -N -s -e"${SQL}")
echo "${i}: ${RESULT}"
echo ''
echo "---------------------------------------------------------------"

sleep 60

source show_copy_mysql_last_info.sh i