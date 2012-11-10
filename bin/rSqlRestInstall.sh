if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
	exit
fi

if [ -z "$CATALINA_HOME" ]
then
	echo "CATALINA_HOME not set skipping sqlrest installation"
	exit
fi

if [ -e "$CATALINA_HOME/webapps/sqlrest" ] 
then 
	echo "sqlrest already installed in $CATALINA_HOME/webapps/sqlrest"
	exit
fi

if [ ! -e "$R_HOME/rtools/dl/sqlrest/sqlrest-1.0.zip" ]
then
    echo -e "\n\nInstalling sqlrest webapp into $CATALINA_HOME/webapps"
	mkdir -p $R_HOME/rtools/dl/sqlrest
	cd $R_HOME/rtools/dl/sqlrest
	echo "downloading http://sourceforge.net/projects/sqlrest/files/latest/download/sqlrest-1.0.zip"
	wget http://sourceforge.net/projects/sqlrest/files/latest/download
	mv download sqlrest-1.0.zip
fi

if [ ! -e "$R_HOME/rtools/dl/sqlrest/sqlrest/webapps/sqlrest" ]
then
	cd $R_HOME/rtools/dl/sqlrest
	echo "unzipping sqlrest-1.0.zip"
	unzip -f sqlrest-1.0.zip
fi
echo "moving $R_HOME/rtools/dl/sqlrest/webapps/sqlrest to $CATALINA_HOME/webapps"
mv $R_HOME/rtools/dl/sqlrest/webapps/sqlrest $CATALINA_HOME/webapps
