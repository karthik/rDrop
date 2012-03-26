#'Returns a link directly to a file (not working)
#'
#' This function behaves very similar to \code{dropbox_share}. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the file, so that you can effectively stream the contents of your media.
#' @param cred  Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param path Path to object on Dropbox.
#' @return file
#' @import RJSONIO ROAuth
#' @export dropbox_media
#' @examples \dontrun{
#'
#'}
dropbox_media <- function(cred, path = NULL) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
                        # function guts.
}
# API Documentation:
#   https://www.dropbox.com/developers/reference/api#media
# Duncan: Perhaps this might be a better way to read
#   contents of a Dropbox file in R rather than
#   dropbox_get()?
