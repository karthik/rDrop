#' Stream data from Dropbox
#'
#' This function behaves very similar to \code{dropbox_share}. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the file, so that you can effectively stream the contents of your media.
#' @param cred  Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param path Path to object on Dropbox.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @seealso \code{\link{dropbox_share}}
#' @return list with URL to R object and expiration date/time.
#' @export dropbox_media
#' @examples \dontrun{
#' dropbox_media(db_cred, '/data/file.csv')
#'}
dropbox_media <-
function(cred, path = NULL, curl = getCurlHandle(), ..., .checkIfExists = TRUE) {
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    if (.checkIfExists && !(exists.in.dropbox(cred, path = path, ..., curl = getCurlHandle()))) {
        stop("Content does not exist in dropbox", call. = FALSE)
    }
    if (!is.null(path)) {
        url <- paste("https://api.dropbox.com/1/media/dropbox/", 
            path, sep = "")
    }
    media <- fromJSON(OAuthRequest(cred, url), ..., curl = curl)
    return(as.list(media))
}
# API Documentation:
#   https://www.dropbox.com/developers/reference/api#media   
