#!/bin/bash

echo "Initial Settings : "
INFILE=dummy.txt
OUTFILE=dummy-out.txt
echo -e "\tINFILE : dummy.txt"
echo -e "\tOUTFILE : dummy-out.txt"
echo ""

echo "INFILE information : "
echo -e "\t#rows =" `wc -l $INFILE | awk '{print $1}'`
echo -e "\t#columns =" `head -1 $INFILE | wc -c` 
echo -e "\tsize =" `ls -lh $INFILE | awk '{print $6}' `
echo ""

echo "System information : "
echo "1. CPU "
echo `lscpu | grep 'CPU(s)'`
echo "2. Memory "
echo "Memory: " `free -h | grep 'Mem' | awk '{print $2}'`
echo ""

# explicitly set time format for 'time' command
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '1. cat $INFILE | while read LINE; do echo "$LINE" >> $OUTFILE; done'
time ( cat $INFILE | while read LINE; do echo "$LINE" >> $OUTFILE; done )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '2. while read LINE; do echo "$LINE" >> $OUTFILE; done < $INFILE'
time ( while read LINE; do echo "$LINE" >> $OUTFILE; done < $INFILE )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '3. cat $INFILE | while LINE=`line`; do echo "$LINE" >> $OUTFILE; done'
echo ">>> your system should support 'line' command <<<"
time ( cat $INFILE | while LINE=`line`; do echo "$LINE" >> $OUTFILE; done )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '4. while LINE=`line`; do echo "$LINE" >> $OUTFILE; done < $INFILE'
echo ">>> your system should support 'line' command <<<"
time ( while LINE=`line`; do echo "$LINE" >> $OUTFILE; done < $INFILE )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '5. exec 3<&0 0<$INFILE; while read LINE; do echo "$LINE" >> $OUTFILE; done; exec 0<&3 3>&-'
time ( exec 3<&0 0<$INFILE; while read LINE; do echo "$LINE" >> $OUTFILE; done; exec 0<&3 3>&- )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '6. exec 3<&0 0<$INFILE 4<&1 1>$OUTFILE; while read LINE; do echo "$LINE"; done; exec 0<&3 3>&- 1<&4 4>&-'
time ( exec 3<&0 0<$INFILE 4<&1 1>$OUTFILE; while read LINE; do echo "$LINE"; done; exec 0<&3 3>&- 1<&4 4>&- )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '7. for LINE in $(cat $INFILE); do echo "$LINE" >> $OUTFILE; done'
time ( for LINE in $(cat $INFILE); do echo "$LINE" >> $OUTFILE; done )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '8. exec 4<&1 1>$OUTFILE; for LINE in $(cat $INFILE); do echo "$LINE"; done; exec 1<&4 4>&-'
time ( exec 4<&1 1>$OUTFILE; for LINE in $(cat $INFILE); do echo "$LINE"; done; exec 1<&4 4>&- )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
>$OUTFILE
echo '9. exec 3<&0 0<$INFILE 4<&1 1>$OUTFILE; while LINE=`line`; do echo "$LINE"; done; exec 0<&3 3>&- 1<&4 4>&-'
time ( exec 3<&0 0<$INFILE 4<&1 1>$OUTFILE; while LINE=`line`; do echo "$LINE"; done; exec 0<&3 3>&- 1<&4 4>&- )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
echo ">>> in this case generated file has different order from original one <<<"
>$OUTFILE
echo -e '10. split --additional-suffix .tmp -l 2000 dummy.txt; find . -name "*.tmp" | parallel --no-notice "while read LINE; do echo $LINE >> {}.out; done < {}"; cat *.out > dummy-out.txt; rm *.tmp *.out'
time ( split --additional-suffix .tmp -l 2000 dummy.txt; find . -name "*.tmp" | parallel -j10 --no-notice "while read LINE; do echo $LINE >> {}.out; done < {}"; cat *.out > dummy-out.txt; rm *.tmp *.out )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

echo "------------------------------------------------------------------------------"
echo ">>> with awk actually it's not processing line by line any more <<<"
>$OUTFILE
echo "11. awk '{print}' dummy.txt > dummy-out.txt"
time ( awk '{print}' dummy.txt > dummy-out.txt )
if diff $INFILE $OUTFILE &> /dev/null; then
    echo "check : output file is the same as input file"
else
    if [ $(wc -l $INFILE | awk '{print $1}') -eq $(wc -l $INFILE | awk '{print $1}') ]; then
        echo "check : output file is the same as input file"
    else
        echo "check : output file is different from input file"
    fi
fi

