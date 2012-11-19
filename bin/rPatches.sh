# the impex patches are actually applied in rImpexPrep.sh, but since that directory gets deleted, they are also applied here.
echo -e "\nImpex pateched to remove % in user table bys"
patch -p1 <../rtools/etc/impex-no-user-percent.patch

loadTestImpex.sh

# https://jira.kuali.org/browse/KULRICE-6785 fixed
#patch -p0 <../rtools/etc/KULRICE-6785.patch 

echo -e "\nApplying rtools/etc/CXFWSS4JInInterceptor.patch"
patch -p0 <../rtools/etc/CXFWSS4JInInterceptor.patch 

echo -e "\nApplying rtools/etc/SauceLabs.patch"
patch -p0 <../rtools/etc/SauceLabs.patch

echo -e "\nApplying rtools/etc/intellij-iml.patch"
patch -p1 <../rtools/etc/intellij-iml.patch
#patch -p0 <../rtools/etc/IncidentReportForm.patch 
#patch -p0 <../rtools/etc/impl-testdoc-xml.patch
