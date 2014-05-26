if [ -z "$1" ]
then
    echo "Required arguemnet location of the jtl files missing."
    exit;
fi

cd $1

if [ -z "$JMETER_HOME" ]
then
    echo "Required env var JMETER_HOME not set."
    exit;
fi

for f in *.jtl
do

echo "Processing $f"
# http://code.google.com/p/jmeter-plugins/wiki/JMeterPluginsCMD
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ResponseTimesOverTime.png --input-jtl $f --plugin-type ResponseTimesOverTime --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ThreadsStateOverTime.png --input-jtl $f --plugin-type ThreadsStateOverTime --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-BytesThroughputOverTime.png --input-jtl $f --plugin-type BytesThroughputOverTime --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-HitsPerSecond.png --input-jtl $f --plugin-type HitsPerSecond --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-LatenciesOverTime.png --input-jtl $f --plugin-type LatenciesOverTime --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-PerfMon.png --input-jtl $f --plugin-type PerfMon --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ResponseCodesPerSecond.png --input-jtl $f --plugin-type ResponseCodesPerSecond --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ResponseTimesDistribution.png --input-jtl $f --plugin-type ResponseTimesDistribution --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ResponseTimesPercentiles.png --input-jtl $f --plugin-type ResponseTimesPercentiles --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ThroughputOverTime.png --input-jtl $f --plugin-type ThroughputOverTime --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
#$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-ThroughputVsThreads.png --input-jtl $f --plugin-type ThroughputVsThreads --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-TimesVsThreads.png --input-jtl $f --plugin-type TimesVsThreads --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-TransactionsPerSecond.png --input-jtl $f --plugin-type TransactionsPerSecond --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9
#/$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $f-PageDataExtractorOverTime.png --input-jtl $f --plugin-type PageDataExtractorOverTime --width 800 --height 600 $2 $3 $4 $5 $6 $7 $8 $9

done