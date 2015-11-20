/**
http://ci.rice.kuali.org/job/rice-2.4-smoke-test/lastCompletedBuild/testReport/api/json
*/


import org.apache.commons.httpclient.*

import org.apache.commons.httpclient.auth.*
import org.apache.commons.httpclient.methods.*

@Grab(group='commons-httpclient', module='commons-httpclient', version='3.1')

  def server = "http://ci.kuali.org"
  def username = "USERNAME"
  def apiToken = "API TOKEN"

  def client = new HttpClient()
  client.state.setCredentials(
    new AuthScope( server, 443, "realm"),
    new UsernamePasswordCredentials( username, apiToken )
  )

  // Jenkins does not do any authentication negotiation,
  // ie. it does not return a 401 (Unauthorized)
  // but immediately a 403 (Forbidden)
  client.params.authenticationPreemptive = true

  def post = new GetMethod( "${server}/job/rice-2.4-smoke-test/lastCompletedBuild/testReport/api/json" )
  post.doAuthentication = true

  try {
    int result = client.executeMethod(post)
    println "Return code: ${result}"
    post.responseHeaders.each{ println it.toString().trim() }
    println post.getResponseBodyAsString()
  } finally {
    post.releaseConnection()
  }




/*
def jobs = ["rice-2.4-smoke-test"]
def jobsResults;
def result;

for (j in jobs) {
    def url = "http://ci.kuali.org/job/" + j + "/lastCompletedBuild/testReport/api/json"
	try {
        jobsResults = new URL(url).getText()
        println("URL: " + url + " jobsResults: " + jobsResults)

        while (jobsResults.contains("[{\"age\":")) {
            result = jobsResults.substring(jobsResults.indexOf("[{\"age\":") + 8, jobsResults.length())
            jobsResults = jobsResults.substring(jobsResults.indexOf("[{\"age\":") + 8, jobsResults.length())
            result = result.substring(0, results.indexOf("[{\"age\":"))
            println("\n" + result)
			jobsResults = jobsResults.substring(result.length(), jobsResults.length())
        }
	} catch (Exception e) {
	    System.out.println(e.getMessage())
	    e.printStackTrace()	
	}
}
*/
