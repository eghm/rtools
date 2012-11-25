export DTS=$(date +%Y%m%d%H%M)
for line in $(cat servers.txt);
do
    mkdir -p $1/$DTS/$line
	scp $line:logs/$1/*.* $1/$DTS/$line/
done;
