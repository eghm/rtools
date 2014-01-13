# JenkinsResults directory

find $1/JiraGroups -name 'JiraFiles.txt' -exec rm {} \;

find $1/JiraGroups -name '*.jira' > AftsLocalList.txt

for f in $(cat AftsLocalList.txt) ; do 
    if grep -q "Tests run: 1, Failures: 0, Errors: 0, Skipped: 0" $f.local.out ; then
        rm $f.local.out
        rm $f
    fi
done

find $1/JiraGroups -empty -type d -delete


