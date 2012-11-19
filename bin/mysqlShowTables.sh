echo "show tables;" > showtables.sql
mysql -u $1 -p$2 $3 < showtables.sql > $3-tables.txt
rm showtables.sql
cat $3-tables.txt
