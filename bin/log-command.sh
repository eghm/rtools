if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

export rDir=${PWD##*/}
export DTS=$(date +%Y%m%d%H%M)

if [ "$rDir" = "$R_HOME" ]
then
	echo "Usage: run from a directory created using rDev.sh"
	exit
fi

if [ ! -e $R_HOME/logs/$rDir ]
then
    mkdir -p $R_HOME/logs/$rDir/
fi

touch $R_HOME/logs/$rDir/$1.$DTS.out 
ln -s $R_HOME/logs/$rDir/$1.$DTS.out $1.$DTS.out
echo "$2 $3 $4 $5 $6 $7 $8 $9" >> $1.$DTS.out
$2 $3 $4 $5 $6 $7 $8 $9  >> $1.$DTS.out 2>&1
