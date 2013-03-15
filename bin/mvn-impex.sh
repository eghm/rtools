# db name, db root password, rice db name, rice db password
# impex is different enough doing it via mvn-named-log has proved difficult
export rDir=${PWD##*/}
export DTS=$(date +%Y%m%d%H%M)
export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

if [ "$rDir" = "r" ]
then
	echo "Usage: run from a directory created using rDev.sh"
	exit
fi

mkdir -p $R_HOME/logs/$rDir/

if [ ! -e $R_HOME/logs/$rDir/svndiff.$DTS.out ]
then
    touch $R_HOME/logs/$rDir/svndiff.$DTS.out 
    ln -s $R_HOME/logs/$rDir/svndiff.$DTS.out svndiff.$DTS.out 
fi
echo "======================another diff================" >> svndiff.$DTS.out
svn diff >> svndiff.$DTS.out

if [ ! -e $R_HOME/logs/$rDir/svndiff.$DTS.out ]
then
    touch $R_HOME/logs/$rDir/impex.$DTS.out 
    ln -s $R_HOME/logs/$rDir/impex.$DTS.out impex.$DTS.out 
fi

ln -s $R_HOME/logs/$rDir/impex.$DTS.out impex.$DTS.out 
cd db/impex/master/
mvn -version >> ../../../impex.$DTS.out

echo -e "\nImpexing $1. tail -f $R_HOME/logs/$rDir/impex.$DTS.out to follow progress."
echo "mvn install -Pdb,mysql -Dimpex.url=jdbc:mysql://localhost:3306/$1 -Dimpex.database=$1 -Dimpex.username=$3 -Dimpex.password=$4 -Dimpex.dba.password=$2 $5 $6 $7 $8 $9"  >> ../../../impex.$DTS.out
mvn install -Pdb,mysql -Dimpex.url=jdbc:mysql://localhost:3306/$1 -Dimpex.database=$1 -Dimpex.username=$3 -Dimpex.password=$4 -Dimpex.dba.password=$2 $5 $6 $7 $8 $9 >> ../../../impex.$DTS.out 2>&1
cd ../../..
tail -n 15 impex.$DTS.out

#mvn-named-log.sh impex install -Pdb,mysql -Dimpex.dba.url=jdbc:mysql://localhost:3306 -Dimpex.mysql.default.url=jdbc:mysql://localhost:3306/$1 -Dimpex.database=$1 -Dimpex.username=rice -Dimpex.password=rice -Dimpex.mysql.dba.password=$2 -Dimpex.dba.password=$2


