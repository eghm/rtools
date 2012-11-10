# TODO per version installation of sqlrest (sqlrest-version)
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
	exit
fi

$R_HOME/rtools/bin/rSqlRestInstall.sh

export DBNAME=$1
export DBUSER=$2
export DBPASS=$3

export DBSERVER=$4
if [ -z "$4" ]
then
	export DBSERVER=localhost
fi

export DBPORT=$5
if [ -z "$5" ]
then
	export DBPORT=3306
fi

export DBDRIVER=$6
if [ -z "$6" ]
then
	export DBDRIVER=com.mysql.jdbc.Drvier
fi

export DBURL=$7
if [ -z "$7" ]
then
	export DBURL=jdbc:mysql://$DBSERVER:$DBPORT/$DBNAME
fi

if [ ! -e ".rdev" ]
then
	mkdir .rdev
	touch .rdev/safetodelete
fi

echo "creating .rdev/sqlrest-$DBNAME.sed"
echo "s|DBNAME|$DBNAME|g" > .rdev/sqlrest-$DBNAME.sed
echo "s|DBUSER|$DBUSER|g" >> .rdev/sqlrest-$DBNAME.sed
echo "s|DBPASS|$DBPASS|g" >> .rdev/sqlrest-$DBNAME.sed
echo "s|DBURL|$DBURL|g" >> .rdev/sqlrest-$DBNAME.sed
echo "sed -f .rdev/sqlrest-$DBNAME.sed $R_HOME/rtools/etc/sqlrestconf.xml > sqlrestconf-$DBNAME.xml"
sed -f .rdev/sqlrest-$DBNAME.sed $R_HOME/rtools/etc/sqlrestconf.xml > sqlrestconf-$DBNAME.xml

if [ -e ".rdev/safetodelete" ]
then
    rm .rdev/sqlrest-$DBNAME.sed
    rm .rdev/safetodelete
    rmdir .rdev
fi

if [ -z "$CATALINA_HOME" ]
then
	exit
fi

cp -f sqlrestconf-$DBNAME.xml "$CATALINA_HOME/webapps/sqlrest/WEB-INF/sqlrestconf.xml"