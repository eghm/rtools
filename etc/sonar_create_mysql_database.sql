# https://github.com/SonarSource/sonar/blob/master/sonar-application/src/main/assembly/extras/database/mysql/create_database.sql
#
# Create Sonar database and user.
#
# Command: mysql -u root -p < create_database.sql
#

CREATE DATABASE sonar_schema CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER 'sonar' IDENTIFIED BY 'sonar';
GRANT ALL ON sonar_schema.* TO 'sonar'@'%' IDENTIFIED BY 'sonar';
GRANT ALL ON sonar_schema.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar';
FLUSH PRIVILEGES;