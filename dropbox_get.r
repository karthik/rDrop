# Status: Not currently working.

#' Downloads a file from your Dropbox
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param  file_to_get Specifies the path to the file you want to retrieve.
#'@keywords
#'@seealso
#'@return file
#'@alias
#'@export dropbox_get
#'@examples \dontrun{
#'
#'}
dropbox_get <- function(cred, file_to_get) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    if (length(file_to_get) == 0) {
        stop("No file requested \n")
    }
    downloaded_file <- cred$OAuthRequest("https://api-content.dropbox.com/1/files/",
        list(root = "dropbox", path = file_to_get))
}

# Notes
# Should be limited to text or csv files.
