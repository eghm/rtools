if [ -z "$1" ]
then
    echo "Required arguemnet location of the jtl file missing."
    exit;
fi

if [ -z "$2" ]
then
    echo "Required arguemnet base name of jtl file missing."
    exit;
fi

cd $1

FILE="${2%.*}"

if [ -z "$JMETER_HOME" ]
then
    echo "Required env var JMETER_HOME not set."
    exit;
fi

# http://code.google.com/p/jmeter-plugins/wiki/JMeterPluginsCMD
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ResponseTimesOverTime$3.png --input-jtl $FILE.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600 $4 $5 $6 $7 $8 $9
exit
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ThreadsStateOverTime$3.png --input-jtl $FILE.jtl --plugin-type ThreadsStateOverTime --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-BytesThroughputOverTime$3.png --input-jtl $FILE.jtl --plugin-type BytesThroughputOverTime --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-HitsPerSecond$3.png --input-jtl $FILE.jtl --plugin-type HitsPerSecond --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-LatenciesOverTime$3.png --input-jtl $FILE.jtl --plugin-type LatenciesOverTime --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-PerfMon$3.png --input-jtl $FILE.jtl --plugin-type PerfMon --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ResponseCodesPerSecond$3.png --input-jtl $FILE.jtl --plugin-type ResponseCodesPerSecond --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ResponseTimesDistribution$3.png --input-jtl $FILE.jtl --plugin-type ResponseTimesDistribution --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ResponseTimesPercentiles$3.png --input-jtl $FILE.jtl --plugin-type ResponseTimesPercentiles --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ThroughputOverTime$3.png --input-jtl $FILE.jtl --plugin-type ThroughputOverTime --width 800 --height 600 $4 $5 $6 $7 $8 $9
#$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-ThroughputVsThreads$3.png --input-jtl $FILE.jtl --plugin-type ThroughputVsThreads --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-TimesVsThreads$3.png --input-jtl $FILE.jtl --plugin-type TimesVsThreads --width 800 --height 600 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-TransactionsPerSecond$3.png --input-jtl $FILE.jtl --plugin-type TransactionsPerSecond --width 800 --height 600 $4 $5 $6 $7 $8 $9
#/$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $FILE-PageDataExtractorOverTime$3.png --input-jtl $FILE.jtl --plugin-type PageDataExtractorOverTime --width 800 --height 600 $4 $5 $6 $7 $8 $9
