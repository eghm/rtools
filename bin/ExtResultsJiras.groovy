/** 
 * Run on results from ExtEmailResultsDiff.groovy
 */

def String results = new File(args[0]).text

def String failedTests = results.substring(results.indexOf("New Failure Tests:") + 18, results.indexOf("New Failures Grouped by Error Message:") -1).trim()
//def String testDetails = results.substring(results.indexOf("New Failures Details:") + 21, results.length()).trim()
def String test
//def String detail
def String jiraContents
def String fullContents
def Map jiraTests = ["NO JIRAS FOUND":[]]

while (failedTests.contains("\n")) {
	test = failedTests.substring(0, failedTests.indexOf("\n")).trim()	
	failedTests = failedTests.substring(test.length(), failedTests.length()).trim()
	
//	detail = testDetails.substring(testDetails.indexOf("Test: " + test) + test.length() + 5, testDetails.indexOf("\n\n"))
//	detail = detail.substring(detail.indexOf("Error Message: ") + 15, testDetails.indexOf("\n")).trim()
//	testDetails = testDetails.substring(testDetails.indexOf("\n\n"), testDetails.length())
    

	try {
        if (args.length > 1) {
            System.out.println("\n" + test + " NO JIRA FOUND")
            jiraTests.get("NO JIRAS FOUND").add(test)
        } else {

            def url = "https://jira.kuali.org/rest/api/2/search?jql=text~\"" + test + "\"+AND+(status=open+OR+status=\"In+Progress\"+OR+status=Reopened)&fields=id,summary"
            jiraContents = new URL(url).getText()

        if (!jiraContents.contains("\"key\":\"")) { // didn't find with long name

            // Try short name
            def testCopy = test
            def testMethod = testCopy.substring(testCopy.lastIndexOf(".") + 1, testCopy.length())
            testCopy = testCopy.substring(0, testCopy.lastIndexOf("."))
            def testClass = testCopy.substring(testCopy.lastIndexOf(".") + 1, testCopy.length())
            url = "https://jira.kuali.org/rest/api/2/search?jql=text~\"" + testClass + "." + testMethod + "\"+AND+(status=open+OR+status=\"In+Progress\")&fields=id,summary"
            jiraContents = new URL(url).getText()

//            if (!jiraContents.contains("\"key\":\"")) { // didn't find with short name either
//                if (detail.length() > 80) {
//                    detail = detail.substring(0, 79)
//                }
//                detail = detail.replace("\t", " ")
//                detail = detail.replaceAll(":", "") // jira gives parsing errors if colons are in it even though they get escaped...
////                detail = detail.replace(" ", "%20")
////                detail = detail.replace("/", "%2F")
//                url = "https://jira.kuali.org/rest/api/2/search?jql=text~\"" + URLEncoder.encode(detail) + "\"+AND+(status=open+OR+status=\"In+Progress\")&fields=id,summary"
//			    try {
//                    jiraContents = new URL(url).getText()			
//			    } catch (MalformedURLException mue) {
//			        System.err.println(url + " " + mue.getMessage())
//			        System.exit(1)
//			    }

                if (!jiraContents.contains("\"key\":\"")) { // didn't find with error either
                    System.out.println("\n" + test + " NO JIRA FOUND")
                    jiraTests.get("NO JIRAS FOUND").add(test)
                } else {
                    System.out.println("\n" + test + " " + jiraContents.substring(jiraContents.indexOf("\"key\":\"") + 7, jiraContents.length()))
                }
//            }
        } else {
            System.out.println("\n" + test)
        }

        def id = jiraContents
        def summary = jiraContents
		fullContents = jiraContents

        while (jiraContents.contains("\"key\":\"")) {

            id = jiraContents
            summary = jiraContents

            id = id.substring(id.indexOf("\"key\":\"") + 7, id.length())
            id = id.substring(0, id.indexOf("\""))
            jiraContents = jiraContents.substring(jiraContents.indexOf(id) + id.length(), jiraContents.length())

            summary = summary.substring(summary.indexOf("\"summary\":\"") + 11, summary.length())
            summary = summary.substring(0, summary.indexOf("\""))
            jiraContents = jiraContents.substring(jiraContents.indexOf(summary) + summary.length(), jiraContents.length())

            if (jiraTests.get(id + " " + summary) == null) {
                jiraTests.put(id + " " + summary, [test])
            } else {
                jiraTests.get(id + " " + summary).add(test)
            }

            System.out.println("\t" + id + " " + summary)
        }
        
        }

	} catch (Exception e) {
	    System.out.println("\nTest: " + test + " " + e.getMessage())
        System.out.println("Full: " +  fullContents)
        System.out.println("Sub: " +  jiraContents)
	    e.printStackTrace()	
	}
}


println "\n\nTests grouped by Jiras:"
def List keys = jiraTests.keySet().toList();
for (int i = 0; i < keys.size(); i++) {
    def key = keys.getAt(i)
    println key
    def tests = jiraTests.get(key)
    tests.each() { println "\t${it}"}
    println ""
}
