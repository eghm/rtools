if [ -z "$1" ]
then
    echo "Required parameter, directory of to create wiki.txt for."
    exit;
fi
if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

cd $1
rm wiki.txt

# *.jmx but should only be one
export JM_NUM=$(xml sel -T -t -v "//stringProp[@name='ThreadGroup.num_threads']" *.jmx)
export JM_RAMP=$(xml sel -T -t -v "//stringProp[@name='ThreadGroup.ramp_time']" *.jmx)
export JM_LOOP=$(xml sel -T -t -v "//stringProp[@name='LoopController.loops']" *.jmx)
echo "$JM_NUM users x $JM_LOOP ramped up in $JM_RAMP seconds." >> wiki.txt

for f in jvm.txt;
do
	echo "{code}" >> wiki.txt
    cat "$f" >> wiki.txt
	echo "{code}" >> wiki.txt
done;

pngContextSed.sh $1

