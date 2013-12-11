def textToMatch = args[0]
def searchDir = args[1]
def fileExtension = args[2]

def searchClos

searchClos = {   it.eachFile {
                     if (it.name.endsWith(fileExtension)) {
                         def fileContents = it.getText()
                         if (fileContents.contains(textToMatch)) {
                             println(it.name)
                         }
                     } 
                 }
}

searchClos( new File(searchDir) )

