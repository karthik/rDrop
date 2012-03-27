#' Similar to /shares. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the file, so that you can effectively stream the contents of your media.
#'
#' This function behaves very similar to \code{dropbox_share}. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the file, so that you can effectively stream the contents of your media.
#' @param cred  Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param path Path to object on Dropbox.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly)
#' @return list with URL to R object and expiration date/time.
#' @export dropbox_media
#' @examples \dontrun{
#'
#'}
dropbox_media <- function(cred, path = NULL, curl = getCurlHandle(),
    ...) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
    if (!(exists.in.dropbox(cred, path = path))) {
        stop("Content does not exist in dropbox", call. = FALSE)
    }
    if (!is.null(path)) {
        url <- paste("https://api.dropbox.com/1/media/dropbox/",
            path, sep = "")
    }
    media <- fromJSON(OAuthRequest(cred, url))
    return(media)
}
# API Documentation:
#   https://www.dropbox.com/developers/reference/api#media
