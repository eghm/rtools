public class JenkinsJobResult {
    def empty
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
	    return "empty: ${empty} duration: ${duration} failCount: ${failCount} passCount: ${passCount} skipCount: ${skipCount}\n${cases}\n\n"
	}
}