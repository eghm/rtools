/** 
 * Run on results from ExtEmailResultsDiff.groovy
 */

def String results = new File(args[0]).text

def String failedTests = results.substring(results.indexOf("New Failure Tests:") + 18, results.indexOf("New Failures Grouped by Error Message:") -1).trim()
def String test;
def String jiraContents
def String fullContents
def Map jiraTests = ["NO JIRA FOUND":[]]

while (failedTests.contains("\n")) {
	test = failedTests.substring(0, failedTests.indexOf("\n")).trim()
	failedTests = failedTests.substring(test.length(), failedTests.length()).trim()
    
    def url = "https://jira.kuali.org/rest/api/2/search?jql=text~\"" + test + "\"+AND+(status=open+OR+status=\"In+Progress\")&fields=id,summary"

	try {
        jiraContents = new URL(url).getText()

        if (!jiraContents.contains("\"key\":\"")) {
            System.out.println("\n" + test + " NO JIRA FOUND")
            jiraTests.get("NO JIRA FOUND").add(test)
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
