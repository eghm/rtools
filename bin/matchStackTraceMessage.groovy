def textToMatch = args[0]
def searchDir = args[1]
def fileExtension = args[2]

def searchClos

searchClos = {   it.eachFile {
                     if (it.name.endsWith(fileExtension)) {
                         def fileContents = it.getText()

                         if (textToMatch.contains("StackTrace")) {
                             textToMatch = textToMatch.substring(textToMatch.indexOf("StackTrace"), textToMatch.length())
                         }

                         if (textToMatch.contains(" class ")) { // don't use classnames for error matching
                            def preClass = textToMatch.substring(0, textToMatch.indexOf( " class "))
                            def postClass = textToMatch.substring(textToMatch.indexOf(" class ") + 7, textToMatch.length())
                            if (postClass.contains(" ")) {
                                postClass = postClass.substring(postClass.indexOf(" "), postClass.length())                                
                            } else {
                                postClass == null
                            }
                            if (fileContents.contains(preClass) && (postClass == null || fileContents.contains(postClass))) {
                                println(it.name)
                            }
                         } else if (fileContents.contains(textToMatch)) {
                             println(it.name)
                         }
                     } 
                 }
}

searchClos( new File(searchDir) )

