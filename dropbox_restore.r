# Status: Still setting up

# functions to share or possibly move a file to public folder and get the public url.
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param file  The path to the file.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export dropbox_restore
#'@examples \dontrun{
#'
#'}
dropbox_restore<-function(cred,path,rev)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
# List should contain path and revision number
# 1. Check revision to make sure it exists.
}

# List of Issues