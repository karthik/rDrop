#Status: Works but needs error catching


#' functions to share or possibly move a file to public folder and get the public url.
#' Function to create a share for any file or folder and return a URL.
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param file Specifies the path to the file or folder you want a shareable link to.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export dropbox_share
#'@examples \dontrun{
#'
#'}
dropbox_share<-function(cred,file)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
# VERIFY THAT FILE DOES EXIST
path_to_share <-paste("https://api.dropbox.com/1/shares/dropbox/",file,sep="")
cred$OAuthRequest(path_to_share)

# cred$OAuthRequest("https://api.dropbox.com/1/shares/dropbox/testing123")
# result<-fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/shares/dropbox/testing123")
	result<-fromJSON(cred$OAuthRequest(path_to_share))
	res <- list()
	res$url <-result[[1]]
	res$expires <-result[[2]]
	return(res)
}