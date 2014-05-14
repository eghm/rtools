C=0
for f in $1/*.jira
do
    echo "CiJiraGrouping $f"
    mkdir -p $1/JiraGroups/${C}
    ERR_MESSAGE=$(grep -A 1 "Error Message" $f)

#    ERR_MESSAGE=`printf "%q" $ERR_MESSAGE`
    echo "FOUND ${ERR_MESSAGE}"
#    grep -l "${ERR_MESSAGE}" $1/*.jira > $1/JiraGroups/${C}/JiraFiles.txt
#    echo "grep -l \"${ERR_MESSAGE}\" $1/*.jira" > $1/JiraGroups/${C}-grep.txt

    groovy matchStackTraceMessage.groovy "${ERR_MESSAGE}" $1 jira > $1/JiraGroups/${C}/JiraFiles.txt

    for line in $(cat $1/JiraGroups/${C}/JiraFiles.txt)
    do
	    cp $1/$line $1/JiraGroups/${C}/
	done  
    let C=C+1
done

# http://code.google.com/p/fdupes/
export FDUPES=$(fdupes -v)
if [ -z "$FDUPES" ]
then
  echo "fdupes not installed, http://code.google.com/p/fdupes/"
  exit
fi
fdupes -rf $1/JiraGroups | grep JiraFiles.txt > $1/JiraGroups/JiraFilesDups.txt

for line in $(cat $1/JiraGroups/JiraFilesDups.txt)
do
    DUP_DIR=$(dirname $line)
    echo "removing duplicate directory $DUP_DIR"
    rm $DUP_DIR/JiraFiles.txt
    find $DUP_DIR -name '*.jira' -exec rm {} \;
#    rm $DUP_DIR/*.jira
    rmdir $DUP_DIR
done  


find $1/JiraGroups -name '*.jira' > $1/JiraGroups/JiraFilesIdentified.txt

for line in $(cat $1/JiraGroups/JiraFilesIdentified.txt)
do
    JIRA_FILE=$(basename $line)
    rm "$1/$JIRA_FILE"
done  

cp $1/*.KULRICE $1/JiraGroups/
