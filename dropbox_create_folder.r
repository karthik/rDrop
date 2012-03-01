WORKS,but needs error catching
#'<brief desc>
#'
#'<full description>
#'@param cred <what param does>
#'@param folder_name <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox_create_folder <-function(cred,folder_name)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
dir_metadata<-fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/create_folder/",list(root = 'dropbox', path =folder_name )))
cat("Folder successfully created at",dir_metadata$root, dir_metadata$path, "on", dir_metadata$modified, "\n")
}

# list(root = 'dropbox', path = 'success')

# This error comes up for files with the same name:

# Error in fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/create_folder/",  :
#   error in evaluating the argument 'content' in selecting a method for function 'fromJSON': Error: Forbidden

need more meaningful errors than just Error: Forbidden