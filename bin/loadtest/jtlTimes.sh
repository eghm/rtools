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

#        echo "# $COUNTER"
#        echo "grep lb=.$JTL_PAGE $COUNTER/$JTL_FILE | cut -d\\\" -f2"
        grep lb=.$JTL_PAGE $COUNTER/$JTL_FILE | cut -d\" -f2

        COUNTER=$((COUNTER + 1))

    done 

done 

# command to put piped results into a comma delimited list
# tr '\n' , < 2014-06-18-times.txt
