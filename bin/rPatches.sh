# the impex patches are actually applied in rImpexPrep.sh, but since that directory gets deleted, they are also applied here.
patch -p1 <../rtools/etc/impex-no-user-percent.patch
cp ../rtools/etc/KRIM*.xml db/impex/master/src/main/resources/

patch -p0 <../rtools/etc/KULRICE-6785.patch 
patch -p0 <../rtools/etc/CXFWSS4JInInterceptor.patch 
patch -p0 <../rtools/etc/SauceLabs.patch 
patch -p0 <../rtools/etc/intellij-iml.patch
#patch -p0 <../rtools/etc/IncidentReportForm.patch 
#patch -p0 <../rtools/etc/impl-testdoc-xml.patch
