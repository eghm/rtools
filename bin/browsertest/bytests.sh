# url, saucelabs user, saucelabs key, rice version, kuali user
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

cd $R_HOME/$4

BY_FILE=demotests.txt
TESTS_FILE=saucelabtargets.csv

if [ ! -e "$BY_FILE" ]
then
    find rice-middleware/sampleapp/src/it/ -name 'Demo*SmokeTest.java' -exec basename {} \; > "$BY_FILE"
    find rice-middleware/sampleapp/src/it/ -name 'Demo*Gen.java' -exec basename {} \; >> "$BY_FILE"
fi

while [ -s "$BY_FILE" ]
do
	
    export IT_TEST=$(tail -n 1 $BY_FILE | cut -d . -f 1);
    echo "$IT_TEST"

    if [ ! -e "$TESTS_FILE" ]
    then
        cp $R_HOME/rtools/etc/$TESTS_FILE .
    fi

    while [ -s "$TESTS_FILE" ] 
    do
        export DTS=$(date +%Y%m%d%H%M)
 
        export SAUCE_OS=$(tail -n 1 $TESTS_FILE | cut -d , -f 1);
        export SAUCE_BROWSER=$(tail -n 1 $TESTS_FILE | cut -d , -f 2);	
        export SAUCE_VERSION=$(tail -n 1 $TESTS_FILE | cut -d , -f 3);
		
        export logname=$1-$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$DTS

        touch ../logs/$4/$logname.out 
        ln -s ../logs/$4/$logname.out $logname.out
        mvn -version  >> $logname.out
        echo "MAVEN_OPTS=$MAVEN_OPTS" >> $logname.out
        echo "mvn -f rice-middleware/sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$SAUCE_VERSION -Dremote.driver.saucelabs.platform=$SAUCE_OS -Dremote.driver.saucelabs.browser=$SAUCE_BROWSER -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Drice.version=$4 -Dremote.jgrowl.enabled=true -Dremote.driver.highlight=true $6 $7 $8 $9" >> $logname.out
        ( mvn -f rice-middleware/sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$SAUCE_VERSION -Dremote.driver.saucelabs.platform=$SAUCE_OS -Dremote.driver.saucelabs.browser=$SAUCE_BROWSER -Dremote.public.user=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=true -Dremote.driver.highlight=true -Dit.test=$IT_TEST $6 $7 $8 $9 >> $logname.out 2>&1 && touch /tmp/$logname )

        while [ ! -e /tmp/$logname ]
        do
	        sleep 10;
        done
        rm /tmp/$logname
	
	    sed '$d' $TESTS_FILE > $TESTS_FILE.cut
        mv $TESTS_FILE.cut $TESTS_FILE	

        find rice-middleware/sampleapp/ -name 'SauceLabsResources$IT_TEST.*$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$4-*.sh' -exec chmod 755 {} \;
        find rice-middleware/sampleapp/ -name 'SauceLabsResources$IT_TEST.*$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$4-*.sh' -exec {} \;

#        chmod 755 "rice-middleware/sampleapp/SauceLabsResources$IT_TEST.*$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$4-*.sh"
#        "./rice-middleware/sampleapp/SauceLabsResources$IT_TEST.*$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$4-*.sh"

    done;

rm "$TESTS_FILE"

sed '$d' $BY_FILE > $BY_FILE.cut
mv $BY_FILE.cut $BY_FILE	

done;

rm "$IT_TEST"
