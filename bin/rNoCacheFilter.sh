mkdir -p core/impl/src/main/java/com/samaxes/filter/util
cp ../rtools/etc/NoCacheFilter.java core/impl/src/main/java/com/samaxes/filter/
cp ../rtools/etc/HTTPCacheHeader.java core/impl/src/main/java/com/samaxes/filter/util/


# NOTE for a couple of weeks the web.xml was in web/src/filtered/webapp/WEB-INF/web.xml
if [ -f web/src/main/webapp/WEB-INF/web.xml ]
then
    echo "backing up web/src/main/webapp/WEB-INF/web.xml to web/src/main/webapp/WEB-INF/web.xml.orig"
else
	echo web/src/main/webapp/WEB-INF/web.xml no longer exists.
	exit	
fi	

if [ -f web/src/main/webapp/WEB-INF/web.xml.orig ]
then
    echo web/src/main/webapp/WEB-INF/web.xml.orig already exists, skipping
else
    mv web/src/main/webapp/WEB-INF/web.xml  web/src/main/webapp/WEB-INF/web.xml.orig
    echo "updating web/src/main/webapp/WEB-INF/web.xml"
    sed '1,/<filter-mapping>/s/<filter-mapping>/<filter>\
	<filter-name>noCache<\/filter-name>\
	<filter-class>com.samaxes.filter.NoCacheFilter<\/filter-class>\
<\/filter>\
<filter-mapping>\
  <filter-name>noCache<\/filter-name>\
  <url-pattern>\/*<\/url-pattern>\
<\/filter-mapping>\
<filter-mapping>/' web/src/main/webapp/WEB-INF/web.xml.orig > web/src/main/webapp/WEB-INF/web.xml
fi
