import com.fasterxml.jackson.databind.*;

@Grapes([
    @Grab(group='com.fasterxml.jackson.core', module='jackson-core', version='2.3.0'),
    @Grab(group='com.fasterxml.jackson.core', module='jackson-annotations', version='2.3.0'),
    @Grab(group='com.fasterxml.jackson.core', module='jackson-databind', version='2.3.0')])
public class CiJsonObj {


    public static void main(String[] args) throws Exception {
        def message = ""
        def jenkinsBase = "http://ci.rice.kuali.org"
        def jsonFileName = args[0] // rice-2.4-test-functional-saucelabs-95.json

        ObjectMapper mapper = new ObjectMapper(); 
        JenkinsJobResult value = mapper.readValue(new File(jsonFileName), JenkinsJobResult.class);

        def totalCount = value.failCount + value.passCount + value.skipCount
        def buildNumber = jsonFileName.substring(jsonFileName.lastIndexOf("-") + 1, jsonFileName.indexOf(".json"))
        def job = jsonFileName
        if (job.contains("/")) {
            job = job.substring(job.lastIndexOf("/") + 1, jsonFileName.indexOf("-" + buildNumber + ".json"))
        } else if (job.contains("\\")) {
            job = job.substring(job.lastIndexOf("\\") + 1, jsonFileName.indexOf("-" + buildNumber + ".json"))
        } else {
            job = job.substring(0, jsonFileName.indexOf("-" + buildNumber + ".json"))
        }

		println("Total Tests: ${totalCount}  Failed Tests: ${value.failCount} Skipped: ${value.skipCount}\n") // Total Tests: 1832  Failed Tests: 148 Skipped:  42
        println("${job} - Build # ${buildNumber}\n") //rice-2.4-test-integration-mysql-daily-email - Build # 57 - Still Unstable:
        println("Check console output at ${jenkinsBase}/job/${job}/${buildNumber}/ to view the results.\n") // Check console output at http://ci.rice.kuali.org/job/rice-2.4-test-integration-mysql-daily-email/57/ to view the results.
        println("${value.failCount} tests failed.") // 148 tests failed.
 		for (s in value.suites) {
            for (c in  s.cases) {
                if (c.status.equals("FAILED")) {
                    if (c.errorDetails != null) {
                        message = c.errorDetails.replaceAll("\n\n", "\n")
                    } else if (c.stderr != null) {
                        message = c.stderr.replaceAll("\n\n", "\n")
                    } else if (c.stdout != null) {
                        message = c.stdout.replaceAll("\n\n", "\n")
                    }
                    else {
                        message = ""
                    }

                    message = message.replaceAll("&gt;", ">");
                    message = message.replaceAll("&lt;", "<");
                    message = message.replaceAll("&amp;", "&"); // don't replace ampersand first to preserve remaining &gt; and &lt; as they appear in jenkins

                    println("FAILED: ${c.className}.${c.name}\n\nError Message:\n${message}")
                    println("\nStack Trace: ${c.errorStackTrace}")
                    println("\nStandard Output: ${c.stdout}")
                    println("\n\n")
                }
            }
        }

        // println(value.toString())
        // for (s in value.suites) {
        //     println("Suite:\t${s}")
        // }
    }
}

class JenkinsJobResult {
    def duration
    def failCount
    def passCount
    def skipCount
    def List<JenkinsJobResultCases> suites

	public String toString() {
	    def cases = ""
	    for (c in suites) {
	        cases += "\t\t" + c.toString() + "\n"
	    }
	    return "duration: ${duration} failCount: ${failCount} passCount: ${passCount} skipCount: ${skipCount}\n${cases}\n\n"
	}
}

class JenkinsJobResultCases {
    def duration
    def failCount
    def passCount
    def skipCount

    def className
    def errorDetails
    def errorStackTrace
    def id
    def name
    def skipped
    def status
    def stderr
    def stdout
    def timestamp
    def failedSince
    def List cases
	public String toString() {
	    def cs = ""
	    for (c in cases) {
	        cs += "\t\t\t\t" + c.toString() + "\n"
	    }	
	    return "id: ${id} className: ${className} name: ${name} skipped: ${skipped} status: ${status} failedSince: ${failedSince} errorDetails: ${errorDetails} stderr: ${stderr} stdout: ${stdout} timestamp: ${timestamp} duration: ${duration} failCount: ${failCount} passCount: ${passCount} skipCount: ${skipCount}\n${cs}\n"
	}
}

