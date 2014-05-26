if [ ! -e $R_HOME/$1 ]
then
	echo "$R_HOME/$1 does not exist."
	exit;
fi
crontab -l | grep -v "rdRsyncGit.sh $1"  | crontab -
cd $R_HOME/$1
mysqlDropDBs.sh $1 $2 
rSquirrelDelete.sh $1 wip
rSquirrelDelete.sh $1 test
rSquirrelDelete.sh $1 clean
sleep 10
cd $R_HOME
deleteRevision.sh $1
