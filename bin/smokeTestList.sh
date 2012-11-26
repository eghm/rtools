# rice version       remote.public.url remote.driver.saucelabs.user remote.driver.saucelabs.key remote.driver.saucelabs.version remote.driver.saucelabs.platform remote.driver.saucelabs.browser it.test remote.public.user rice.version 

#USE LegacyITsUsers.txt with expanded list of saucelabs ids
rm saucelabs.looped

export SAUCE_NUM=$(wc -l saucelabs.csv.expanded | cut -c 1-9)
export TEST_NUM=$(wc -l LegacyITsUsers.txt | cut -c 1-9)
export SAUCE_LOOPS=$(($TEST_NUM/$SAUCE_NUM))
export SAUCE_MOD=$(expr $TEST_NUM % $SAUCE_NUM)

while [  $SAUCE_LOOPS -gt 0 ]; do
    cat  saucelabs.csv.expanded >> saucelabs.looped;
	let SAUCE_LOOPS-=1
done
head -n $SAUCE_MOD saucelabs.csv.expanded >> saucelabs.looped

paste -d , LegacyITsUsers.txt saucelabs.looped
