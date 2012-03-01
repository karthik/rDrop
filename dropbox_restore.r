Works but needs error catching
# functions to share or possibly move a file to public folder and get the public url.


#'<brief desc>
#'
#'<full description>
#'@param cred A valid Oauth object containing your Dropbox credentials
#'@param file Name of file to be shared. If file is not in your Dropbox root, you must specify full path.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox_restore<-function(cred,path,rev)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
# List should contain path and revision number
# 1. Check revision to make sure it exists.
}