# assumes archive from CI JMeter job has been unzipped and renamed to it's build number
for f in $(cat jtls.txt) ; do
    # build number to start from
    COUNTER=6

    JTL_FILE=$(echo $f | cut -d: -f1)   
    JTL_PAGE=$(echo $f | cut -d: -f2)   

    echo $(basename $JTL_FILE)

    # graph continous build numbers
    while [ -d $COUNTER ]
    do

        echo "$R_HOME/rtools/bin/loadtest/jmeterGraphs2.sh $(dirname $(pwd)/$COUNTER/$JTL_FILE) $(basename $JTL_FILE) $COUNTER --include-labels $JTL_PAGE --force-y 4000 --granulation 500"
        $R_HOME/rtools/bin/loadtest/jmeterGraphs2.sh $(dirname $(pwd)/$COUNTER/$JTL_FILE) $(basename $JTL_FILE) $COUNTER --include-labels $JTL_PAGE --force-y 4000 --granulation 500

        COUNTER=$((COUNTER + 1))

    done 

done 


