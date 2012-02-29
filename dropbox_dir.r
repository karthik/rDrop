Works fine
#' List contents of a Dropbox account
#'
#'<full description>
#'@param cred=NULL <what param does>
#'@param verbose=FALSE <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#' dropbox_dir(cred)
#' returns a dataframe with fields .id,
#'}
dropbox_dir<-function(cred=NULL,verbose=FALSE)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
    status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
    metadata <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/metadata/dropbox/"))
    names(metadata$contents) = basename(sapply(metadata$contents,
        `[[`, "path"))
    file_system <- metadata[[8]]
    if(!verbose)
    {
    status<-(ldply(file_system, data.frame))
    return(status$.id)
	}
	else {
		return(ldply(file_system, data.frame))
	}
}
