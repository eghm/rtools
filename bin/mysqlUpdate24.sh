# db, user, password
upgrade_path_24=scripts/upgrades/2.3\ to\ 2.4/db-updates
echo "Upgrading $upgrade_path_24"

if [ -d "$upgrade_path_24" ]
then
	echo "Applying $upgrade_path2_4 MySQL upgrade scripts if these error out they have problem been applied to master"

# Don't import this script, not ready for general consumption yet, part of the history work	
#	echo "$upgrade_path_24/mysql-2013-06-28.sql"
#	mysql -u $2 -p$3 --database $1 <  "$upgrade_path_24/mysql-2013-06-28.sql"

	echo "$upgrade_path_24/mysql-2013-09-21.sql"
	mysql -u $2 -p$3 --database $1 <  "$upgrade_path_24/mysql-2013-09-21.sql"	
fi	