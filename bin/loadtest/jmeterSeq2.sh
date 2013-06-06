# $1 server, $2 jmeter test name without the .jmx $3 number of threads $4 number of loops $5 ramp seconds $6 java agent line to be appended to CATALINA_OPTS
if [ ! -e "$2".jmx ] 
then
	echo "$2.jmx doesn't exist, exiting."
	exit
fi

parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/loadtest/mkDtsTomcatLogDir.sh $6
scp tomcat@$1:dts.txt .
wget http://$1/tomcat/logs/env.jsp -O env.html
cat dts.txt
$JMETER_HOME/bin/jmeter.sh -n -t $2.jmx -Jthreads=$3 -Jloops=$4 -Jrampseconds=$5
sleep 120
parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/loadtest/mvTomcatLogs2Dts.sh
$R_HOME/rtools/bin/loadtest/client2.sh $1 $3 $4 $5
