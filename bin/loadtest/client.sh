# RUN JMETER and have test and outputs in the directory this is run from
if [ -z "$1" ]
then
    echo "Required parameter, server"
    exit;
fi
if [ -z "$2" ]
then
    echo "Required parameter, user"
    exit;
fi
if [ -z "$3" ]
then
    echo "Required parameter, password"
    exit;
fi

if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

export SERVER="$1"
export USER="$2"
export PASS="$3"

# get the release and build from the given server
wget http://$SERVER/portal.do -O portal.html
if [ -s portal.html ]
then
    echo "Sampleapp portal detected"
else
    echo "Sampleapp portal 404 tring KRAD sampleapp"
    wget http://$SERVER/kr-krad/kradsampleapp?viewId=KradSampleAppHome -O portal.html
fi

grep "class=\"build\"" portal.html > version.xml
# version_dirty.txt has a space before and after the build
cut -f 3 -d : version.xml > version_dirty.txt
export DIRTY_VERSION=$(cat version_dirty.txt)
export R_VERSION=${DIRTY_VERSION/ /}
echo $R_VERSION > version.txt
rm version.xml
rm version_dirty.txt
# now get the release from version.txt
cut -f 1 -d - version.txt > release.txt
export R_RELEASE=$(cat release.txt)
echo $R_RELEASE
rm release.txt

# dts.txt doesn't exist since the loadtest log mv script (needs to be done before the wget of the logs) deletes it.....
#scp tomcat@$SERVER:dts.txt .
if [ -e dts.txt ]
then
    export DTS=$(cat dts.txt)
fi

if [ -z "$DTS" ]
then
    echo "Required variable, DTS"
    exit;
fi

wget -r -np -nH --cut-dirs=2 -R index.html http://$SERVER/tomcat/logs/$DTS
wget http://env11.rice.kuali.org/tomcat/logs/env.jsp -O env.html
echo "TODO parse the JAVA_OPTS and CATALINA_OPTS out of env.html (attached) and put into jvm.txt for inclusion in the wiki page." > jvm.txt

sipsTiff2Png.sh $(pwd)
mkdir -p tiffs/$DTS
mv *.tiff tiffs/$DTS/

# http://code.google.com/p/jmeter-plugins/wiki/JMeterPluginsCMD
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseTimesOverTime.png --input-jtl ResultsTable.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ThreadsStateOverTime.png --input-jtl ResultsTable.jtl --plugin-type ThreadsStateOverTime --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png BytesThroughputOverTime.png --input-jtl ResultsTable.jtl --plugin-type BytesThroughputOverTime --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png HitsPerSecond.png --input-jtl ResultsTable.jtl --plugin-type HitsPerSecond --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png LatenciesOverTime.png --input-jtl ResultsTable.jtl --plugin-type LatenciesOverTime --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png PerfMon.png --input-jtl ResultsTable.jtl --plugin-type PerfMon --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseCodesPerSecond.png --input-jtl ResultsTable.jtl --plugin-type ResponseCodesPerSecond --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseTimesDistribution.png --input-jtl ResultsTable.jtl --plugin-type ResponseTimesDistribution --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseTimesPercentiles.png --input-jtl ResultsTable.jtl --plugin-type ResponseTimesPercentiles --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ThroughputOverTime.png --input-jtl ResultsTable.jtl --plugin-type ThroughputOverTime --width 800 --height 600
#/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png ThroughputVsThreads.png --input-jtl ResultsTable.jtl --plugin-type ThroughputVsThreads --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png TimesVsThreads.png --input-jtl ResultsTable.jtl --plugin-type TimesVsThreads --width 800 --height 600
/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png TransactionsPerSecond.png --input-jtl ResultsTable.jtl --plugin-type TransactionsPerSecond --width 800 --height 600
#/java/jmeter-2.8/lib/ext/JMeterPluginsCMD.sh --generate-png PageDataExtractorOverTime.png --input-jtl ResultsTable.jtl --plugin-type PageDataExtractorOverTime --width 800 --height 600


mv *.jtl $DTS/
mv *.pdf $DTS/
mv *.png $DTS/
mv *.log $DTS/
mv *.txt $DTS/
mv *.out $DTS/
mv *.html $DTS/
mv *.jmx $DTS/
mv *.hprof $DTS/

cd $DTS

# there should be only one jmx file, we'll use its name as part of the wiki page title
for f in *.jmx;
do
    jmetername=$(basename "$f")
    export JMETER_NAME="${jmetername%.*}"
done
export R_DESC=$JMETER_NAME

export JM_NUM=$(xml sel -T -t -v "//stringProp[@name='ThreadGroup.num_threads']" *.jmx)
export JM_RAMP=$(xml sel -T -t -v "//stringProp[@name='ThreadGroup.ramp_time']" *.jmx)
export JM_LOOP=$(xml sel -T -t -v "//stringProp[@name='LoopController.loops']" *.jmx)

$R_HOME/rtools/bin/loadtest/contextSed.sh $(pwd)

export WIKI_DTS=${DTS/\// }
export WIKI_TITLE="$R_VERSION $R_DESC JMeter Load Test $JM_NUM x $JM_LOOP in $JM_RAMP seconds on $WIKI_DTS"

/java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$WIKI_TITLE" --parent "Rice $R_RELEASE Load Testing" --file "wiki.txt"

find ./ -name '*.*' -exec /java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addAttachment --space "KULRICE" --title "$WIKI_TITLE" --file "{}" \;
