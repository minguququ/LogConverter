#/bin/bash
if [ $# -lt 2 ]; then
	echo usage: $(basename $(readlink -nf $0)) logfilename \"pattern\" ...
	exit 1
fi
if [ ! -f $1 ]; then
	echo file not exist!!
	exit 1
fi

i=0
for arg; do
	if [ $i -ne 0 ]; then
		regexp=`echo $arg | sed 's/\([(.)]\)/\\\\\1/g'`
		pat_str="$pat_str -e \"$regexp\""
	fi
#	echo i: $i, arg:$arg
	i=$(($i+1))
done;

cmd="egrep $1 $pat_str"
eval $cmd > $TMP_FILE
meld $1 $TMP_FILE 

#cmd="egrep -i $1 $pat_str"
#eval $cmd > '$TMP_FILE'd
#echo cmd : $cmd

#vi '$TMP_FILE'd
#rm '$TMP_FILE'd
rm $TMP_FILE
