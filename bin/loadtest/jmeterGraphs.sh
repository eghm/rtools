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

# http://code.google.com/p/jmeter-plugins/wiki/JMeterPluginsCMD
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseTimesOverTime.png --input-jtl ResultsTable.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ThreadsStateOverTime.png --input-jtl ResultsTable.jtl --plugin-type ThreadsStateOverTime --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png BytesThroughputOverTime.png --input-jtl ResultsTable.jtl --plugin-type BytesThroughputOverTime --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png HitsPerSecond.png --input-jtl ResultsTable.jtl --plugin-type HitsPerSecond --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png LatenciesOverTime.png --input-jtl ResultsTable.jtl --plugin-type LatenciesOverTime --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png PerfMon.png --input-jtl ResultsTable.jtl --plugin-type PerfMon --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseCodesPerSecond.png --input-jtl ResultsTable.jtl --plugin-type ResponseCodesPerSecond --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseTimesDistribution.png --input-jtl ResultsTable.jtl --plugin-type ResponseTimesDistribution --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ResponseTimesPercentiles.png --input-jtl ResultsTable.jtl --plugin-type ResponseTimesPercentiles --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ThroughputOverTime.png --input-jtl ResultsTable.jtl --plugin-type ThroughputOverTime --width 800 --height 600
#$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png ThroughputVsThreads.png --input-jtl ResultsTable.jtl --plugin-type ThroughputVsThreads --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png TimesVsThreads.png --input-jtl ResultsTable.jtl --plugin-type TimesVsThreads --width 800 --height 600
$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png TransactionsPerSecond.png --input-jtl ResultsTable.jtl --plugin-type TransactionsPerSecond --width 800 --height 600
#/$JMETER_HOME/lib/ext/JMeterPluginsCMD.sh --generate-png PageDataExtractorOverTime.png --input-jtl ResultsTable.jtl --plugin-type PageDataExtractorOverTime --width 800 --height 600
