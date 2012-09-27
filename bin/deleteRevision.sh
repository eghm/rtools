if [ ! -e $R_HOME/$1 ]
then
	echo "$R_HOME/$1 does not exist."
	exit;
fi
export DTS=$(date +%Y%m%d%H%M)

cd $R_HOME/$1
git diff > ../$1.$DTS.patch
cd $R_HOME
rm -rf $R_HOME/$1
rm -rf /java/m2/$1
rm -rf /java/m2/k/$1

