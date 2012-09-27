echo "drop database $1;" > $1dropDB.sql
mysql -u root -p$2 < $1dropDB.sql
#rm $1dropDB.sql