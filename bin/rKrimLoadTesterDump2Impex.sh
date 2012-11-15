# user, password, db
for f in $(cat $R_HOME/rtools/etc/LoadTesterTables.txt) ; do 
    echo "s|TABLENAME|$f|g" > $f-sed.sed
    echo "s|TABLENAME|$f|g" > $f-sedunderscore.sed
    sed -f $f-sedunderscore.sed $R_HOME/rtools/etc/mysqlTable.xslt > mysql$f.xslt

    sed -f $f-sed.sed $R_HOME/rtools/etc/tabledumptemplate.sh > $f-Dump2Impex.sh
    rm $f-sed.sed
    rm $f-sedunderscore.sed
    chmod 755 $f-Dump2Impex.sh
    ./$f-Dump2Impex.sh $*
    rm mysql$f.xslt
    rm $f-Dump2Impex.sh
    perl $R_HOME/rtools/bin/mysqldumpdateformat.pl -f $f.$3.impex.xml > $f.tmp.xml
    sed -f $R_HOME/rtools/etc/MysqlDumpDates.sed $f.tmp.xml > $f.xml
	rm $f.tmp.xml
	rm $f.$3.impex.xml
done
