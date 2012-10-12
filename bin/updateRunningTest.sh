echo "deprecated pass in user as parallel param"
exit
echo "Getting test to run from pool..."
echo "curl -o namepooltest.json http://testuserpool.appspot.com/namepool?key=1"
curl -o namepooltest.json http://testuserpool.appspot.com/namepool?key=1 
cat namepooltest.json | ~/rtools/bin/JSON.sh | grep -F -e "[\"name\"]" | cut -s -f 4 -d\" > RUNNING_TEST
export RUNNING_TEST=$(cat RUNNING_TEST)
echo "Going to run $RUNNING_TEST"
