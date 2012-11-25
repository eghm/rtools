rm $1.expanded
cp $1 $1.working

while [ -s $1.working ] 
do
	export COUNT=$(tail -n 1 $1.working | cut -d , -f 1)
	export USER=$(tail -n 1 $1.working | cut -d , -f 2)
	export KEY=$(tail -n 1 $1.working | cut -d , -f 3)

    while [  $COUNT -gt 0 ]; do
		echo "$USER,$KEY" >> $1.expanded;
		let COUNT-=1
    done
	
	sed '$d' $1.working > $1.working.cut
	mv $1.working.cut  $1.working
done;
rm $1.working
cat $1.expanded
