# Status: Works - needs error handling

#' Function to copy files or folder within Dropbox.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param from_path Specifies the file or folder to be copied from relative to root.
#'@param to_path Specifies a destination path, including the new name for the file or folder, relative to root.
#'@keywords
#'@seealso dropbox_move dropbox_create_folder
#'@return
#'@alias
#'@import RJSONIO
#'@export dropbox_copy
#'@examples \dontrun{
#' dropbox_copy(dropbox_token, 'file.csv', 'folder2')
#'}
dropbox_copy <- function(cred, from_path = NULL, to_path = NULL, 
    overwrite = FALSE) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
    if (is.null(from_path) || is.null(to_path)) {
        stop("Missing path for source and/or destination", call. = F)
    }
    if(!exists.in.dropbox(cred, from_path)) {
        stop("Source file or folder does not exist", call. = FALSE)
    }

    if(!exists.in.dropbox(cred, to_path, is_dir = TRUE)) {
        stop("Destination is not a valid folder", call. = FALSE)
    }
    # Below does not work
    copy <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/copy", 
        list(root = "dropbox", from_path = from_path, to_path = to_path)))
    # OUTPUT SUCCESS MESSAGE
    invisible()
}
# API documentation: https://www.dropbox.com/developers/reference/api#fileops-copy

# Error handling needed
# 1. Check whether from_path exists
# 2. Check whether to_path exists. 

# Tests
# copy <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/copy", 
#         list(root = "dropbox", from_path = "/dryadmetadata2.csv", to_path = "/test_works")))