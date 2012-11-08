export DBNAME=$1$2
export DBSERVER=$3
if [ -z "$3" ]
then
	export DBSERVER=localhost
fi
export DBPORT=$4
if [ -z "$4" ]
then
	export DBPORT=3306
fi


if [ ! -e "~/.squirrel-sql/SQLAliases23.xml.bak" ]
then
	cp ~/.squirrel-sql/SQLAliases23.xml ~/.squirrel-sql/SQLAliases23.xml.bak
fi
if [ ! -e "~/.squirrel-sql/SQLAliases23_treeStructure.xml.bak" ]
then
	cp ~/.squirrel-sql/SQLAliases23_treeStructure.xml ~/.squirrel-sql/SQLAliases23_treeStructure.xml.bak
fi
exit
# TODO this select isn't RIGHT!!!
export DBUID=$(xml sel -t -m "//Bean/name[contains(text(), '$DBNAME')]" -v "concat(//identifier/string, '')" ~/.squirrel-sql/SQLAliases23.xml)
echo "Deleting $DBUID for $DBSERVER:$DBPORT MySQL $DBNAME from ~/.squirrel-sql/SQLAliases23.xml and ~/.squirrel-sql/SQLAliases23_treeStructure.xml"
xml ed -d "//identifier/string[contains(text(), '$DBUID')]"  ~/.squirrel-sql/SQLAliases23.xml > ~/.squirrel-sql/SQLAliases23.xml.del
mv ~/.squirrel-sql/SQLAliases23.xml.del ~/.squirrel-sql/SQLAliases23.xml
xml ed -d "//aliasIdentifier/string[contains(text(), '$DBUID')]"  ~/.squirrel-sql/SQLAliases23_treeStructure.xml > ~/.squirrel-sql/SQLAliases23_treeStructure.xml.del
mv ~/.squirrel-sql/SQLAliases23_treeStructure.xml.del ~/.squirrel-sql/SQLAliases23_treeStructure.xml