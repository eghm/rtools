echo -e "\nadmin auto-login update."
if [ -f rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig ]
then
    echo "rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig already exists, skipping."
else
    echo "backing up rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp to rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig"
    mv rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp  rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig
    echo "updating rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp"
    sed -f ../rtools/etc/rLogin.sed rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp.orig > rice-middleware/web/src/main/webapp/WEB-INF/jsp/dummy_login.jsp
fi
