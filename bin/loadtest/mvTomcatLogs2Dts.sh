$CATALINA_HOME/bin/shutdown.sh
sleep 60
export T_LOGS=$CATALINA_HOME/logs
if [ -e $T_LOGS/catalina.pid ]
then
    echo "$T_LOGS/catalina.pid exists!  Tomcat didn't shutdown cleanly."
    # TODO kill with threaddump
    exit
fi

export DTS=$(cat ~/dts.txt)
export T_LOGS=$CATALINA_HOME/logs
export DTS_LOGS=$T_LOGS/$DTS

mv $T_LOGS/catalina.out $DTS_LOGS/ ; mv $T_LOGS/*.log $DTS_LOGS/ ; mv $T_LOGS/localhost*.txt $DTS_LOGS/ ; mv $T_LOGS/*.hprof $DTS_LOGS/
# start tomcat backup for wget of logs
$CATALINA_HOME/bin/startup.sh
rm ~/dts.txt
