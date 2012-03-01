#Status: Works fine but have not implemented a way for users to specify a certain directory.

#' List contents of a Dropbox account
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param verbose logical. FALSE returns a list with file names in root folder. TRUE returns a data.frame with the following fields: .id,revision, rev, thumb_exists, bytes,modified, path, is_dir, icon,root,size,mime_type.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export dropbox_dir
#'@examples \dontrun{
#' dropbox_dir(cred)
#' returns a dataframe with fields .id,
#'}
dropbox_dir <- function(cred, verbose = FALSE) {
    if (!is.dropbox.cred(cred))
        stop("Invalid Oauth credentials", call. = FALSE)
    status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
    metadata <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/metadata/dropbox/"))
    names(metadata$contents) = basename(sapply(metadata$contents,
        `[[`, "path"))
    file_system <- metadata[[8]]
    if (!verbose) {
        status <- (ldply(file_system, data.frame))
        return(status$.id)
    } else {
        return(ldply(file_system, data.frame))
    }
}

# Issues:
# Need an argument to allow users to list contents of a specific directory.