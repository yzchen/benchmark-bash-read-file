#!/bin/bash

echo "Initial Settings : "
INFILE=dummy.txt
OUTFILE=dummy-out.txt
echo -e "\tINFILE : dummy.txt"
echo -e "\tOUTFILE : dummy-out.txt\n"

echo "Information about INFILE : "
echo -e "\t#rows =" `wc -l $INFILE | awk '{print $1}'`
echo -e "\t#columns =" `head -1 $INFILE | wc -c` 
echo -e "\tsize =" `ls -lh $INFILE | awk '{print $6}' `

echo ""

# explicitly set time format for 'time' command
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '1. cat $INFILE | while read LINE; do echo \"$LINE\" >> $OUTFILE; done'
time ( cat $INFILE | while read LINE; do echo "$LINE" >> $OUTFILE; done )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '2. while read LINE; do echo "$LINE" >> $OUTFILE; done < $INFILE'
time ( while read LINE; do echo "$LINE" >> $OUTFILE; done < $INFILE )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '3. cat $INFILE | while LINE=`line`; do echo "$LINE" >> $OUTFILE; done'
echo ">>> your system should support 'line' command <<<"
time ( cat $INFILE | while LINE=`line`; do echo "$LINE" >> $OUTFILE; done )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '4. while LINE=`line`; do echo "$LINE" >> $OUTFILE; done < $INFILE'
echo ">>> your system should support 'line' command <<<"
time ( while LINE=`line`; do echo "$LINE" >> $OUTFILE; done < $INFILE )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '5. exec 3<&1 0<$INFILE; while read LINE; do echo "$LINE" >> $OUTFILE; done; exec 0<&3 3<&-'
time ( exec 3<&0 0<$INFILE; while read LINE; do echo "$LINE" >> $OUTFILE; done; exec 0<&3 3<&- )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '6. exec 3<&1 0<$INFILE 4>&1 1>$OUTFILE; while read LINE; do echo "$LINE"; done; exec 0<&3 3<&- 1>&4 4>&-'
time ( exec 3<&1 0<$INFILE 4>&1 1>$OUTFILE; while read LINE; do echo "$LINE"; done; exec 0<&3 3<&- 1>&4 4>&- )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '7. for LINE in $(cat $INFILE); do echo "$LINE" >> $OUTFILE; done'
time ( for LINE in $(cat $INFILE); do echo "$LINE" >> $OUTFILE; done )

echo "------------------------------------------------------------------------------"
rm -f dummy-out.txt
echo '8. exec 4>&1 1>$OUTFILE; for LINE in $(cat $INFILE); do echo "$LINE"; done; exec 1>&4 4>&-'
time ( exec 4>&1 1>$OUTFILE; for LINE in $(cat $INFILE); do echo "$LINE"; done; exec 1>&4 4>&- )
