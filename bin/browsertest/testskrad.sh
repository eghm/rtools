# url, saucelabs user, saucelabs key, rice version, kuali user
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

cd $R_HOME/$4
export DTS=$(date +%Y%m%d%H%M)
TESTS_FILE=saucelabtargets.csv

if [ ! -e "$TESTS_FILE" ]
then
    cp $R_HOME/rtools/etc/$TESTS_FILE .
fi

/bin/bash -c "$R_HOME/rtools/bin/browsertest/saucelabsdownload.sh $R_HOME/$4 rice-framework/krad-sampleapp/web/"

while [ -s "$TESTS_FILE" ] 
do
    export SAUCE_OS=$(tail -n 1 $TESTS_FILE | cut -d , -f 1);
    export SAUCE_BROWSER=$(tail -n 1 $TESTS_FILE | cut -d , -f 2);	
    export SAUCE_VERSION=$(tail -n 1 $TESTS_FILE | cut -d , -f 3);
		
    export logname=$1-$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$DTS

    touch ../logs/$4/$logname.out 
    ln -s ../logs/$4/$logname.out $logname.out
    date >> $logname.out
    mvn -version  >> $logname.out
    echo "MAVEN_OPTS=$MAVEN_OPTS" >> $logname.out
    echo "mvn -f rice-framework/krad-sampleapp/web/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dsaucelabs.user=$2 -Dsaucelabs.key=$3 -Dsaucelabs.browser.version=$SAUCE_VERSION -Dsaucelabs.platform=$SAUCE_OS -Dsaucelabs.browser=$SAUCE_BROWSER -Duser=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dsaucelabs.download.scripts=true $6 $7 $8 $9 >> $logname.out"
    ( mvn -f rice-framework/krad-sampleapp/web/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dsaucelabs.user=$2 -Dsaucelabs.key=$3 -Dsaucelabs.browser.version=$SAUCE_VERSION -Dsaucelabs.platform=$SAUCE_OS -Dsaucelabs.browser=$SAUCE_BROWSER -Dremote.public.user=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dsaucelabs.download.scripts=true $6 $7 $8 $9 >> $logname.out 2>&1 && touch /tmp/$logname )
    date >> $logname.out

    while [ ! -e /tmp/$logname ]
    do
	    sleep 10;
    done
    rm /tmp/$logname
	
	sed '$d' $TESTS_FILE > $TESTS_FILE.cut
    mv $TESTS_FILE.cut $TESTS_FILE	
done;

# sleep to give seperate download script chance to complete last file
sleep 30 

rm "$TESTS_FILE"
