export DTS=$(date +%Y%m%d%H%M)
git add -A
git commit -am "$DTS $1"
