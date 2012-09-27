#!/bin/bash
cd $R_HOME/trunk
svn update
svn info > svn.info.txt
export revision=$(grep -o -E 'Revision:.([[:digit:]].*)' svn.info.txt | cut -d ' ' -f 2)
mv svn.revision.txt svn.revision.last.txt
echo "$revision" > svn.revision.txt
export revision_last=$(grep -o -E '[[:digit:]]{5,}' svn.revision.last.txt)
export changed=$(grep $revision svn.revision.last.txt | wc -l)
echo "current revision: $revision last revision: $revision_last changed? $changed"

if [ "$changed" -gt 0 ]; then 
    echo "revision has not changed. $revision"
	exit 0
fi

if [ -e $R_HOME/$revision ] then
    echo "revision $revision already exists!.  Is revision not changed logic correct?"
	exit 0	
fi

rDev.sh $revision $1
# TODO override ~kuali/ configs
cd $R_HOME/$revision
mvn-itest.sh
mvn-site.sh
cd target
zip -r site site/
rm -rf site/

# Jar reports
cd $R_HOME/$revision
mvn-log.sh versions:display-dependency-updates
mvn-log.sh dependency:analyze
mvn-log.sh dependency:analyze-dep-mgt
mvn-log.sh dependency:analyze-only
mvn-log.sh dependency:analyze-report
mvn-log.sh dependency:analyze-duplicate

# Sonar reports
mvn-log.sh sonar:sonar

cd $R_HOME
#deleteRevisionAndDBs.sh $revision
