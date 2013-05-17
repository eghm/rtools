if [ -z "$1" ]
then
    echo "Required parameter, directory of png to create contexts.txt for."
    exit;
fi
if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

cd $1
for f in *.png;
do
    echo "s|PNG|$f|g" > wiki.sed
    sed -f wiki.sed $R_HOME/rtools/etc/ConfluenceImage.tmpl  >> wiki.txt
done;
rm wiki.sed
