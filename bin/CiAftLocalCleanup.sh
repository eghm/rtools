# JenkinsResults directory

find $1/JiraGroups -name 'JiraFiles.txt' -exec rm {} \;

find $1/JiraGroups -name '*.jira' > AftsLocalList.txt

for f in $(cat AftsLocalList.txt) ; do 
    if grep -q "Failures: 0, Errors: 0, Skipped: 0" $f.local.out ; then
	    mkdir -p $1/PassedLocally
        PASSED_DIR=$(dirname $f)
        NEW_DIR=$(basename $PASSED_DIR)
        mv $PASSED_DIR $1/PassedLocally/$NEW_DIR
    fi
done


