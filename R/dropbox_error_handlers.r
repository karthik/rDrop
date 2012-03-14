# A set of functions meant to handle errors arising from
#   all dropbox file ops.
#'Verifies whether a user has specified a correct Oauth credential for Dropbox
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@return logical
#'@export 
#'@examples \dontrun{
#' is.dropbox.cred(your_dropbox_credential_object)
#'}
is.dropbox.cred <- function(cred, response = TRUE) {
    foo <- deparse(substitute(cred))
    if (missing(cred)) {
        response <- FALSE
    }
    if (response) {
        if (foo %in% ls(envir = .GlobalEnv)) {
            response <- TRUE
        } else {
            response <- FALSE
        }
    }
    if (response) {
        response <- ifelse(class(cred) != "OAuth", FALSE, TRUE)
    }
    if (response) {
        response <- ifelse(grep("dropbox", cred$requestURL) != 1, 
            FALSE, TRUE)
    }
    return(response)
}
#' Check to see if an object exists in Dropbox
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path Path to object
#'@param  type = NULL dir or file if a function needs to know. Otherwise it will ignore type and return TRUE if object exists in Dropbox folder.
#'@return logical
#'@export
#'@examples \dontrun{
#' exists.in.dropbox(cred,'test_folder')
#' exists.in.dropbox(cred,'test_folder',is_dir='dir')
#'}
exists.in.dropbox <- function(cred, path = NULL, is_dir = NULL) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
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
    res <- dropbox_search(cred, query)
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
#'Checks if a supplied path is a file in users Dropbox account.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path path to file or folder that needs verification.
#'@seealso is.dropbox.dir dropbox.file.info
#'@return logical
#'@export 
#'@examples \dontrun{
#'
#'}
is.dropbox.file <- function(cred, path) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Dropbox credentials", call. = F)
    }
    is_d_file <- TRUE
    res <- dropbox_search(cred, path)
    if (is.null(res)) {
        is_d_file <- FALSE
    }
    if (is_d_file) {
        if (dim(res)[1] > 1) {
            is_d_file <- FALSE
        }
    }
    if (is_d_file) {
        if (!unique(res$is_dir)) {
            is_d_file <- FALSE
        }
    }
    return(is_d_file)
}
#'Return file attributes for a specified file supplied in the path argument.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path_to_file <what param does>
#'@seealso is.dropbox.file is.dropbox.dir
#'@return list
#'@export dropbox.file.info
#'@examples \dontrun{
#'
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
#'Function to handle errors if a returned object is not the excepted JSON object
#'
#'@param dropbox_call A function call to a Dropbox method via OAuth$handshake()
#'@return logical
#'@export
#'@examples \dontrun{
#' example forthcoming
#'}
is.valid.dropbox.operation <- function(dropbox_call) {
    # if dropbox_call succeeds
    # return the object received
    # else
    # \treturn a valid and useful error.
}
#'Checks whether supplied revision number is valid on Dropobx
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path path to file or folder. Full path if file/folder is not in Dropbox root.
#'@param revision revision number
#'@return logical
#'@export
#'@examples \dontrun{
#' Not yet coded.
#'}
is.valid.revision <- function(cred, path = NULL, revision = NULL) {
}
# need to extract revision number
# Check for leading slash first using grep. If missing,
#   append it.
# Checks revision number for a file in dropbox and returns
#   a logical yes/no. 