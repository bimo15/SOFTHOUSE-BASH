#!/bin/bash
MEMORYFREE()
{
kbmemoryfree="$(sar -r 1 1 | awk '{print $2}' | awk 'FNR == 4 {print}')"
echo $kbmemoryfree
}

MEMORYUSED()
{
kbmemoryused="$(sar -r 1 1 | awk '{print $3}' |awk 'FNR == 4 {print}')"
echo $kbmemoryused
}

MEMORY(){
type=${FUNCNAME[0]}
}

MEMORYFREE;
MEMORYUSED;
MEMORY;

host=$(hostname)
kbmemoryfree=$(MEMORYFREE)
kbmemoryused=$(MEMORYUSED)
time=$(date +%s%3N)
echo $time
echo $type

JSON="{\"hostname\":\"$HOST\", \"time\":$time, \"free\":$kbmemoryfree, \"used\":$kbmemoryused, \"type\":\"$type\"}"

curl -X POST -H 'Content-Type: application/json' --data-ascii "$JSON" http://$1:8080/api/metrics

exit 0
