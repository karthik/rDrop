# Duncan: Perhaps this might be a better way to read contents of a Dropbox file in R rather than dropbox_get()?

#'Returns a link directly to a file.
#'Similar to /shares. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the file, so that you can effectively stream the contents of your media.
#'@param cred <what param does>
#'@param path = NULL <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@import RJSONIO ROAuth
#'@export dropbox_media
#'@examples \dontrun{
#'
#'}
dropbox_media <- function(cred, path = NULL) {
 # function guts.
}
# API Documentation: https://www.dropbox.com/developers/reference/api#media