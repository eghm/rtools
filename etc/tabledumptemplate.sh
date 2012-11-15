# user, password, db
mysqldump --xml -u $1 -p$2 $3 TABLENAME > TABLENAME.mysql.$3.xml
sed 's|TABLE_NAME|TABLENAME|' $R_HOME/rtools/etc/mysqlTable.xslt > mysqlTABLENAME.xslt
#create mysqlTABLENAME.xslt
xml tr $R_HOME/rtools/etc/mysql.xslt TABLENAME.mysql.$3.xml > TABLENAME.mysql.$3.tr.xml
xml tr mysqlTABLENAME.xslt TABLENAME.mysql.$3.tr.xml > TABLENAME.$3.impex.xml
rm TABLENAME.mysql.$3.tr.xml
rm TABLENAME.mysql.$3.xml
