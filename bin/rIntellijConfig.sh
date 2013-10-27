echo "creating config/ide/intellij/.idea/runConfigurations/ from config/ide/intellij/.idea/runConfigurations/rice_sampleapp*.xml"

echo "s|-Xms512m|-Dlog4j.debug -Dalt.log4j.configuration=$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-krad-sampleapp-config.xml -Xms512m|g" > .rdev/$1-intellij-krad-sampleapp-config.sed
echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-krad-sampleapp-config.sed
echo "s|C:/apache-tomcat-6.0.29/bin/catalina.bat|\\\java\\\tomcats\\\6.0.33\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-krad-sampleapp-config.sed
echo "s|Unnamed_rice_3|sampleapp_$1|g" >> .rdev/$1-intellij-krad-sampleapp-config.sed

echo "s|-Xms512m|-Dlog4j.debug -Dalt.log4j.configuration=$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-sampleapp-config.xml -Xms512m|g" > .rdev/$1-intellij-sampleapp-config.sed
#echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-sampleapp-config.sed
echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-sampleapp-config.sed
echo "s|C:/apache-tomcat-6.0.29/bin/catalina.bat|\\\java\\\tomcats\\\6.0.33\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-sampleapp-config.sed
echo "s|Unnamed_rice_3|sampleapp_$1|g" >> .rdev/$1-intellij-sampleapp-config.sed

echo "s|-Xms512m|-Dlog4j.debug -Dalt.log4j.configuration=$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-standalone-config.xml -Xms512m|g" > .rdev/$1-intellij-standalone-config.sed
#echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-standalone-config.sed
echo "s|C:/apache-tomcat-7.0.8/bin/catalina.bat|\\\java\\\tomcats\\\7.0.22\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-standalone-config.sed
echo "s|C:/apache-tomcat-6.0.29/bin/catalina.bat|\\\java\\\tomcats\\\6.0.33\\\bin\\\catalina.sh|g" >> .rdev/$1-intellij-standalone-config.sed
echo "s|Unnamed_rice_3|standalone_$1|g" >> .rdev/$1-intellij-standalone-config.sed

echo "s|-Xms512m|-Dlog4j.debug -Dalt.log4j.configuration=$1-log4j.properties -Dalt.config.location=$R_HOME/$1/$1-serviceregistry-config.xml -Xms512m|g" > .rdev/$1-intellij-serviceregistry-config.sed

echo "s|RVERSION|$1|g" > .rdev/$1-intellij-rversion.sed

# old config/ide/intellij/.idea directory:
cp config/ide/intellij/.idea/runConfigurations/krad_sampleapp__tomcat_7_.xml config/ide/intellij/.idea/runConfigurations/krad_sampleapp__tomcat_7_.xml.orig
sed -f .rdev/$1-intellij-krad-sampleapp-config.sed config/ide/intellij/.idea/runConfigurations/krad_sampleapp__tomcat_7_.xml.orig > config/ide/intellij/.idea/runConfigurations/krad_sampleapp__tomcat_7_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_7_.xml config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_7_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_7_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_7_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_8_.xml config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_8_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_8_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__jetty_8_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_6_.xml config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_6_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_6_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_6_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_7_.xml config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_7_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_7_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_sampleapp__tomcat_7_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_7_.xml config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_7_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_7_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_7_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_8_.xml config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_8_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_8_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_standalone__jetty_8_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_6_.xml config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_6_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_6_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_6_.xml

cp config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_7_.xml config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_7_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_7_.xml.orig > config/ide/intellij/.idea/runConfigurations/rice_standalone__tomcat_7_.xml

#sed -f .rdev/$1-intellij-serviceregistry-config.sed config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__jetty_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__jetty_7_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__jetty_8_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__jetty_8_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__tomcat_6_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__tomcat_6_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__tomcat_7_.xml > config/ide/intellij/.idea/runConfigurations/rice_serviceregistry__tomcat_7_.xml

#sed -f .rdev/$1-intellij-rversion.sed config/ide/intellij/.idea/runConfigurations/XMLIngesterNavIT.xml > config/ide/intellij/.idea/runConfigurations/XMLIngesterNavIT.xml
#sed -f .rdev/$1-intellij-rversion.sed config/ide/intellij/.idea/runConfigurations/LoginLogoutWDIT.xml > config/ide/intellij/.idea/runConfigurations/LoginLogoutWDIT.xml
#sed -f .rdev/$1-intellij-rversion.sed config/ide/intellij/.idea/runConfigurations/IdentityPersonRoleWDIT-env1.xml > config/ide/intellij/.idea/runConfigurations/IdentityPersonRoleWDIT-env1.xml

