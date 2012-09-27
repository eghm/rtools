#if [ -f $1-common-test-config.xml ]
#then
#    echo $1-common-test-config.xml already exists, skipping
#else
    echo "creating $1-common-test-config.xml from config/templates/common-test-config.template.xml"
    echo "s|<config>|<config><param name=\"useQuartzDatabase\">false</param>|g" > .rdev/$1-common-test-config.sed
# username
    echo "s|RICE094CI|$2|g" >> .rdev/$1-common-test-config.sed
# password
    echo "s|<!-- Fill in Password Here! -->|$3|g" >> .rdev/$1-common-test-config.sed
# db connection
    echo "s|jdbc:oracle:thin:@esdbk02.uits.indiana.edu:1521:KUALI|jdbc:mysql://localhost/$1test|g" >> .rdev/$1-common-test-config.sed
# db type
    echo "s|Oracle9i|MySQL|g" >> .rdev/$1-common-test-config.sed
# db platform
    echo "s|org.kuali.rice.core.framework.persistence.platform.OracleDatabasePlatform|org.kuali.rice.core.framework.persistence.platform.MySQLDatabasePlatform|g" >> .rdev/$1-common-test-config.sed
# db driver
#    echo "s|oracle.jdbc.OracleDriver|com.p6spy.engine.spy.P6SpyDriver|g" >> .rdev/$1-common-test-config.sed
    echo "s|oracle.jdbc.OracleDriver|com.mysql.jdbc.Driver|g" >> .rdev/$1-common-test-config.sed
# mysql test
    echo "s|select 1 from dual|select 1|g" >> .rdev/$1-common-test-config.sed
#    echo "s|Oracle|MySQL|g" >> .rdev/$1-common-test-config.sed
#    echo "s|||g" >> .rdev/$1-common-test-config.sed
#    echo "s|||g" >> .rdev/$1-common-test-config.sed
    echo "s|8080|8080|g" >> .rdev/$1-common-test-config.sed

    sed -f .rdev/$1-common-test-config.sed config/templates/common-test-config.template.xml > $1-common-test-config.xml
#fi

