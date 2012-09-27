echo "drop database $1;" > .rdev/$1-DB-drop.sql
echo "create database $1;" > .rdev/$1-DB-create.sql
mysql -u root -p$2 < .rdev/$1-DB-create.sql

