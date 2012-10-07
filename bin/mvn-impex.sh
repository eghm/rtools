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

mkdir -p ../logs/$rDir/

if [ ! -e ../logs/$rDir/svndiff.$DTS.out ]
then
    touch ../logs/$rDir/svndiff.$DTS.out 
    ln -s ../logs/$rDir/svndiff.$DTS.out svndiff.$DTS.out 
fi
echo "======================another diff================" >> svndiff.$DTS.out
svn diff >> svndiff.$DTS.out

if [ ! -e ../logs/$rDir/svndiff.$DTS.out ]
then
    touch ../logs/$rDir/impex.$DTS.out 
    ln -s ../logs/$rDir/impex.$DTS.out impex.$DTS.out 
fi

cd db/impex/master/
mvn -version >> ../../../impex.$DTS.out
echo "mvn install -Pdb,mysql -Dimpex.dba.url=jdbc:mysql://localhost:3306 -Dimpex.mysql.default.url=jdbc:mysql://localhost:3306/$1 -Dimpex.database=$1 -Dimpex.username=$3 -Dimpex.password=$4 -Dimpex.mysql.dba.password=$2 -Dimpex.dba.password=$2 $5 $6 $7 $8 $9"  >> ../../../impex.$DTS.out
mvn install -Pdb,mysql -Dimpex.dba.url=jdbc:mysql://localhost:3306 -Dimpex.mysql.default.url=jdbc:mysql://localhost:3306/$1 -Dimpex.database=$1 -Dimpex.username=$3 -Dimpex.password=$4 -Dimpex.mysql.dba.password=$2 -Dimpex.dba.password=$2 $5 $6 $7 $8 $9 >> ../../../impex.$DTS.out
cd ../../..
cat impex.$DTS.out

#mvn-named-log.sh impex install -Pdb,mysql -Dimpex.dba.url=jdbc:mysql://localhost:3306 -Dimpex.mysql.default.url=jdbc:mysql://localhost:3306/$1 -Dimpex.database=$1 -Dimpex.username=rice -Dimpex.password=rice -Dimpex.mysql.dba.password=$2 -Dimpex.dba.password=$2


