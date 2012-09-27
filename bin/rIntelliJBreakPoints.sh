#revision file linenumber class package
find $R_HOME -name workspace.xml | xargs grep ".*<breakpoint.url.*" >> ij-breakpointstemp.txt ; cut -d "\"" -f 2,4,6,8 ij-breakpointstemp.txt  | sed 's/\"/ /g' ; cut -d "\"" -f 1,2,4,6,8 ij-breakpointstemp.txt  | sed 's/\"/ /g' | sed 's/$R_HOME\///' | sed 's/\/.*[\.2]\// /' > ~/wubot/filetails/ij-breakpoints.txt ; rm ij-breakpointstemp.txt
 
