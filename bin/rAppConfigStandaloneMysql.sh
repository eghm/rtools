#if [ -f $1-standalone-config.xml ]
#then
#    echo $1-standalone-config.xml already exists, skipping
#else
    echo "creating $1-standalone-config.xml from rice-middleware/standalone/src/main/resources/org/kuali/rice/standalone/config/standalone-config.xml use it via -Dalt.config.location=$R_HOME/$1/$1-standalone-config.xml"
	echo "s|03/19/2007 01:59 PM|$1|g" > .rdev/$1-standalone-config.sed
    echo "s|<config>|<config><param name=\"useQuartzDatabase\">false</param><param name=\"rice.krad.dev.mode\">true</param><param name=\"rice.kr.additionalSpringFiles\">classpath:org/kuali/rice/krad/devtools/datadictionary/ReloadingDataDictionarySpringBeans.xml</param>|g" >> .rdev/$1-standalone-config.sed
    echo "s|RICE094DEV|$2|g" >> .rdev/$1-standalone-config.sed
    echo "s|<!-- Fill in Password Here! -->|$3|g" >> .rdev/$1-standalone-config.sed
    echo "s|jdbc:oracle:thin:@esdbk02.uits.indiana.edu:1521:KUALI|jdbc:mysql://localhost/$1wip|g" >> .rdev/$1-standalone-config.sed
    echo "s|Oracle9i|MySQL|g" >> .rdev/$1-standalone-config.sed
    echo "s|org.kuali.rice.core.framework.persistence.platform.OracleDatabasePlatform|org.kuali.rice.core.framework.persistence.platform.MySQLDatabasePlatform|g" >> .rdev/$1-standalone-config.sed

    if [ -e /java/drivers/p6spy.jar ]
	then 
        echo "s|oracle.jdbc.OracleDriver|com.p6spy.engine.spy.P6SpyDriver|g" >> .rdev/$1-standalone-config.sed
    else 
        echo "s|oracle.jdbc.OracleDriver|com.mysql.jdbc.Driver|g" >> .rdev/$1-standalone-config.sed
    fi

    echo "s|select 1 from dual|select 1|g" >> .rdev/$1-standalone-config.sed
    echo "s|Oracle|MySQL|g" >> .rdev/$1-standalone-config.sed
    echo "s|security/rice.keystore|/usr/local/rice/rice.keystore|g" >> .rdev/$1-standalone-config.sed
#    echo "s|||g" >> .rdev/$1-standalone-config.sed
#    echo "s|||g" >> .rdev/$1-standalone-config.sed
    echo "s|8080|8080|g" >> .rdev/$1-standalone-config.sed

    sed -f .rdev/$1-standalone-config.sed rice-middleware/standalone/src/main/resources/org/kuali/rice/standalone/config/standalone-config.xml > $1-standalone-config.xml

#fi