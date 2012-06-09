#' Creates and returns a shareable link to files or folders.
#'
#' Returns a list containing the URL to a zipped copy of a folder or a direct link in
#' case input is a file. Also returns a date when link will expire.
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param file Path to the file or folder you want a shareable link to.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @keywords sharing share_url
#' @seealso \code{\link{dropbox_media}}
#' @export
#' @return list with url to file or zipped folder and expiry date.
#' @examples \dontrun{
#' dropbox_share(cred, 'test_folder')
#' > dropbox_share(db_cred, 'test_works/test.csv')
#' $url
#' [1] 'http://db.tt/vlwCtRxr'
#' $expires
#' [1] 'Sat, 28 Apr 2012 20:55:42 +0000'
#'}
dropbox_share <- function(cred, file = NULL, curl = getCurlHandle(), 
    ...) {
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    if (is.null(file)) 
        stop("No file of folder to share", call. = FALSE)
    if (!(exists.in.dropbox(cred, file, ..., curl = getCurlHandle()))) 
        stop("Folder doesn't exist", call. = FALSE)
    if (grepl("^/", file)) 
        file <- str_sub(file, 2)
    path_to_share <- sprintf("https://api.dropbox.com/1/shares/dropbox/%s", 
        file, sep = "")
    result <- fromJSON(OAuthRequest(cred, path_to_share, , ..., curl = curl))
    res <- list()
    res$url <- result[[1]]
    res$expires <- result[[2]]
    return(res)
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#shares   
