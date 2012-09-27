echo "delete from krns_maint_lock_t WHERE MAINT_LOCK_ID=MAINT_LOCK_ID;" > $1-mysqlMaintUnlock.sql
mysql $1 -u root -p$2 < $1-mysqlMaintUnlock.sql > $1-mysqlMaintUnlock.txt
rm $1-mysqlMaintUnlock.sql
cat $1-mysqlMaintUnlock.txt
rm $1-mysqlMaintUnlock.txt