echo "creating config/ide/intellij/.idea/runConfigurations/ from ../rtools/etc/rice_sampleapp*.xml"

echo "s|-Xms512m|-Dlog4j.configuration=$R_HOME/$1/$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-sampleapp-config.xml -Xms512m|g" > .rdev/$1-intellij-sampleapp-config.sed
echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-sampleapp-config.sed
echo "s|Unnamed_rice_3|sampleapp_$1|g" >> .rdev/$1-intellij-sampleapp-config.sed

echo "s|-Xms512m|-Dlog4j.configuration=$R_HOME/$1/$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-standalone-config.xml -Xms512m|g" > .rdev/$1-intellij-standalone-config.sed
echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-standalone-config.sed
echo "s|Unnamed_rice_3|standalone_$1|g" >> .rdev/$1-intellij-standalone-config.sed

echo "s|-Xms512m|-Dlog4j.configuration=$R_HOME/$1/$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-serviceregistry-config.xml -Xms512m|g" > .rdev/$1-intellij-serviceregistry-config.sed

echo "s|RVERSION|$1|g" > .rdev/$1-intellij-rversion.sed

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

sed -f .rdev/$1-intellij-rversion.sed ../rtools/etc/XMLIngesterLegacyIT.xml > config/ide/intellij/.idea/runConfigurations/XMLIngesterLegacyIT.xml
sed -f .rdev/$1-intellij-rversion.sed ../rtools/etc/LoginLogoutLegacyIT-HUB.xml > config/ide/intellij/.idea/runConfigurations/LoginLogoutLegacyIT-HUB.xml
