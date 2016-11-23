#!/bin/bash
CPU()
{
cpupercent="$( sar -u 1 1 | awk '{ print (100-$8) }' | awk 'FNR == 4 {print}' )" 
echo $cpupercent
total="100"
cpunotused=$(echo "$total-$cpupercent" |bc)
type=${FUNCNAME[0]}
}

CPU;

host=$(hostname)
time=$(date +%s%3N)
echo $time
echo $cpunotused
cpupercentage=$(CPU)
echo $type


JSON="{\"hostname\":\"$host\", \"time\":$time, \"free\":$cpunotused, \"used\":$cpupercentage, \"type\":\"$type\"}"


curl -X POST -H 'Content-Type: application/json' --data-ascii "$JSON" http://$1:8080/api/metrics

exit 0
