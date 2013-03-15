echo "drop database $1;" > .rdev/$1-DB-drop.sql
echo "create database $1;" > .rdev/$1-DB-create.sql
mysql -u $2 -p$3 < .rdev/$1-DB-create.sql

