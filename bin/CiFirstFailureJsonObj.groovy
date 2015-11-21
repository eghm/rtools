public class CiFirstFailureJsonObj extends CiJsonObj {


        /**

            jsonFileName must be formatted as job-buildnumber.json such as rice-2.4-test-functional-saucelabs-95.json.

        */
	protected static void process(JenkinsJobResult value, String jsonFileName) {
 		for (s in value.suites) {
            for (c in  s.cases) {
                if (c.status.equals("FAILED") || c.status.equals("REGRESSION")) {
                    if (c.errorDetails != null) {
                        message = c.errorDetails.replaceAll("\n\n", "\n")
                    } else if (c.stderr != null) {
                        message = c.stderr.replaceAll("\n\n", "\n")
                    } else if (c.stdout != null) {
                        message = c.stdout.replaceAll("\n\n", "\n")
                    } else {
println("unable to detect message for\t${c}");
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

//        println(value.toString())
//        for (s in value.suites) {
//            println("Suite:\t${s}")
//         }
	}

}
