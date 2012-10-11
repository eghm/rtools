echo "Getting test to run from pool..."
echo "curl -o namepooltest.json http://testuserpool.appspot.com/namepool?key=1"
curl -o namepooltest.json http://testuserpool.appspot.com/namepool?key=1 
cat namepooltest.json | JSON.sh | grep -F -e "[\"name\"]" | cut -s -f 4 -d\" > RUNNING_TEST
