# user, password, rversion
cd $R_HOME/$3
echo "empty tables produce unable to parse start tag expected, etc."
mysqlDump2Impex.sh $1 $2 $3wip
mysqlDump2Impex.sh $1 $2 $3clean
impexDiff.sh $3wip $3clean


