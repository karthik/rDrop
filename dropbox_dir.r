#Status: Works fine but have not implemented a way for
#   users to specify a certain directory.
#'Function to list contents of a Dropbox folder. If no folder is specified, function will list contents of root folder.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path  The directory to list. Not yet implemented
#'@param verbose logical. FALSE returns a list with file names in root folder. TRUE returns a data.frame with the following fields: .id,revision, rev, thumb_exists, bytes,modified, path, is_dir, icon,root,size,mime_type.
#'@param recursive logical. Setting this to true will list all your dropbox files. Not yet implemented.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export dropbox_dir
#'@import stringr
#'@examples \dontrun{
#' dropbox_dir(cred)
#' dropbox_dir(cred, recursive = TRUE)
#' dropbox_dir(cred,path='/specific_folder')
#' dropbox_dir(cred,path='/specific_folder',verbose = TRUE)
#' returns a dataframe with fields .id,
#'}
dropbox_dir <- function(cred, path = NULL, verbose = FALSE) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
    url <- "https://api.dropbox.com/1/metadata/dropbox/"
    # Assuming user did specify a path to list, then make sure
    #   it exists
    if (!is.null(path)) {
        if (!exists.in.dropbox(cred, path, is_dir = TRUE)) {
            stop("There is no such folder in your Dropbox", call. = FALSE)
        }
    }
    if (!is.null(path)) {
        # Remove trailing slash
        if (grepl("/$", path)) {
            path <- str_sub(path, end = str_length(path) - 1)
        }
    }
    if (!is.null(path) & length(path) > 0) {
        url <- paste(url, path, "/", sep = "")
    }
    metadata <- fromJSON(cred$OAuthRequest(url))
    names(metadata$contents) <- basename(sapply(metadata$contents, 
        `[[`, "path"))
    file_sys <- ldply(metadata$contents, data.frame)
    # Verbose will return all file information. Otherwise only
    #   return relevant fields.
    if (!verbose) {
        return(file_sys$.id)
    } else {
        return(file_sys)
    }
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#metadata