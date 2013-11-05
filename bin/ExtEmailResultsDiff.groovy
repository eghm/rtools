/**
 * Not the most elegant code, probably a better idea to implement as a Jelly script for Jenkins ext-email plugin than
 * to clean this up.
 *
 * Created for the Jenkins ext-email template (see Jenkins job rice-integration-test-publisher-results):
 * 
 * Total Tests: ${TEST_COUNTS}  Failed Tests: ${TEST_COUNTS,var="fail"} Skipped:  ${TEST_COUNTS,var="skip"}
 *
 * $DEFAULT_CONTENT
 *
 * ${FAILED_TESTS}
 *
 */
def String firstResults = new File(args[0]).text
def String secondResults = new File(args[1]).text

def int firstCount = firstResults.count("FAILED:")
def firstTests = new String[firstCount]
def firstErrors = new String[firstCount]
def firstTraces = new String[firstCount]

def secondCount = secondResults.count("FAILED:")
def secondTests = new String[secondCount]
def secondErrors = new String[secondCount]
def secondTraces = new String[secondCount]

// to view the results is from $DEFAULT_CONTENT
def header = secondResults.substring(secondResults.indexOf("Total Tests:"), secondResults.indexOf("to view the results.") + 20)

def i = 0;
if (firstResults.contains("FAILED:")) {
    firstResults = firstResults.substring(firstResults.indexOf("FAILED:"), firstResults.length())
}
while (firstResults.contains("FAILED:")) {
    def String testName = firstResults.substring(firstResults.indexOf("FAILED:") + 9, firstResults.indexOf("Error Message:")).trim()
    def String testError = firstResults.substring(firstResults.indexOf("Error Message:") + 14, firstResults.indexOf("Stack Trace:")).trim()

    firstResults = firstResults.substring(firstResults.indexOf("FAILED:") + 9, firstResults.length())

    def String testTrace
    if (firstResults.contains("FAILED:")) {
        testTrace = firstResults.substring(firstResults.indexOf("Stack Trace:") + 12, firstResults.indexOf("FAILED:")).trim()
        firstResults = firstResults.substring(firstResults.indexOf("FAILED:"), firstResults.length())
    } else {
        testTrace = firstResults.substring(firstResults.indexOf("Stack Trace:") + 12, firstResults.length()).trim()
        firstResults = ""
    }

    firstTests[i] = testName
    firstErrors[i] = testError
    firstTraces[i] = testTrace
    i++
}


i = 0
if (secondResults.contains("FAILED:")) {
    secondResults = secondResults.substring(secondResults.indexOf("FAILED:"), secondResults.length())
}

while (secondResults.contains("FAILED:")) {
    def String testName = secondResults.substring(secondResults.indexOf("FAILED:") + 9, secondResults.indexOf("Error Message:")).trim()
    def String testError = secondResults.substring(secondResults.indexOf("Error Message:") + 14, secondResults.indexOf("Stack Trace:")).trim()

    secondResults = secondResults.substring(secondResults.indexOf("FAILED:") + 9, secondResults.length())

    def String testTrace
    if (secondResults.contains("FAILED:")) {
        testTrace = secondResults.substring(secondResults.indexOf("Stack Trace:") + 12, secondResults.indexOf("FAILED:")).trim()
        secondResults = secondResults.substring(secondResults.indexOf("FAILED:"), secondResults.length())
    } else { // end of file contents
        testTrace = secondResults.substring(secondResults.indexOf("Stack Trace:") + 12, secondResults.length()).trim()
        secondResults = ""
    }

	if (testName.indexOf("QuickStartTest") > -1) { // QuickStartTest Error and Trace have a full build log in it, way too much text
	    testError = testError.substring(0, 58)
        testTrace = testTrace.substring(0, 80)
	}

    secondTests[i] = testName
    secondErrors[i] = testError
    secondTraces[i] = testTrace

    i++
}

// Blank out tests from the second set that match the name and error of the first
for (i = 0; i < secondCount; i++) {
    for (int j = 0; j < firstCount; j++) {
        if (secondTests[i].equals(firstTests[j]) && secondErrors[i].equals(firstErrors[j])) {
            secondTests[i] = ""
            secondErrors[i] = ""
            secondTraces[i] = ""
        }
    }
}

def newCount = 0
for (i = 0; i < secondCount; i++) {
    if (!secondTests[i].equals("")) {
        newCount++
    }
}

println("\nTotal New Failures: " + newCount + "\n")

println(header + "\n\nNew Failure Tests:")
for (i = 0; i < secondCount; i++) {
    if (!secondTests[i].equals("")) {
        println("\t " + secondTests[i])
    }
}

/*
println(header + "\n\nNew Failure Summary:")
for (i = 0; i < secondCount; i++) {
    if (!secondTests[i].equals("")) {
        println("Failed: " + secondTests[i] + " Error Message: " + secondErrors[i])
    }
}
*/

println("\n\nNew Failures Grouped by Error Message:")
def List seenErrors = new LinkedList()
for (i = 0; i < secondCount; i++) {
    if (!secondErrors[i].equals("") && !seenErrors.contains(secondErrors[i])) {
        println("\nError Message: " + secondErrors[i])
        seenErrors.add(secondErrors[i])
        for (int j = i; j < secondCount; j++) {
            if (secondErrors[i].equals(secondErrors[j])) {
                println("\t" + secondTests[j])
            }
        }
    }
}

println("\n\nNew Failures Details:\n")
for (i = 0; i < secondCount; i++) {
    if (!secondTests[i].equals("")) {
        println("Test: " + secondTests[i] + "\nError Message: " + secondErrors[i] + "\nStack Trace:\n" + secondTraces[i] + "\n\n")
    }
}
