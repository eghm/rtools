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

echo -e "\nImpexing $2. tail -f $R_HOME/logs/$rDir/impex.$DTS.out to follow progress."
echo "mvn install -Pdb,oracle -Dimpex.dba.url=jdbc:oracle:thin:@$1:1521:xe -Dimpex.database=$2 -Dimpex.username=$4 -Dimpex.password=$5 -Dimpex.oracle.dba.password=$3 -Dimpex.dba.password=$6 $7 $8 $9"  >> ../../../impex.$DTS.out
mvn install -Pdb,oracle -Dimpex.dba.url=jdbc:oracle:thin:@$1:1521:xe -Dimpex.database=$2 -Dimpex.username=$4 -Dimpex.password=$5 -Dimpex.oracle.dba.password=$3 -Dimpex.dba.password=$6 $7 $8 $9 >> ../../../impex.$DTS.out 2>&1
cd ../../..
tail -n 15 impex.$DTS.out


