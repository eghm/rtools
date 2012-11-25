for line in $(cat servers.txt);
do
    mkdir -p $1/$line
	scp $line:logs/$1/*.* $1/$line/
done;
