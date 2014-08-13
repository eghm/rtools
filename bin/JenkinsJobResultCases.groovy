public class JenkinsJobResultCases {
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
