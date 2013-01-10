if [ -z "$1" ]
then
    echo "Required parameter, directory of png to create contexts.txt for."
    exit;
fi
if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

pngContextSed.sh $1

for f in jvm.txt;
do
	echo "{code}" >> contents.txt
    cat "$f" >> contents.txt
	echo "{code}" >> contents.txt
done;
