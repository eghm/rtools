# old version to delete, new version to create, db root password
remotePullRtools.sh
remoteDbStart.sh
deleteRevisionAndDBs.sh $1 $3
rDev.sh $2 $3 rice rice -DskipTests=true
