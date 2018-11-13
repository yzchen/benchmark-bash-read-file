#!/bin/bash

echo "generate 1,000,000 lines random file with each line has 60 characters"

INFILE=dummy.txt
NUMLINES=4000
NUMCHARS=60

>$INFILE

for i in $(seq 1 $NUMLINES)
do
    if (( i%1000 == 0 ))
    then
        echo $i
    fi
    base64 /dev/urandom | head -c $NUMCHARS >> $INFILE
    echo "" >> $INFILE
done

echo "generate done!"
