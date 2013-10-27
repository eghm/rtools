echo -e "\nInstalling NoCacheFilter"
mkdir -p rice-middleware/core/impl/src/main/java/com/samaxes/filter/util
cp ../rtools/etc/NoCacheFilter.java rice-middleware/core/impl/src/main/java/com/samaxes/filter/
cp ../rtools/etc/HTTPCacheHeader.java rice-middleware/core/impl/src/main/java/com/samaxes/filter/util/

if [ -f rice-middleware/web/src/main/webapp/WEB-INF/web.xml.orig ]
then
    echo "rice-middleware/web/src/main/webapp/WEB-INF/web.xml.orig already exists, skipping."
else
    mv rice-middleware/web/src/main/webapp/WEB-INF/web.xml  rice-middleware/web/src/main/webapp/WEB-INF/web.xml.orig
    echo "updating rice-middleware/web/src/main/webapp/WEB-INF/web.xml"
    sed '1,/<filter-mapping>/s/<filter-mapping>/<filter>\
	<filter-name>noCache<\/filter-name>\
	<filter-class>com.samaxes.filter.NoCacheFilter<\/filter-class>\
<\/filter>\
<filter-mapping>\
  <filter-name>noCache<\/filter-name>\
  <url-pattern>\/*<\/url-pattern>\
<\/filter-mapping>\
<filter-mapping>/' rice-middleware/web/src/main/webapp/WEB-INF/web.xml.orig > rice-middleware/web/src/main/webapp/WEB-INF/web.xml
fi

