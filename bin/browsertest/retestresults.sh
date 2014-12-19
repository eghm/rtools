#!/bin/bash
# Requires that the out file results have been processed with a browsertestresults
echo -e "START\n"
for f in $(ls -1 $1/*.results) ; do
    echo -e "$f";

    # cut and get all the fields before the last -
    export RESULT_FILE_BASE=$(echo $f | cut -d- -f 1-5);
    echo -e "$RESULT_FILE_BASE";

    FIRST="FALSE";
    FIRST_RESULT="";

    # create sed files for all but the first listing using the cut value above
    for g in $(ls -1 $RESULT_FILE_BASE*.out.results) ; do
        rm $g.sed

        echo -e "G: $g";

        if [ "$FIRST" == "TRUE" ] ;
        then

            TEST="";
            for h in $(grep test $g) ; do 
                echo -e "H: $h"
                if [[ $h == *.test* ]] ;
                then
                    TEST=$h;
                elif [ $h != "failed" ] ;
                then
                    echo -e "s|$TEST failed|$TEST $h|g"
                    echo -e "s|$TEST failed|$TEST $h|g" >> $g.sed        
#                    echo -e "s|$(echo $h | cut -d' ' -f 1) failed|$h passed|g"
#                    echo -e "s|$(echo $h | cut -d' ' -f 1) failed|$h passed|g" >> $g.sed        
                fi

            done;

        else

            FIRST_RESULT="$g";
            FIRST="TRUE";

        fi


    done;

    echo -e "FIRST_RESULT $g"

    # run the created sed files against the first cut value above
    let RUN_COUNT=0;
    for g in $(ls -1 $RESULT_FILE_BASE*.sed) ; do
        if [ $RUN_COUNT -eq 0 ] ; 
        then
            sed -f $g $FIRST_RESULT > $FIRST_RESULT.1
        else
            NEXT_COUNT=$RUN_COUNT;
            ((++NEXT_COUNT));
            echo -e "NEXT_COUNT $NEXT_COUNT"
            sed -f $g $FIRST_RESULT.$RUN_COUNT > $FIRST_RESULT.$NEXT_COUNT;
            rm $FIRST_RESULT.$RUN_COUNT
        fi
        ((++RUN_COUNT));
        echo -e "RUN_COUNT $RUN_COUNT"
    done;

    rm $FIRST_RESULT.sed
    mv $FIRST_RESULT.$RUN_COUNT $FIRST_RESULT.reresults

    FIRST_RESULTS="FALSE";
	
done;
