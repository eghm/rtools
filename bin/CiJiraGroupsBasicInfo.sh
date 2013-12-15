find ./JiraGroups -name "*$1*.*" -exec cat {} \; > $1.txt
grep -A2 "Abbreviated test name:" $1.txt > $1.jiras
