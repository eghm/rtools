# version, db root password, db user, db pass
cd $R_HOME/$1

echo -e "\nCreating mysql DBs $1test, $1wip, $1clean"
mysqlCreateDB.sh $1test $2 

mysql -u root -p$2 $1test < scripts/ddl/rice-test-tables-mysql.sql

mysqlCreateDB.sh $1wip $2
mysqlCreateDB.sh $1clean $2

mvn-impex.sh $1wip $2 $3 $4
mvn-impex.sh $1clean $2 $3 $4
mvn-impex.sh $1test $2 $3 $4

rSquirrel.sh $1 wip $3 $4
rSquirrel.sh $1 clean $3 $4
rSquirrel.sh $1 test $3 $4

rSqlRest.sh $1wip $3 $4

#mysql -u root -p$2 $1test < scripts/ddl/rice-test-tables-mysql.sql
