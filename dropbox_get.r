NEEDS WORK
# Downloads a file from your Dropbox
# https://api-content.dropbox.com/1/files/<root>/<path>
#'<brief desc>
#'
#' Downloads files from Dropbox
#'@param cred <what param does>
#'@param  file_to_get <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox_get <- function(cred, file_to_get) {
	if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
    if (length(file_to_get) == 0) {
        stop("You did not specify a file to download")
    }
    downloaded_file <- cred$OAuthRequest("https://api-content.dropbox.com/1/files/",
        list(root = "dropbox", path = file_to_get))
}

# Notes
# Should be limited to text or csv files.