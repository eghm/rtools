cd db/impex/master/
mvn-named-log.sh impex clean install -Dlog4j.configuration=$R_HOME/$rDir/$rDir-log4j.properties -Dalt.config.location=$R_HOME/$rDir/$rDir-common-test-config.xml -Pdb,mysql -Dimpex.database=$1 -Dimpex.username=rice -Dimpex.password=rice -Dimpex.mysql.default.url=jdbc:mysql://localhost:3306/$1 -Dsql.plugin.enableAnonymousPassword=false -Dimpex.mysql.dba.password=$3 -Dimpex.dba.password=$3 -Dimpex.dba.url=jdbc:mysql://localhost:3306
cd ../../..


