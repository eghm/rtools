if [ -z "$1" ]
then
    echo "Required parameter, directory of to create contexts.txt for."
    exit;
fi
if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

cd $1
rm contents.txt

# *.jmx but should only be one
export JM_NUM=$(xml sel -T -t -v "//stringProp[@name='ThreadGroup.num_threads']" *.jmx)
export JM_RAMP=$(xml sel -T -t -v "//stringProp[@name='ThreadGroup.ramp_time']" *.jmx)
echo "$JM_NUM users ramped up in $JM_RAMP seconds." >> contents.txt

for f in jvm.txt;
do
	echo "{code}" >> contents.txt
    cat "$f" >> contents.txt
	echo "{code}" >> contents.txt
done;


pngContextSed.sh $1

