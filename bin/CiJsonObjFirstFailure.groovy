import com.fasterxml.jackson.databind.*;

@Grapes([
    @Grab(group='com.fasterxml.jackson.core', module='jackson-core', version='2.4.0'),
    @Grab(group='com.fasterxml.jackson.core', module='jackson-annotations', version='2.4.0'),
    @Grab(group='com.fasterxml.jackson.core', module='jackson-databind', version='2.4.0')])
public class CiJsonObjFirstFailure {

    public static void main(String[] args) throws Exception {
        def jsonFileName = args[0] // rice-2.4-test-functional-saucelabs-95.json
        ObjectMapper mapper = new ObjectMapper();
        def goodRead = false
        while (goodRead == false) {
            try {
                JenkinsJobResult value = mapper.readValue(new File(jsonFileName), JenkinsJobResult.class);
                goodRead = true;
                process(value, jsonFileName);
            } catch (JsonMappingException jme) {
//                System.err.println(jme.getMessage());
                def message = jme.getMessage();
                def lineNumber = message.substring(message.indexOf("line: ") + 6, message.lastIndexOf(",")).trim().toInteger();
                System.err.println("line number to remove " + lineNumber);
                // remove problematic line

                def line = "";
                def newFileContents = "";
                def lineToRemove = "";
                def count=0;
                new File(jsonFileName).withReader { reader ->
                  while ((line = reader.readLine()) != null) {
                    if (count == lineNumber) {
                        lineToRemove = line;
//        System.err.println("line to remove " + lineToRemove);
                    } else {
                        newFileContents += line;
                    }
                    count++;
                  }
                };

                jsonFileName = jsonFileName + ".minus.errors";
                new File(jsonFileName).write(newFileContents);

                // save problematic line into another file
                new File(jsonFileName.replace(".minus.errors", "." + lineNumber)).write(lineToRemove);

            }
        }
    }

        /**

            jsonFileName must be formatted as job-buildnumber.json such as rice-2.4-test-functional-saucelabs-95.json.

        */
	protected static void process(JenkinsJobResult value, String jsonFileName) {
        def message = ""
 		for (s in value.suites) {
            for (c in s.cases) {
                if (c.status.equals("REGRESSION")) { // REGRESSION is first failure
                    println("${c.className}.${c.name}")
                }
            }
        }
        println("\n\n")

//        println(value.toString())
//        for (s in value.suites) {
//            println("Suite:\t${s}")
//         }
	}

}
