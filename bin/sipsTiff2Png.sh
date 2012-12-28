if [ -z "$1" ]
then
    echo "Required parameter, directory to convert not given."
    exit;
fi
cd $1
rename 'y/ /_/' *.tiff
for f in *.tiff;
do
    sips -s format png $f --out $f.png
done;
rename 's/\.tiff\.png/\.png/' *.tiff.png
rename 'y/_/ /' *.png

