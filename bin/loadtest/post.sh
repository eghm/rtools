# $1 SERVER $2 USER $3 PASS $4 JM_NUM $5 JM_LOOP $6 JM_RAMP

if [ -e dts.txt ]
then
    export DTS=$(cat dts.txt)
fi

if [ -z "$DTS" ]
then
    echo "Required variable, DTS"
    exit;
fi

sipsTiff2Png.sh $(pwd)
mkdir -p ../../tiffs/$DTS
mv *.tiff ../../tiffs/$DTS/

# there should be only one jmx file, we'll use its name as part of the wiki page title
for f in *.jmx;
do
    jmetername=$(basename "$f")
    export JMETER_NAME="${jmetername%.*}"
done
export R_DESC=$JMETER_NAME

export SERVER="$1"
export USER="$2"
export PASS="$3"
export JM_NUM="$4"
export JM_LOOP="$5"
export JM_RAMP="$6"

#$R_HOME/rtools/bin/loadtest/contextSed2.sh $(pwd) $JM_NUM $JM_LOOP $JM_RAMP
#cd $1
rm wiki.txt

echo "$JM_NUM users x $JM_LOOP ramped up in $JM_RAMP seconds." >> wiki.txt

# *.jmx but should only be one
for f in jvm.txt;
do
	echo "{code}" >> wiki.txt
    cat "$f" >> wiki.txt
	echo "{code}" >> wiki.txt
done;

$R_HOME/rtools/bin/loadtest/pngContextSed.sh $(pwd)

export WIKI_DTS=${DTS/\// }
export WIKI_TITLE="$R_VERSION $R_DESC JMeter Load Test $JM_NUM x $JM_LOOP in $JM_RAMP seconds on $WIKI_DTS"

export R_RELEASE=$(cat release.txt)

#echo /java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$WIKI_TITLE" --parent "Rice $R_RELEASE Load Testing" --file "wiki.txt"
/java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$WIKI_TITLE" --parent "Rice $R_RELEASE Load Testing" --file "wiki.txt"

find ./ -name '*.*' -exec /java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addAttachment --space "KULRICE" --title "$WIKI_TITLE" --file "{}" \;
