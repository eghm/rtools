# db, user, password
upgrade_path_24=scripts/upgrades/2.3\ to\ 2.4/db-updates
echo "Upgrading $upgrade_path_24"

if [ -d "$upgrade_path_24" ]
then
	echo "Applying $upgrade_path2_4 MySQL upgrade scripts if these error out they have problem been applied to master"
	
#	echo "$upgrade_path_24/mysql-2013-06-28.sql"
#	mysql -u $2 -p$3 --database $1 <  "$upgrade_path_24/mysql-2013-06-28.sql"
#   ERROR 1064 (42000) at line 17: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') ENGINE InnoDB CHARACTER SET utf8 COLLATE utf8_bin' at line 16

	echo "$upgrade_path_24/2013-08-09_mysql.sql"
	mysql -u $2 -p$3 --database $1 <  "$upgrade_path_24/2013-08-09_mysql.sql"

	echo "$upgrade_path_24/2013-08-20-travel-data-fix-mysql.sql"
	mysql -u $2 -p$3 --database $1 <  "$upgrade_path_24/2013-08-20-travel-data-fix-mysql.sql"

	echo "$upgrade_path_24/2013-08-22-travel-data-fix-mysql.sql"
	mysql -u $2 -p$3 --database $1 <  "$upgrade_path_24/2013-08-22-travel-data-fix-mysql.sql"	
fi	