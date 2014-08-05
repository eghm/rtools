def timesFile = new File(args[0]);

def currentPage = "";
def times = []; 
timesFile.eachLine {
    if (it.endsWith('.jtl')) {
        if (times.size() > 0) {

            def sum = 0;
            def sumSq = 0;
            def count = 0;

            times.each {
                sum += it;
                sumSq += it*it;
                count++;
            }
            print "$currentPage";
            for (int i = 9 - currentPage.length()/8; i > 0; i--) {
                print "\t";
            } 
            println "ave.= ${Math.round(sum/count)}\tstd.dev.= ${(sumSq/count - (sum/count)**2)**0.5}";
            times.clear();
        
        }
        currentPage = it;
    } else {
        times.add(it.toInteger()); 
    }
}
