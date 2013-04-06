#' Check to see if an object exists in Dropbox
#'
#' This function is meant for internal use especially when copying or moving files.
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param path Path to object
#' @param  is_dir if set to TRUE, will only look for folders. Otherwise will return file or folder.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#' @param ... optional additional curl options (debugging tools mostly).
#' @export
#' @return logical. TRUE/FALSE
#' @examples \dontrun{
#' exists.in.dropbox(cred,'test_folder')
#' exists.in.dropbox(cred,'test_folder',is_dir='dir')
#'}
exists.in.dropbox <-
function(cred, path = NULL, is_dir = NULL, ..., curl = getCurlHandle())
{
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
                                                                    # default response so function can proceed.
    response <- TRUE
    if (is.null(path)) {
        stop("You did not specify an object to verify", call. = FALSE)
    }
                                                                    # First search Dropbox to see if the object exists
    full_path <- path
    if (full_path == "/") {
        response <- TRUE
    } else {
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
    }  # end the else
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
dropbox.file.info <-
function(cred, path_to_file) {
                                                                    # Add leading slash in case it is missing
    if (!grepl("^/", path_to_file)) {
        path_to_file <- paste("/", path_to_file, sep = "")
    }
    dfile <- dropbox_search(cred, path_to_file)
    dfile  # Return a list containing filename, filetype, date
                                                                    #   modified, and revision number.
}
#' Verify paths for copy and move operations
#'
#' Function is meant for internal use in \code{\link{dropbox_move}} and \code{\link{dropbox_copy}}
#' @param from_path source path
#' @param  to_path destination path. Leave blank for dropbox root.
#' @return list with clean paths
#' @export sanitize_paths
#' @examples \dontrun{
#' santize_paths(from_path, to_path)
#'}
sanitize_paths <-
function(from_path, to_path = NULL, cred = NULL)
{
    if (is.null(to_path)) 
        to_path <- "/"
    if (!grepl("^/", from_path)) 
        from_path <- paste("/", from_path, sep = "")
    if (grepl("/$", from_path)) 
        from_path <- str_sub(from_path, end = -1)
    if (!grepl("^/", to_path)) 
        to_path <- paste("/", to_path, sep = "")
                # browser()
    if (dirname(to_path) == "/" && basename(to_path) == "") 
        to_path <- paste("/", basename(from_path), sep = "")
    if (dirname(to_path) == "/" && basename(to_path) != "") 
        to_path <- paste("/", basename(to_path), sep = "")
    if (nchar(to_path) > 1 && !grepl("\\.", to_path)) 
        to_path <- paste(to_path, "/", basename(from_path), sep = "")
                # cat('from: ', from_path, '\n to: ', to_path)

    ans <- list(from_path, to_path)

    if(length(cred)) 
       lapply(ans, function(x) getPath(x, cred = cred))
    else
      ans
} 
