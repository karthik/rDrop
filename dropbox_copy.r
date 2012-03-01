# Status: Works - needs error handling

#' Function to copy files or folder within Dropbox.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param from_path=NULL <what param does>
#'@param to_path=NULL <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox_copy<-function(cred,from_path=NULL,to_path=NULL)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
if(is.null(from_path) || is.null(to_path))
{
	stop("Did not specify full path for source and/or destination",call.=F)
}
# Check to see if file extenion and name matches up
copy <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/copy",list(root='dropbox',from_path=from_path,to_path=to_path)))
# OUTPUT SUCCESS MESSAGE
invisible()
}

# root - Required. The root relative to which from_path and to_path are specified. Valid values are sandbox and dropbox.
# from_path - Specifies the file or folder to be copied from relative to root.
# to_path - Required. Specifies the destination path, including the new name for the file or folder, relative to root.
# locale - The metadata returned will have its size field translated based on the given locale. For more information see above.
# from_copy_ref - Feature in beta. Specifies a copy_ref generated from a previous /copy_ref_beta call. Must be used instead of the from_path parameter.

