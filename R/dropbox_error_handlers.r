#' Check to see if an object exists in Dropbox
#'
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param path Path to object
#' @param  is_dir if set to TRUE, will only look for folders. Otherwise will return file or folder.
#' @export
#' @return logical. TRUE/FALSE
#' @examples \dontrun{
#' exists.in.dropbox(cred,'test_folder')
#' exists.in.dropbox(cred,'test_folder',is_dir='dir')
#'}
exists.in.dropbox <- function(cred, path = NULL, is_dir = NULL, ..., curl = getCurlHandle()) {
    if (class(cred) != "DropboxCredentials") {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
                                                        # default response so function can proceed.
    response <- TRUE
    if (is.null(path)) {
        stop("You did not specify an object to verify", call. = FALSE)
    }
                                                        # First search Dropbox to see if the object exists
    full_path <- path
                                                        # If leading slash is missing, add it.
    if (!grepl("^/", full_path)) {
        full_path <- paste("/", full_path, sep = "")
    }
                                                        # Remove trailing slash
    if (grepl("/$", full_path)) {
        full_path <- str_sub(full_path, end = str_length(full_path) -
            1)
    }
    query <- basename(path)
    res <- dropbox_search(cred, query, ..., curl = curl)
    if (is.null(res)) {
        response <- FALSE
    }
    if (empty(res)) {
        response <- FALSE
    }
                                                        # OK, object exists, but let's see if there was more than
                                                        #   one result
    if (!identical(query, full_path)) {
        res <- res[which(res$path == full_path), ]
        if (dim(res)[1] != 1) {
            response <- FALSE
        }
    }
                                                        # OK, only one result returned.
    if (response) {
        if (!is.null(is_dir)) {
            if (is_dir) {
                response <- ifelse(res$is_dir, TRUE, FALSE)
            }
            if (!is_dir) {
                response <- ifelse(!res$is_dir, TRUE, FALSE)
            }
        }
    }
    return(response)
}
#'Return file attributes for a specified file supplied in the path argument.
#'
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param path_to_file Path to file relative to Dropbox root.
#' @seealso \code{link{is.dropbox.file}}
#' @return list
#' @export dropbox.file.info
#' @examples \dontrun{
#' dropbox.file.inco(cred, '/folder/file.txt')
#'}
dropbox.file.info <- function(cred, path_to_file) {
                                                        # Add leading slash in case it is missing
    if (!grepl("^/", path_to_file)) {
        path_to_file <- paste("/", path_to_file, sep = "")
    }
    dfile <- dropbox_search(cred, path_to_file)
                                                        # Return a list containing filename, filetype, date
                                                        #   modified, and revision number.
}
# #'Function to handle errors if a returned object is not the excepted JSON object
# #'
# #' @param dropbox_call A function call to a Dropbox method via OAuth$handshake()
# #' @return logical
# #' @export
# #' @examples \dontrun{
# #' example forthcoming
# #'}
# is.valid.dropbox.operation <- function(dropbox_call) {
#             # if dropbox_call succeeds
#             # return the object received
#             # else
#             # 	return a valid and useful error.
# }
# #'Checks whether supplied revision number is valid on Dropobx
# #'
# #' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
# #' @param path path to file or folder. Full path if file/folder is not in Dropbox root.
# #' @param revision revision number
# #' @return logical
# #' @export
# #' @examples \dontrun{
# #' Not yet coded.
# #'}
# is.valid.revision <- function(cred, path = NULL, revision = NULL) {
# }
# # need to extract revision number
# # Check for leading slash first using grep. If missing,
# #   append it.
# # Checks revision number for a file in dropbox and returns
# #   a logical yes/no.
