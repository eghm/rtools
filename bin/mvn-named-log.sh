if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

export rDir=${PWD##*/}
export DTS=$(date +%Y%m%d%H%M)
export M2_REPO=/java/m2/r

if [ "$rDir" = "$R_HOME" ]
then
	echo "Usage: run from a directory created using rDev.sh"
	exit
fi

if [ ! -e $R_HOME/logs/$rDir ]
then
    mkdir -p $R_HOME/logs/$rDir/
fi

export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m -XX:ErrorFile=$R_HOME/logs/$rDir/hs_err_$DTS.log"
#export MAVEN_OPTS="-Xms2048m -Xmx2048m -XX:MaxPermSize=1024m -XX:ErrorFile=$R_HOME/logs/$rDir/hs_err_$DTS.log"

svndiff.sh

touch $R_HOME/logs/$rDir/$1.$DTS.out
ln -s $R_HOME/logs/$rDir/$1.$DTS.out $1.$DTS.out 
mvn -version >> $1.$DTS.out
echo "MAVEN_OPTS=$MAVEN_OPTS" >> $1.$DTS.out
echo "tail -f $R_HOME/logs/$rDir/$1.$DTS.out to watch progress."
echo "mvn $2 $3 $4 $5 $6 $7 $8 $9 -Dlog4j.debug=true -Dalt.config.location=$R_HOME/$rDir/$rDir-common-test-config.xml" >> $1.$DTS.out
mvn $2 $3 $4 $5 $6 $7 $8 $9 -Dlog4j.debug=true -Dalt.config.location=$R_HOME/$rDir/$rDir-common-test-config.xml >> $1.$DTS.out 2>&1
echo -e "\nSee full log at $R_HOME/logs/$rDir/$1.$DTS.out $1.$DTS.out"
tail -n 40 $1.$DTS.out
