# $1 optional line to be appended to CATALINA_OPTS_DEFAULT.txt and set as CATALINA_OPTS for the startup.sh call
$CATALINA_HOME/bin/shutdown.sh
sleep 60
export T_LOGS=$CATALINA_HOME/logs
if [ -e $T_LOGS/catalina.pid ]
then
    C_PID=$(cat $T_LOGS/catalina.pid)
    echo "$T_LOGS/catalina.pid exists!  Tomcat didn't shutdown cleanly.  Killing $C_PID"
    kill -9 $C_PID
    rm $T_LOGS/catalina.pid
fi

cd $T_LOGS ; mkdir -p bak ; mv *.out bak/ ; mv *.log bak/ ; mv *.txt bak/ ; mv *.hprof bak/ ; mv *.hprof.* /bak
cd

echo "$CATALINA_OPTS" > CATALINA_OPTS_DEFAULT.txt
export DTS=$(date +%Y-%m-%d/%H-%M)
export DTS_LOGS=$T_LOGS/$DTS
mkdir -p $DTS_LOGS
echo "DTS $DTS"
echo "$DTS" > ~/dts.txt

if [ -z "$1" ]
then
    export CATALINA_OPTS_DEFAULT=$(cat CATALINA_OPTS_DEFAULT.txt)
    export CATALINA_OPTS="$CATALINA_OPTS $1"
fi
echo "$CATALINA_OPTS" > CATALINA_OPTS.txt

$CATALINA_HOME/bin/startup.sh
sleep 120
