# url, saucelabs user, saucelabs key, rice version, kuali user
# like testskrad.sh but for rice
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

# assumed project is in $R_HOME
cd $R_HOME/$4

# DTS to keep track of output, note all log files with have the DTS at time of start.
export DTS=$(date +%Y%m%d%H%M)

# if a saucelabtargets.csv already exists, use it, else copy over a fresh one.
TESTS_FILE=saucelabtargets.csv
if [ ! -e "$TESTS_FILE" ]
then
    cp $R_HOME/rtools/etc/$TESTS_FILE .
fi

# this doesn't really work, start it by hand in another terminal
#/bin/bash -c "$R_HOME/rtools/bin/browsertest/saucelabsdownload.sh $R_HOME/$4 rice-middleware/sampleapp"

while [ -s "$TESTS_FILE" ] 
do
    # get saucelabs details from last line in saucelabtargets.csv
    export SAUCE_OS=$(tail -n 1 $TESTS_FILE | cut -d , -f 1);
    export SAUCE_BROWSER=$(tail -n 1 $TESTS_FILE | cut -d , -f 2);	
    export SAUCE_VERSION=$(tail -n 1 $TESTS_FILE | cut -d , -f 3);
		
    # setup ../logs with symlinks
    export logname=$1-$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$DTS
    touch ../logs/$4/$logname.out 
    ln -s ../logs/$4/$logname.out $logname.out
    date >> $logname.out
    mvn -version  >> $logname.out
    echo "MAVEN_OPTS=$MAVEN_OPTS" >> $logname.out

    # Run the test, logging the output, touch /tmp/$logname used to make sure job has fully completed
    echo "mvn -f rice-middleware/sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dsaucelabs.user=$2 -Dsaucelabs.key=$3 -Dsaucelabs.browser.version=$SAUCE_VERSION -Dsaucelabs.platform=$SAUCE_OS -Dsaucelabs.browser=$SAUCE_BROWSER -Duser=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dsaucelabs.download.scripts=true $6 $7 $8 $9 >> $logname.out"
    ( mvn -f rice-middleware/sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dsaucelabs.user=$2 -Dsaucelabs.key=$3 -Dsaucelabs.browser.version=$SAUCE_VERSION -Dsaucelabs.platform=$SAUCE_OS -Dsaucelabs.browser=$SAUCE_BROWSER -Dremote.public.user=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dsaucelabs.download.scripts=true $6 $7 $8 $9 >> $logname.out 2>&1 && touch /tmp/$logname )
    date >> $logname.out

    # give job a chance to be fully completed
    while [ ! -e /tmp/$logname ]
    do
	    sleep 10;
    done
    rm /tmp/$logname
	
    # remove the last line of the saucelabtargets.csv
	sed '$d' $TESTS_FILE > $TESTS_FILE.cut
    mv $TESTS_FILE.cut $TESTS_FILE	
done;

# sleep to give seperate download script chance to complete last file
sleep 30 

rm "$TESTS_FILE"
