export SERVER_NUM=$(wc -l $1 | cut -c 1-9)
export TEST_NUM=$(wc -l $2 | cut -c 1-9)
export SPLIT_LINES=$(($TEST_NUM/$SERVER_NUM))
echo "$SERVER_NUM servers, $TEST_NUM tests, splitting into $SPLIT_LINES"
split -l $SPLIT_LINES $2 push-
cp $1 $1.tmp
for f in push-*;
do
	export SERVER=$(tail -n 1 $1.tmp)	
	sed '$d' $1.tmp > $1.tmp2
	mv $1.tmp2 $1.tmp
	echo "scp $f ec2-user@$SERVER:LegacyITsUsers.txt"
	scp $f ec2-user@$SERVER:LegacyITsUsers.txt
done;
rm push-*
rm $1.tmp
