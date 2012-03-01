#Status:  Works, but needs error handling

#' Function to delete a file or folder from Dropbox
#'
#'Function to delete a dropbox file or folder.
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param  file_to_delete <what param does>
#'@keywords
#'@seealso
#'@return none. A message upon successful deletion.
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox_delete <- function(cred, file_to_delete) {
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
file_to_del<-dropbox_search(cred,file_to_delete)
if(empty(file_to_del)) { stop('File or folder not found \n',call.=F)}
if(dim(file_to_del)[1]>1) { stop("More than one file or folder was found, please check name and path. \n",call.=F)}
file_to_del<-as.character(file_to_del$path[1])
verify<-readline(paste("Are you sure you want to delete",file_to_del," (Y/N)? "))
if(verify!="Y" & verify!="N") {stop("Incorrect response \n",call.=F)}
		if(verify=="Y")
		{

	 deleted <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/delete",list(root='dropbox', path=file_to_del)))
	   if(deleted$is_deleted)
		 {
		 	cat(deleted$path, "was successfully deleted on",deleted$modified,"\n")
		 }

		}
		invisible()
}

# /fileops/delete

# DESCRIPTION
# Deletes a file or folder.
# URL STRUCTURE
# https://api.dropbox.com/1/fileops/delete
# VERSIONS
# 0, 1
# METHOD
# POST
# PARAMETERS
# root - Required. The root relative to which path is
#   specified. Valid values are sandbox and dropbox.
# path - Required. The path to the file or folder to be
#   deleted.
# locale - The metadata returned will have its size
#   field translated based on the given locale. For more
#   information see above.
# RETURNS
# Metadata for the deleted file or folder. More
#   information on the returned metadata fields are
#   available here.

# Sample JSON response

# {
#     'size': '0 bytes',
#     'is_deleted': true,
#     'bytes': 0,
#     'thumb_exists': false,
#     'rev': '1f33043551f',
#     'modified': 'Wed, 10 Aug 2011 18:21:30 +0000',
#     'path': '/test .txt',
#     'is_dir': false,
#     'icon': 'page_white_text',
#     'root': 'dropbox',
#     'mime_type': 'text/plain',
#     'revision': 492341
# }
# ERRORS
# 404\tNo file wasn't found at the specified path.
# 406 Too many files would be involved in the operation
#   for it to complete successfully. The limit is
#   currently 10,000 files and folders.
