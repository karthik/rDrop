#' Function to move files with a Dropbox account
#'
#' Allows users to move files or folders inside the dropbox storage.
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param from_path Specifies the file or folder to be copied from relative to root.
#'@param to_path Specifies a destination path, including the new name for the file or folder, relative to root.
#'@keywords
#'@seealso dropbox_copy dropbox_create_folder
#'@return
#'@alias
#'@export dropbox_move
#'@examples \dontrun{
#'
#'}
dropbox_move<-function(cred,from_path=NULL,to_path=NULL)
{
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
# Make sure both paths aren't empty
# Next, make sure origin and destination paths exist
# Note: to_path needs a leading / because root is 'dropbox'
# make sure folder is not being copied to file but file can copy to folder
if(is.null(from_path) || is.null(to_path))
{
	stop("Did not specify full path for source and/or destination",call.=F)
}
move <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/move",list(root='dropbox',from_path=from_path,to_path=to_path)))
if(length(move$modified)>0)
	{
		cat("Move to", move$path, "was successful on", move$modified," \n")
	}
if(length(move$modified)==0)
	{
		cat("Unknown error occured. Bug"," \n")
	}

# OUTPUT SUCCESSFUL MESSAGE.
invisible()
}

# Error 1
# Issues, the leading slash is very important. That's what led to the error below.
# >dropbox_move(cred,'/test.csv','test_works/test.csv')
# Error in fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/move",  :
#   error in evaluating the argument 'content' in selecting a method for function 'fromJSON': Error: Forbidden
# >

# API instructions
# -----------------------------------------------------------------
# Moves a file or folder to a new location.
# URL STRUCTURE
# https://api.dropbox.com/1/fileops/move
# VERSIONS
# 0, 1
# METHOD
# POST
# PARAMETERS
# root - Required. The root relative to which from_path and to_path are specified. Valid values are sandbox and dropbox.
# from_path - Required. Specifies the file or folder to be moved from relative to root.
# to_path - Required. Specifies the destination path, including the new name for the file or folder, relative to root.
# locale - The metadata returned will have its size field translated based on the given locale. For more information see above.
# RETURNS
# Metadata for the moved file or folder. More information on the returned metadata fields are available here.

# Sample JSON response

# {
#     "size": "15 bytes",
#     "rev": "1e0a503351f",
#     "thumb_exists": false,
#     "bytes": 15,
#     "modified": "Wed, 10 Aug 2011 18:21:29 +0000",
#     "path": "/test2.txt",
#     "is_dir": false,
#     "icon": "page_white_text",
#     "root": "dropbox",
#     "mime_type": "text/plain",
#     "revision": 496342
# }
# ERRORS
# 403	An invalid move operation was attempted (e.g. there is already a file at the given destination, or moving a shared folder into a shared folder).
# 404	The source file wasn't found at the specified path.
# 406	Too many files would be involved in the operation for it to complete successfully. The limit is currently 10,000 files and folders.