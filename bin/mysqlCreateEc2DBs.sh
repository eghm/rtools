cd $R_HOME/$1

echo "creating EC2 DBs $1test-jdk7, $1test-bittronix, $1test-bittronix-jdk7, and $1clean (as a reference if needed)"
mysqlCreateDB.sh $1clean $2
mysqlCreateDB.sh $1test-jdk7 $2
mysqlCreateDB.sh $1test-bittronix $2
mysqlCreateDB.sh $1test-bittronix-jdk7 $2

# we don't create the test table in clean as clean is for reference only
mysql -u root -p$2 $1test-jdk7 < scripts/ddl/rice-test-tables-mysql.sql
mysql -u root -p$2 $1test-bittronix < scripts/ddl/rice-test-tables-mysql.sql
mysql -u root -p$2 $1test-bittronix-jdk7 < scripts/ddl/rice-test-tables-mysql.sql

mvn-impex.sh $1clean $2 $3 $4
mvn-impex.sh $1test-jdk7 $2 $3 $4
mvn-impex.sh $1test-bittronix $2 $3 $4
mvn-impex.sh $1test-bittronix-jdk7 $2 $3 $4

#mysql -u root -p$2 $1test < scripts/ddl/rice-test-tables-mysql.sql
