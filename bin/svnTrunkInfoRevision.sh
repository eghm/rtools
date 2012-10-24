#!/bin/bash
# I use trunk in this way because I like to have a clean copy of trunk that I can point SVN tools at, use in diffs, anyway.
cd $R_HOME/trunk
svn update
svn info > svn.info.txt
export revision=$(grep -o -E 'Revision:.([[:digit:]].*)' svn.info.txt | cut -d ' ' -f 2)
mv svn.revision.txt svn.revision.last.txt
echo "$revision" > svn.revision.txt
export revision_last=$(grep -o -E '[[:digit:]]{5,}' svn.revision.last.txt)
export changed=$(grep $revision svn.revision.last.txt | wc -l)
echo "current revision: $revision last revision: $revision_last changed? $changed"

if [ "$changed" -gt 0 ]
then 
    echo "revision has not changed. $revision"
	exit 0
fi

if [ -e $R_HOME/$revision ]
then
    echo "revision $revision already exists!.  Is revision not changed logic correct?  Maybe you should modify svn.revision.txt to an earlier version."
	exit 0	
fi

rDev.sh $revision $1 $2 $3
cd $R_HOME/$revision
mvn-itest.sh
mvn-site.sh
cd target
echo "zipping site output to target/site.zip and then deleting site output directory"
zip -r site site/
rm -rf site/

# Jar reports
echo "running jar dependency reports"
cd $R_HOME/$revision
mvn-named-log.sh jar-versions-display-dependency-updates versions:display-dependency-updates
mvn-named-log.sh jar-dependency-analyze dependency:analyze
mvn-named-log.sh jar-dependency-analyze-dep-mgt dependency:analyze-dep-mgt
mvn-named-log.sh jar-dependency-analyze-only dependency:analyze-only
mvn-named-log.sh jar-dependency-analyze-report dependency:analyze-report
mvn-named-log.sh jar-dependency-analyze-duplicate dependency:analyze-duplicate

# Sonar reports
sonar_restart.sh
echo "running sonar reports"
mvn-named-log.sh mvn-sonar sonar:sonar

cd $R_HOME
#deleteRevisionAndDBs.sh $revision
