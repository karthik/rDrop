# Status: Not currently working. Works but gives me junk
#   data (real data but badly formatted)
#'Downloads a file from your Dropbox
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param  file_to_get Specifies the path to the file you want to retrieve.
#'@keywords
#'@seealso
#'@return file
#'@alias
#'@import RJSONIO ROAuth
#'@export dropbox_get
#'@examples \dontrun{
#'
#'}
dropbox_get <- function(cred, file_to_get) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    if (!(exists.in.dropbox(cred, path = file_to_get, is_dir = FALSE))) {
        stop("File or folder does not exist", call. = FALSE)
    }
    downloaded_file <- cred$OAuthRequest("https://api-content.dropbox.com/1/files/", 
        list(root = "dropbox", path = file_to_get), "GET")
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#files-GET
# Notes
# ------------------------------------------------
# Should be limited to text or csv files.
# No pdfs, or images, and stuff. Right?
# # Errors
# Warning message:
# In grepl('\\\\u[0-9]', str) : input string 1 is
#   invalid in this locale
# Calls: <Anonymous> ... getForm -> getURLContent ->
#   <Anonymous> -> encode -> grepl 
