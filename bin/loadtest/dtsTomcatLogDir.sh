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
export DTS_LOGS=$T_LOGS/$DTS

if [ -z "$DTS" ]
then
    export DTS_LOGS=$T_LOGS/bak
	mkdir -p $DTS_LOGS
fi

mv $T_LOGS/catalina.out $DTS_LOGS/ ; mv $T_LOGS/*.log $DTS_LOGS/ ; mv $T_LOGS/localhost*.txt $DTS_LOGS/ ; mv $T_LOGS/*.hprof $DTS_LOGS/

# start tomcat backup for wget of logs
$CATALINA_HOME/bin/startup.sh
# wait for tomcat to be up
sleep 120

export DTS=$(date +%Y-%m-%d/%H-%M)
export DTS_LOGS=$T_LOGS/$DTS
mkdir -p $DTS_LOGS
echo "DTS $DTS"
echo "$DTS" > ~/dts.txt
