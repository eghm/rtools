# $1 USER $2 PASS

if [ -e dts.txt ]
then
    export DTS=$(cat dts.txt)
fi

if [ -z "$DTS" ]
then
    echo "Required variable, DTS"
    exit;
fi

if [ -z "$CONFLUENCE_HOME" ]
then
    echo "Required variable, CONFLUENCE_HOME"
    exit;
fi

if [ -f *.tiff ]
then
    sipsTiff2Png.sh $(pwd)
    mkdir -p ../../tiffs/$DTS
    mv *.tiff ../../tiffs/$DTS/
fi

# there should be only one jmx file, we'll use its name as part of the wiki page title
for f in *.jmx;
do
    jmetername=$(basename "$f")
    export JMETER_NAME="${jmetername%.*}"
done
export R_DESC=$JMETER_NAME

export USER="$1"
export PASS="$2"

if [ ! -f testparams.txt ]
then
	echo "no testparams.txt file found.  exiting"
	exit;
if
export TESTPARAMS=$(cat testparams.txt)
echo "$TESTPARAMS" > wiki.txt

# *.jmx but should only be one
for f in jvm.txt;
do
	echo "{code}" >> wiki.txt
    cat "$f" >> wiki.txt
	echo "{code}" >> wiki.txt
done;

$R_HOME/rtools/bin/loadtest/pngContextSed.sh $(pwd)

export WIKI_DTS=${DTS/\// }
export R_RELEASE=$(cat release.txt)
export WIKI_TITLE="$R_RELEASE $WIKI_DTS $R_DESC JMeter Load Test $TESTPARAMS"

#echo $CONFLUENCE_HOME/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$WIKI_TITLE" --parent "Rice $R_RELEASE Load Testing" --file "wiki.txt"
$CONFLUENCE_HOME/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$WIKI_TITLE" --parent "Rice $R_RELEASE Load Testing" --file "wiki.txt"

find ./ -name '*.*' -exec $CONFLUENCE_HOME/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addAttachment --space "KULRICE" --title "$WIKI_TITLE" --file "{}" \;
