#' Creates and returns a shareable link to files or folders.
#'
#' Returns a list containing the URL to a zipped copy of a folder or a direct link in
#' case input is a file. Also returns a date when link will expire.
#' @param cred An object of class ROAuth with Dropobox specific credentials.
#' @param file Path to the file or folder you want a shareable link to.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly)#' @keywords sharing share_url
#' @return list with url to file or zipped folder and expiry date.
#' @examples \dontrun{
#' dropbox_share(cred, 'test_folder')
#'}
#' @export
dropbox_share <- function(cred, file = NULL, curl = getCurlHandle(), 
    ...) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
    if (is.null(file)) {
        stop("No file of folder to share", call. = FALSE)
    }
    if (!(exists.in.dropbox(cred, file))) {
        stop("Folder doesn't exist")
    }
    path_to_share <- paste("https://api.dropbox.com/1/shares/dropbox/", 
        file, sep = "")
    result <- fromJSON(OAuthRequest(cred, path_to_share))
    res <- list()
    res$url <- result[[1]]
    res$expires <- result[[2]]
    return(res)
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#shares   
