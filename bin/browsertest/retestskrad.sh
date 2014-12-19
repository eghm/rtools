# url, saucelabs user, saucelabs key, rice version, kuali user, result file directory
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

# assumed project is in $R_HOME
cd $R_HOME/$4

# DTS to keep track of output, note all log files with have the DTS at time of start.
export DTS=$(date +%Y%m%d%H%M)

# this doesn't really work, start it by hand in another terminal
#/bin/bash -c "$R_HOME/rtools/bin/browsertest/saucelabsdownload.sh $R_HOME/$4 rice-framework/krad-sampleapp/web/"

# results files are created by the browsertestresults perl script
for f in $(ls -1 $6/*.results) ; do

    # get saucelabs details for re-run
    export SAUCE_OS=$(echo  $f | cut -d- -f 2);
    export SAUCE_BROWSER=$(echo  $f | cut -d- -f 3);	
    export SAUCE_VERSION=$(echo  $f | cut -d- -f 4);
		
    # get failed tests for re-run
    # TODO for each (there is 1 test method for each test class here
    grep failed $f | cut -d' ' -f 1 > rerun.txt    

    while [ -s rerun.txt ] 
    do

        export TEST_CLASS=$(tail -n 1 rerun.txt | cut -d. -f 1);
        export TEST_METHOD=$(tail -n 1 rerun.txt | cut -d. -f 2);

        echo "$TEST_CLASS#$TEST_METHOD";

        # setup ../logs with symlinks
        export logname=$1-$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$5-$DTS
        touch ../logs/$4/$logname.out 
        ln -s ../logs/$4/$logname.out $logname.out
        date >> $logname.out
        mvn -version  >> $logname.out
        echo "MAVEN_OPTS=$MAVEN_OPTS" >> $logname.out

        # Run the test, logging the output, touch /tmp/$logname used to make sure job has fully completed
        echo "mvn -f rice-framework/krad-sampleapp/web/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dsaucelabs.user=$2 -Dsaucelabs.key=$3 -Dsaucelabs.browser.version=$SAUCE_VERSION -Dsaucelabs.platform=$SAUCE_OS -Dsaucelabs.browser=$SAUCE_BROWSER -Duser=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dsaucelabs.download.scripts=true -Dit.test=$TEST_CLASS#$TEST_METHOD $7 $8 $9 >> $logname.out"
        ( mvn -f rice-framework/krad-sampleapp/web/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dsaucelabs.user=$2 -Dsaucelabs.key=$3 -Dsaucelabs.browser.version=$SAUCE_VERSION -Dsaucelabs.platform=$SAUCE_OS -Dsaucelabs.browser=$SAUCE_BROWSER -Dremote.public.user=$5 -Drice.version=$4 -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dsaucelabs.download.scripts=true -Dit.test=$TEST_CLASS#$TEST_METHOD $7 $8 $9 >> $logname.out 2>&1 && touch /tmp/$logname )
        date >> $logname.out

        # give job a chance to be fully completed
        while [ ! -e /tmp/$logname ]
        do
    	    sleep 10;
        done;
        rm /tmp/$logname

        # remove the last line of the rerun.txt
        sed '$d' rerun.txt > rerun.txt.cut
        mv rerun.txt.cut rerun.txt	

    done;
	
done;

# sleep to give seperate download script chance to complete last file
sleep 30 

