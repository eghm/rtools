mkdir $1
for line in $(cat servers.txt);
do
	scp $line:logs/$1/*.* $1/
done;
