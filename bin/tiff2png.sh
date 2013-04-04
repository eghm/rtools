rename 'y/ /_/' *.tiff
find . -maxdepth 1 -name '*.tiff' -exec convert {} {}png \;
rename 's/tiff//' *.tiffpng
rename 'y/_/ /' *.png

