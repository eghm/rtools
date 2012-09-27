if [ -f web/src/main/resources/spy.properties ]
then
    echo web/src/main/resources/spy.properties already exists, skipping
else
	if [ ! -e /java/drivers/p6spy.jar ]
	then
	    echo "p6spy.jar not found in /java/drivers/ not configuring for p6spy.jar for more information see https://wiki.kuali.org/display/KULRICE/Break+on+execution+of+a+certain+SQL+query"
	    exit
    fi
    echo "creating web/src/main/resources/spy.properties from ../rtools/etc/spy.properties"
	echo "s|logfile=/java/drivers/spy.log|logfile=$R_HOME/logs/$1/spy.log|g" > .rdev/$1-spy.sed
    sed -f .rdev/$1-spy.sed ../rtools/etc/spy.properties > web/src/main/resources/spy.properties
    touch ../logs/$1/spy.log
fi
