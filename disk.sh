#!/bin/bash
DISKAVAILABLE() {
kbdiskavailable="$(df ~/ | awk '{print $4}' | awk 'FNR == 2 {print}')"
echo $kbdiskavailable
}

DISKUSED()
{
kbdiskused="$(df ~/ | awk '{print $3}' | awk 'FNR == 2 {print}')"
echo $kbdiskused
}

DISK(){
type=${FUNCNAME[0]}
}

DISKAVAILABLE;
DISKUSED;
DISK;


host=$(hostname)
kbdiskavailable=$(DISKAVAILABLE)
kbdiskused=$(DISKUSED)
time=$(date +%s%3N)
echo $time
echo $type

JSON="{\"hostname\":\"$host\", \"time\":$time, \"free\":$kbdiskavailable, \"used\":$kbdiskused, \"type\":\"$type\"}"


curl -X POST -H 'Content-Type: application/json' --data-ascii "$JSON" http://$1:8080/api/metrics

exit 0
