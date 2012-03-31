#'Function to list contents of a Dropbox folder.
#'
#' If no folder is specifies, it will only list contents of the root folder.
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param path  The directory to list. Not yet implemented
#' @param verbose logical. FALSE returns a list with file names in root folder. TRUE returns a \code{data.frame} with the following fields: id, revision, rev, thumb_exists, bytes, path, modified, and is_dir
#' @param deleted logical. Default is FALSE. Set to TRUE to also list deleted files.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @return directory listing with file/folder names unless \code{verbose = TRUE} in which case a data.frame is returned.
#' @export dropbox_dir
#' @examples \dontrun{
#' dropbox_dir(db_cred)
#' dropbox_dir(db_cred, path='/specific_folder')
#' dropbox_dir(db_cred,path='/specific_folder', verbose = TRUE)
#' returns a dataframe with fields .id,
#'}
dropbox_dir <- function(cred, path = NULL, verbose = FALSE,
    deleted = FALSE, curl = getCurlHandle(), ...) {
    if (!is(cred, "DropboxCredentials") || missing(cred))
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", call.= FALSE)

    url <- "https://api.dropbox.com/1/metadata/dropbox/"

    if (!is.null(path)) {
        if (!exists.in.dropbox(cred, path, is_dir = TRUE,..., curl = getCurlHandle())) {
            stop("There is no such folder in your Dropbox", call. = FALSE)
        }
    }
    if (!is.null(path)) {

        if (grepl("/$", path)) {
            path <- str_sub(path, end = str_length(path) - 1)
        }
    }
    if (!is.null(path) & length(path) > 0) {
        url <- paste(url, path, "/", sep = "")
    }
    metadata <- fromJSON(OAuthRequest(cred, url, list(include_deleted = deleted), ..., curl = curl))
    names(metadata$contents) <- basename(sapply(metadata$contents,
        `[[`, "path"))
    file_sys <- ldply(metadata$contents, data.frame)

    if (!verbose) {
        return(file_sys$.id)
    } else {
        return(file_sys)
    }
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#metadata
# Issues: Fails with empty directories
# filename, revision, thumb, bytes, modified, path, and is_dir
