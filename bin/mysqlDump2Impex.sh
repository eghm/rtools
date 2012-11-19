# user, password, db
# mysqlTables.txt can be created with mysqlShowTables user password db
for f in $(cat $R_HOME/rtools/etc/mysqlTables.txt) ; do 
    echo "s|TABLENAME|$f|g" > $f-sed.sed
    echo "s|TABLENAME|$f|g" > $f-sedunderscore.sed

    sed -f $f-sedunderscore.sed $R_HOME/rtools/etc/mysqlTable.xslt > mysql$f.xslt
    sed -f $f-sed.sed $R_HOME/rtools/etc/mysqlDump2ImpexTemplate.sh > $f-Dump2Impex.sh

    rm $f-sed.sed
    rm $f-sedunderscore.sed

    chmod 755 $f-Dump2Impex.sh
    ./$f-Dump2Impex.sh $*

    rm mysql$f.xslt
    rm $f-Dump2Impex.sh

    perl $R_HOME/rtools/bin/mysqlDump2ImpexDateFormat.pl -f $f.$3.impex.xml > $f.$3.tmp.xml
    sed -f $R_HOME/rtools/etc/mysqlDump2ImpexReplacements.sed $f.$3.tmp.xml > $f.$3.impex.xml

	rm $f.$3.tmp.xml

done

find ./ -maxdepth 1 -empty -exec rm {} \;
