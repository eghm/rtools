if [ ! -e $R_HOME/$1 ]
then
	echo "$R_HOME/$1 does not exist."
	exit;
fi
cd $R_HOME/$1
mysqlDropDBs.sh $1 $2 
cd $R_HOME
deleteRevision.sh $1
