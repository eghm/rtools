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

if [ -z "$JMETER_HOME" ]
then
    echo "Required env var JMETER_HOME not set."
    exit;
fi

# http://code.google.com/p/jmeter-plugins/wiki/JMeterPluginsCMD
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ResponseTimesOverTime.png --input-jtl $2.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ThreadsStateOverTime.png --input-jtl $2.jtl --plugin-type ThreadsStateOverTime --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-BytesThroughputOverTime.png --input-jtl $2.jtl --plugin-type BytesThroughputOverTime --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-HitsPerSecond.png --input-jtl $2.jtl --plugin-type HitsPerSecond --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-LatenciesOverTime.png --input-jtl $2.jtl --plugin-type LatenciesOverTime --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-PerfMon.png --input-jtl $2.jtl --plugin-type PerfMon --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ResponseCodesPerSecond.png --input-jtl $2.jtl --plugin-type ResponseCodesPerSecond --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ResponseTimesDistribution.png --input-jtl $2.jtl --plugin-type ResponseTimesDistribution --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ResponseTimesPercentiles.png --input-jtl $2.jtl --plugin-type ResponseTimesPercentiles --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ThroughputOverTime.png --input-jtl $2.jtl --plugin-type ThroughputOverTime --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
#$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-ThroughputVsThreads.png --input-jtl $2.jtl --plugin-type ThroughputVsThreads --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-TimesVsThreads.png --input-jtl $2.jtl --plugin-type TimesVsThreads --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-TransactionsPerSecond.png --input-jtl $2.jtl --plugin-type TransactionsPerSecond --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
#/$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png $2-PageDataExtractorOverTime.png --input-jtl $2.jtl --plugin-type PageDataExtractorOverTime --width 800 --height 600 $3 $4 $5 $6 $7 $8 $9
