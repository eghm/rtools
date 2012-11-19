# TODO maybe better done sooner
# where db1 are those you are going to keep
# db1, db2
# mysqlTables.txt can be created with mysqlShowTables user password db
for f in $(cat $R_HOME/rtools/etc/mysqlTables.txt) ; do 
    if [ -z `diff $f.$1.impex.xml $f.$2.impex.xml` ]
	then
		rm $f.$1.impex.xml
		rm $f.$2.impex.xml 
	else 
		rm $f.$2.impex.xml 		
		mv $f.$1.impex.xml $f.xml
	fi
done

find . -maxdepth 1 -name '*.xml' -size 0 -exec rm {} \;
# 48 bytes is the data xml tag only
find . -maxdepth 1 -name '*.xml' -size 48 -exec rm {} \;
# sequence tables
find . -maxdepth 1 -name '*_S.xml' -exec rm {} \;
