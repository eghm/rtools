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
export JM_NUM=$2
export JM_RAMP=$3
export JM_LOOP=$4
echo "$JM_NUM users x $JM_LOOP ramped up in $JM_RAMP seconds." >> wiki.txt

for f in jvm.txt;
do
	echo "{code}" >> wiki.txt
    echo "TODO parse the JAVA_OPTS and CATALINA_OPTS out of env.html (attached) and put into jvm.txt for inclusion in the wiki page." >> wiki.txt
    cat "$f" >> wiki.txt
	echo "{code}" >> wiki.txt
done;

$R_HOME/rtools/bin/loadtest/pngContextSed.sh $1

