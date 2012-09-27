if [ -f web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig ]
then
    echo web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig already exists, skipping
else
    echo "backing up web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp to web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig"
    mv web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp  web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig
    echo "updating web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp"
    sed -f ../rtools/etc/rLogin.sed web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig > web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp
fi
