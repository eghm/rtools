let "s=`wc -l servers.txt | cut -c 1-9`"
let "c=`expr $1/$s`"
let "f=0"
let "z=10"

# create one admin user per server
echo "IdentityPersonRoleWDIT:admin:-Dtest.role.user.cnt.start=0:-Dtest.role.user.cnt=$s"

# use one admin per server to create the other users
for i in `seq 1 $s`
do
	let "y=`expr $i - 1`"
	let "x=z+c-2"
	if [ $i -eq $s ]
	then
		let "x=$1"
    fi
    echo `printf "IdentityPersonRoleWDIT:loadtester%03d:-Dtest.role.user.cnt.start=$z:-Dtest.role.user.cnt=$x" $y`
	let "z=x+1"
done
