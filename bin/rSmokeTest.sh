# remote.public.url remote.driver.saucelabs.user remote.driver.saucelabs.key rice.version 
cd $R_HOME/$4
export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

export TESTS_FILE="$5";
while [ -s "$TESTS_FILE" ] 
do
	export TEST=$(tail -n 1 $TESTS_FILE | cut -d : -f 1)
	export TEST_USER=$(tail -n 1 $TESTS_FILE | cut -d : -f 2)
    export SAUCE_OS=$(tail -n 1 $TESTS_FILE | cut -d : -f 3);
    export SAUCE_BROWSER=$(tail -n 1 $TESTS_FILE | cut -d : -f 4);	
    export SAUCE_VERSION=$(tail -n 1 $TESTS_FILE | cut -d : -f 5);
		
    export logname=$TEST-$TEST_USER-$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$9-$DTS

    touch ../logs/$4/$logname.out 
    ln -s ../logs/$4/$logname.out $logname.out
    mvn -version  >> $logname.out
    echo "MAVEN_OPTS=$MAVEN_OPTS" >> $logname.out
    echo "mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$SAUCE_VERSION -Dremote.driver.saucelabs.platform=$SAUCE_OS -Dremote.driver.saucelabs.browser=$SAUCE_BROWSER -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Drice.version=$4" >> $logname.out
    ( mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$SAUCE_VERSION -Dremote.driver.saucelabs.platform=$SAUCE_OS -Dremote.driver.saucelabs.browser=$SAUCE_BROWSER -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Drice.version=$4 >> $logname.out 2>&1 && touch /tmp/$logname )

    while [ ! -e /tmp/$logname ]
    do
	    sleep 10;
    done
    rm /tmp/$logname

	sed '$d' $TESTS_FILE > $TESTS_FILE.cut
    mv $TESTS_FILE.cut $TESTS_FILE

done;
