/** 
 * Run on results from ExtEmailResultsDiff.groovy
 */

def String results = new File(args[0]).text

// don't load whole thing up in JSON just to get the counts.
// "failCount":19,"passCount":211,"skipCount":13,
def String failCount = results.substring(results.indexOf("\"failCount\":") + 12, results.indexOf(",\"passCount\":")).trim()
//def String passCount = results.substring(results.indexOf("\"passCount\":") + 12, results.indexOf(",\"skipCount\":")).trim()
//def String skipCount = results.substring(results.indexOf("\"skipCount\":") + 12, results.indexOf(",\"suites\":")).trim()

System.out.println(failCount)
//System.out.println("failCount:" + failCount + " passCount:" + passCount + " skipCount:" + skipCount)