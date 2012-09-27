echo "creating config/ide/intellij/.idea/runConfigurations/ from ../rtools/etc/rice_sampleapp*.xml"

echo "s|-Xms512m|-Dlog4j.configuration=$R_HOME/$1/$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-sampleapp-config.xml -Xms512m|g" > .rdev/$1-intellij-sampleapp-config.sed
echo "s|-Xms512m|-Dlog4j.configuration=$R_HOME/$1/$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-standalone-config.xml -Xms512m|g" > .rdev/$1-intellij-standalone-config.sed
echo "s|-Xms512m|-Dlog4j.configuration=$R_HOME/$1/$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-serviceregistry-config.xml -Xms512m|g" > .rdev/$1-intellij-serviceregistry-config.sed

sed -f .rdev/$1-intellij-sampleapp-config.sed ../rtools/etc/rice_sampleapp__jetty_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_7_.xml
sed -f .rdev/$1-intellij-sampleapp-config.sed ../rtools/etc/rice_sampleapp__jetty_8_.xml > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_8_.xml
sed -f .rdev/$1-intellij-sampleapp-config.sed ../rtools/etc/rice_sampleapp__tomcat_6_.xml > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_6_.xml
sed -f .rdev/$1-intellij-sampleapp-config.sed ../rtools/etc/rice_sampleapp__tomcat_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_7_.xml

sed -f .rdev/$1-intellij-standalone-config.sed ../rtools/etc/rice_standalone__jetty_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_7_.xml
sed -f .rdev/$1-intellij-standalone-config.sed ../rtools/etc/rice_standalone__jetty_8_.xml > config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_8_.xml
sed -f .rdev/$1-intellij-standalone-config.sed ../rtools/etc/rice_standalone__tomcat_6_.xml > config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_6_.xml
sed -f .rdev/$1-intellij-standalone-config.sed ../rtools/etc/rice_standalone__tomcat_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_7_.xml

#sed -f .rdev/$1-intellij-serviceregistry-config.sed ../rtools/etc/rice_serviceregistry__jetty_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__jetty_7_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed ../rtools/etc/rice_serviceregistry__jetty_8_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__jetty_8_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed ../rtools/etc/rice_serviceregistry__tomcat_6_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__tomcat_6_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed ../rtools/etc/rice_serviceregistry__tomcat_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__tomcat_7_.xml
