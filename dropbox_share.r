#' Creates and returns a shareable link to files or folders.
#'
#' Returns a URL to a zipped copy of a folder or a direct link in
#' case input is a file. Also returns a date when link will expire.
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param file Specifies the path to the file or folder you want a shareable link to.
#'@keywords
#'@seealso
#'@return list with url to zip file and expiry date.
#'@alias
#'@import RJSONIO ROAuth
#'@export dropbox_share
#'@examples \dontrun{
#' dropbox_share(cred, 'test_folder')
#'}
dropbox_share <- function(cred, file = NULL) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
    if (is.null(file)) {
        stop("No file of folder to share", call. = FALSE)
    }
    if (!(exists.in.dropbox(cred, file))) {
        stop("Folder already exists", call. = FALSE)
    }
    path_to_share <- paste("https://api.dropbox.com/1/shares/dropbox/", 
        file, sep = "")
    cred$OAuthRequest(path_to_share)
    result <- fromJSON(cred$OAuthRequest(path_to_share))
    res <- list()
    res$url <- result[[1]]
    res$expires <- result[[2]]
    return(res)
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#shares