#!/bin/bash

MEMIIB=$(ps -o pid,user,%mem,command ax | grep mqsi | grep -v PID | sort -bnr -k3 | awk '/[0-9]*/{print $1 ":" $2 ":" $4 ":" $7}')


for i in $MEMIIB
do
    PID=$(echo $i | cut -d: -f1)
    OWNER=$(echo $i | cut -d: -f2)
    COMMAND=$(echo $i | cut -d: -f3-7)
    MEMORY=$(pmap $PID | tail -n 1 | awk '/[0-9]K/{print $2/1024^2}')

    echo "PID: $PID"
    echo "OWNER: $OWNER"
    echo "COMMAND: $COMMAND "GB""
    echo "MEMORY: $MEMORY"
    echo ""

done