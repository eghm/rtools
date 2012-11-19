echo "impex loadtester copying rtools/etc/impex/*.xml to db/impex/master/src/main/resources/"
find ../rtools/etc/impex -name '*.xml' -exec cp {} db/impex/master/src/main/resources/ \;
