#echo -e "\nApplying rtools/etc/cu-xml.patch"
#mkdir -p core/impl/src/main/java/org/kuali/rice/core/impl/xml
#mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/xml
#mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/data/xml
#mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/permission/xml
#mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/role/xml
#mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/user/xml
#patch -p0 <../rtools/etc/cu-xml.patch

# the impex patches are actually applied in rImpexPrep.sh, but since that directory gets deleted, they are also applied here.
#echo -e "\nImpex pateched to remove % in user table bys"
#patch -p1 <../rtools/etc/impex-no-user-percent.patch

#loadTestImpex.sh

# https://jira.kuali.org/browse/KULRICE-6785 fixed
#patch -p0 <../rtools/etc/KULRICE-6785.patch 

echo -e "\nApplying rtools/etc/CXFWSS4JInInterceptor.patch"
patch -p0 <../rtools/etc/patches/CXFWSS4JInInterceptor.patch 

echo -e "\nApplying rtools/etc/patches/SauceLabs.patch"
patch -p0 <../rtools/etc/patches/SauceLabs.patch

echo -e "\nApplying rtools/etc/patches/debugViews.patch"
patch -p0 <../rtools/etc/patches/debugViews.patch

echo -e "\nApplying rtools/etc/patches/jsdoctk.patch
patch -p0 < ../rtools/etc/patches/jsdoctk.patch

# disabled to see how the new iml files work
#echo -e "\nApplying rtools/etc/intellij/intellij-iml.patch"
#patch -p1 <../rtools/etc/intellij/intellij-iml.patch

#patch -p0 <../rtools/etc/IncidentReportForm.patch 
#patch -p0 <../rtools/etc/impl-testdoc-xml.patch

echo -e "\nApplying freemarker delay setttings to rice-framework/krad-web/src/main/webapp/WEB-INF/krad-base-servlet.xml"
patch -p0 < ../rtools/etc/patches/FreemarkerUpdateDelay.patch
