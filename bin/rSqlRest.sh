# TODO per version installation of sqlrest (sqlrest-version)
rSqlRestInstall.sh

export DBNAME=$1$2
export DBUSER=$3
export DBPASS=$4
export DBSERVER=$5
if [ -z "$5" ]
then
	export DBSERVER=localhost
fi
export DBPORT=$6
if [ -z "$6" ]
then
	export DBPORT=3306
fi

echo "creating .rdev/$1-sqlrest-$2.sed"
echo "s|DBNAME|$DBNAME|g" > .rdev/$1-sqlrest-$2.sed
echo "s|DBUSER|$DBUSER|g" >> .rdev/$1-sqlrest-$2.sed
echo "s|DBPASS|$DBPASS|g" >> .rdev/$1-sqlrest-$2.sed
echo "s|DBSERVER|$DBSERVER|g" >> .rdev/$1-sqlrest-$2.sed
echo "s|DBPORT|$DBPORT|g" >> .rdev/$1-sqlrest-$2.sed
echo "sed -f .rdev/$1-sqlrest-$2.sed $R_HOME/rtools/etc/sqlrestconf.xml > sqlrestconf.xml"
sed -f .rdev/$1-sqlrest-$2.sed $R_HOME/rtools/etc/sqlrestconf.xml > sqlrestconf.xml

if [ -z "$CATALINA_HOME" ]
then
	exit
fi

cp -f sqlrestconf.xml "$CATALINA_HOME/webapps/sqlrest/WEB-INF/"