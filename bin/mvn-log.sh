if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

export rDir=${PWD##*/}
export DTS=$(date +%Y%m%d%H%M)
export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

if [ "$rDir" = "$R_HOME" ]
then
	echo "Usage: run from a directory created using rDev.sh"
	exit
fi

if [ ! -e $R_HOME/logs/$rDir ]
then
    mkdir -p $R_HOME/logs/$rDir/
fi

svndiff.sh

export logname=$1$2$3
touch $R_HOME/logs/$rDir/$logname.$DTS.out 
ln -s $R_HOME/logs/$rDir/$logname.$DTS.out $logname.$DTS.out
mvn -version  >> $logname.$DTS.out
echo "mvn $* -Dlog4j.configuration=$R_HOME/$rDir/$rDir-log4j.properties -Dalt.config.location=$R_HOME/$rDir/$rDir-common-test-config.xml" >> $logname.$DTS.out
mvn $* -Dlog4j.configuration=$R_HOME/$rDir/$rDir-log4j.properties -Dalt.config.location=$R_HOME/$rDir/$rDir-common-test-config.xml >> $logname.$DTS.out
cat $logname.$DTS.out
