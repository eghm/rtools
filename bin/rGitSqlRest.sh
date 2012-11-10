export R_HOME=~
mkdir -p $R_HOME/rtools/bin
mkdir $R_HOME/rtools/etc
cd $R_HOME/rtools/bin
rm -f rSqlRest.sh
wget https://raw.github.com/eghm/rtools/master/bin/rSqlRest.sh
chmod 755 rSqlRest.sh
rm -f rSqlRestInstall.sh
wget https://raw.github.com/eghm/rtools/master/bin/rSqlRestInstall.sh
chmod 755 rSqlRestInstall.sh
cd $R_HOME/rtools/etc
rm -f sqlrestconf.xml
wget https://raw.github.com/eghm/rtools/master/etc/sqlrestconf.xml
cd $R_HOME
$R_HOME/rtools/bin/rSqlRest.sh 



