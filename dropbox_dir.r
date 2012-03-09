#Status: Works fine but have not implemented a way for users to
#   specify a certain directory.

#'Function to list contents of a Dropbox folder. If no folder is specified, function will list contents of root folder.
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param path  The directory to list. Not yet implemented
#'@param verbose logical. FALSE returns a list with file names in root folder. TRUE returns a data.frame with the following fields: .id,revision, rev, thumb_exists, bytes,modified, path, is_dir, icon,root,size,mime_type.
#'@param recursive logical. Setting this to true will list all your dropbox files. Not yet implemented.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export dropbox_dir
#'@examples \dontrun{
#' dropbox_dir(cred)
#' dropbox_dir(cred, recursive = TRUE)
#' dropbox_dir(cred,path='/specific_folder')
#' dropbox_dir(cred,path='/specific_folder',verbose = TRUE)
#' returns a dataframe with fields .id,
#'}
dropbox_dir <- function(cred, path = FALSE, recursive = FALSE, verbose = FALSE) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    # Assuming user did specify a path to list, then make sure it exists
    if(!is.null(path)) {
        if(!is.dropbox.object(path)) {
            stop("There is no such folder in your Dropbox", call. = FALSE)
        }
    }
    status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
    metadata <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/metadata/dropbox/"))
    names(metadata$contents) = basename(sapply(metadata$contents, `[[`,
        "path"))
    file_system <- metadata[[8]]
    # Verbose will return all file information. Otherwise only return relevant fields.
    if (!verbose) {
        status <- (ldply(file_system, data.frame))
        return(status$.id)
    } else {
        return(ldply(file_system, data.frame))
    }
}

# Todos:
# Need to check validity of path as an input. Should be
#   is.dropbox.dir(path)
# Need to allow for a recursive directory listing.
