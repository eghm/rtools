echo "show databases;" > mysqlShowDatabases.sql
mysql -u $1 -p$2 < mysqlShowDatabases.sql > mysqlDatabases.txt
rm mysqlShowDatabases.sql
cat mysqlDatabases.txt

