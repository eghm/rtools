find ./ -name 'pom.xml' -print0 | xargs -0 grep -i "$1" | grep -v svn
