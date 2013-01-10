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
    echo "s|PNG|$f|g" > contents.sed
    sed -f contents.sed $R_HOME/rtools/etc/ConfluenceImage.tmpl  >> contents.txt
done;
rm contents.sed
