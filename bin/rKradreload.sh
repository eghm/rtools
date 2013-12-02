echo -e "\nInstalling Reloading DataDictionary for rice-framework/krad-sampleapp/web, see https://wiki.kuali.org/display/KULRICE/Reloading+Data+Dictionary+Setup"
if [ -f rice-framework/krad-sampleapp/web/pom.xml.orig ]
then
    echo "rice-framework/krad-sampleapp/pom.xml.orig already exists, skipping."
else
    echo "backing up rice-framework/krad-sampleapp/web/pom.xml to rice-framework/krad-sampleapp/web/pom.xml.orig"
    mv rice-framework/krad-sampleapp/web/pom.xml rice-framework/krad-sampleapp/web/pom.xml.orig
    echo "updating web/pom.xml for ReloadingDataDictionary see https://wiki.kuali.org/display/KULRICE/Reloading+Data+Dictionary+Setup"
    sed 's|</dependencies>|  <dependency>\
          <groupId>${project.groupId}</groupId>\
          <artifactId>rice-development-tools</artifactId>\
          <version>${project.version}</version>\
        </dependency>\
      </dependencies> |g' rice-framework/krad-sampleapp/web/pom.xml.orig > rice-framework/krad-sampleapp/web/pom.xml
fi

exit

# get erros with rice-middleware

echo -e "\nInstalling Reloading DataDictionary for rice-middleware/web, see https://wiki.kuali.org/display/KULRICE/Reloading+Data+Dictionary+Setup"
if [ -f rice-middleware/web/pom.xml.orig ]
then
    echo "rice-middleware/web/pom.xml.orig already exists, skipping."
else
    echo "backing up rice-middleware/web/pom.xml to rice-middleware/web/pom.xml.orig"
    mv rice-middleware/web/pom.xml rice-middleware/web/pom.xml.orig
    echo "updating web/pom.xml for ReloadingDataDictionary see https://wiki.kuali.org/display/KULRICE/Reloading+Data+Dictionary+Setup"
    sed 's|</dependencies>|  <dependency>\
          <groupId>${project.groupId}</groupId>\
          <artifactId>rice-development-tools</artifactId>\
          <version>${project.version}</version>\
        </dependency>\
      </dependencies> |g' rice-middleware/web/pom.xml.orig > rice-middleware/web/pom.xml
fi


# this is the old way, before it could be set via config param

if [ -f rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig ]
then
    echo "rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig already exists, skipping."
else
    echo "backing up rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml to rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig"
    mv rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig
    echo "updating rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml for reloading"
    sed 's|<bean id="dataDictionaryService" class="org.kuali.rice.kns.service.impl.DataDictionaryServiceImpl" scope="singleton">|<bean id="dataDictionaryService" class="org.kuali.rice.kns.service.impl.DataDictionaryServiceImpl" scope="singleton">\
        <constructor-arg>\
          <bean class="org.kuali.rice.krad.datadictionary.ReloadingDataDictionary" />\
        </constructor-arg>|g' rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig > rice-middleware/impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml
        
    echo
    echo "If you get a class not found error on org.kuali.rice.krad.datadictionary.ReloadingDataDictionary execute a mvn clean install (and then force reimport maven repository from IntelliJ)"
fi
