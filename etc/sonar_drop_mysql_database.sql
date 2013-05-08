# https://github.com/SonarSource/sonar/blob/master/sonar-application/src/main/assembly/extras/database/mysql/drop_database.sql
#
# Drop Sonar database and user.
#
# Command: mysql -u root -p < drop_database.sql
#

DROP DATABASE IF EXISTS sonar_schema;
DROP USER 'sonar'@'localhost';
DROP USER 'sonar'@'%';