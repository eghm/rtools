# http://svn.haxx.se/users/archive-2011-01/0492.shtml
cd $R_HOME/rtools/bin
REPOSITORY=https://svn.kuali.org/repos/rice/trunk/ 
AUTHOR=eghm-kuali-m 
function get_log () { 
    svn log --xml --verbose $REPOSITORY 
} 
function select_files () { 
    xsltproc --stringparam author $AUTHOR files-modified-by-author.xsl - 
} 
get_log | select_files | sort -u 

