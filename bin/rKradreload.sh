if [ -f web/pom.xml.orig ]
then
    echo web/pom.xml.orig already exists, skipping
else
    echo "backing up web/pom.xml to web/pom.xml.orig"
    mv web/pom.xml web/pom.xml.orig
    echo "updating web/pom.xml for ReloadingDataDictionary see https://wiki.kuali.org/display/KULRICE/Reloading+Data+Dictionary+Setup"
    sed 's|</dependencies>|  <dependency>\
          <groupId>${project.groupId}</groupId>\
          <artifactId>rice-development-tools</artifactId>\
          <version>${project.version}</version>\
        </dependency>\
      </dependencies> |g' web/pom.xml.orig > web/pom.xml
fi

exit

# this is the old way, before it could be set via config param

if [ -f impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig ]
then
    echo impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig already exists, skipping
else
    echo "backing up impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml to impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig"
    mv impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig
    echo "updating impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml for reloading"
    sed 's|<bean id="dataDictionaryService" class="org.kuali.rice.kns.service.impl.DataDictionaryServiceImpl" scope="singleton">|<bean id="dataDictionaryService" class="org.kuali.rice.kns.service.impl.DataDictionaryServiceImpl" scope="singleton">\
        <constructor-arg>\
          <bean class="org.kuali.rice.krad.datadictionary.ReloadingDataDictionary" />\
        </constructor-arg>|g' impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml.orig > impl/src/main/resources/org/kuali/rice/kns/config/KNSSpringBeans.xml
        
    echo
    echo "If you get a class not found error on org.kuali.rice.krad.datadictionary.ReloadingDataDictionary execute a mvn clean install (and then force reimport maven repository from IntelliJ)"
fi