# new .idea directory
cp .idea/runConfigurations/krad_sampleapp__tomcat_7_.xml .idea/runConfigurations/krad_sampleapp__tomcat_7_.xml.orig
sed -f .rdev/$1-intellij-krad-sampleapp-config.sed .idea/runConfigurations/krad_sampleapp__tomcat_7_.xml.orig > .idea/runConfigurations/krad_sampleapp__tomcat_7_.xml

cp .idea/runConfigurations/rice_sampleapp__jetty_7_.xml .idea/runConfigurations/rice_sampleapp__jetty_7_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed .idea/runConfigurations/rice_sampleapp__jetty_7_.xml.orig > .idea/runConfigurations/rice_sampleapp__jetty_7_.xml

cp .idea/runConfigurations/rice_sampleapp__jetty_8_.xml .idea/runConfigurations/rice_sampleapp__jetty_8_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed .idea/runConfigurations/rice_sampleapp__jetty_8_.xml.orig > .idea/runConfigurations/rice_sampleapp__jetty_8_.xml

cp .idea/runConfigurations/rice_sampleapp__tomcat_6_.xml .idea/runConfigurations/rice_sampleapp__tomcat_6_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed .idea/runConfigurations/rice_sampleapp__tomcat_6_.xml.orig > .idea/runConfigurations/rice_sampleapp__tomcat_6_.xml

cp .idea/runConfigurations/rice_sampleapp__tomcat_7_.xml .idea/runConfigurations/rice_sampleapp__tomcat_7_.xml.orig
sed -f .rdev/$1-intellij-sampleapp-config.sed .idea/runConfigurations/rice_sampleapp__tomcat_7_.xml.orig > .idea/runConfigurations/rice_sampleapp__tomcat_7_.xml

cp .idea/runConfigurations/rice_standalone__jetty_7_.xml .idea/runConfigurations/rice_standalone__jetty_7_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed .idea/runConfigurations/rice_standalone__jetty_7_.xml.orig > .idea/runConfigurations/rice_standalone__jetty_7_.xml

cp .idea/runConfigurations/rice_standalone__jetty_8_.xml .idea/runConfigurations/rice_standalone__jetty_8_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed .idea/runConfigurations/rice_standalone__jetty_8_.xml.orig > .idea/runConfigurations/rice_standalone__jetty_8_.xml

cp .idea/runConfigurations/rice_standalone__tomcat_6_.xml .idea/runConfigurations/rice_standalone__tomcat_6_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed .idea/runConfigurations/rice_standalone__tomcat_6_.xml.orig > .idea/runConfigurations/rice_standalone__tomcat_6_.xml

cp .idea/runConfigurations/rice_standalone__tomcat_7_.xml .idea/runConfigurations/rice_standalone__tomcat_7_.xml.orig
sed -f .rdev/$1-intellij-standalone-config.sed .idea/runConfigurations/rice_standalone__tomcat_7_.xml.orig > .idea/runConfigurations/rice_standalone__tomcat_7_.xml

#sed -f .rdev/$1-intellij-serviceregistry-config.sed .idea/runConfigurations/rice_serviceregistry__jetty_7_.xml > .idea/runConfigurations/rice_serviceregistry__jetty_7_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed .idea/runConfigurations/rice_serviceregistry__jetty_8_.xml > .idea/runConfigurations/rice_serviceregistry__jetty_8_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed .idea/runConfigurations/rice_serviceregistry__tomcat_6_.xml > .idea/runConfigurations/rice_serviceregistry__tomcat_6_.xml
#sed -f .rdev/$1-intellij-serviceregistry-config.sed .idea/runConfigurations/rice_serviceregistry__tomcat_7_.xml > .idea/runConfigurations/rice_serviceregistry__tomcat_7_.xml

#sed -f .rdev/$1-intellij-rversion.sed .idea/runConfigurations/XMLIngesterNavIT.xml > .idea/runConfigurations/XMLIngesterNavIT.xml
#sed -f .rdev/$1-intellij-rversion.sed .idea/runConfigurations/LoginLogoutWDIT.xml > .idea/runConfigurations/LoginLogoutWDIT.xml
#sed -f .rdev/$1-intellij-rversion.sed .idea/runConfigurations/IdentityPersonRoleWDIT-env1.xml > .idea/runConfigurations/IdentityPersonRoleWDIT-env1.xml

echo "Updating Project JDK"
echo "s|project-jdk-name=\"1.7\"|project-jdk-name=\"1.7u5\"|g" > .rdev/$1-intellij-misc.sed
# old config/ide/intellij/.idea directory:
cp config/ide/intellij/.idea/misc.xml config/ide/intellij/.idea/misc.xml.orig
sed -f .rdev/$1-intellij-misc.sed config/ide/intellij/.idea/misc.xml.orig > config/ide/intellij/.idea/misc.xml
# new .idea directory
cp .idea/misc.xml .idea/misc.xml.orig
sed -f .rdev/$1-intellij-misc.sed .idea/misc.xml.orig > .idea/misc.xml


