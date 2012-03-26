#' Function to save an object from R into Dropbox
#'
#' This function currently does not work.
#' @param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param content The file contents to be uploaded. Requires a multipart upload (multipart/form-data), and the filename parameter of this field should be set to the desired destination filename. While signing this request for OAuth, the file parameter should be set to the destination filename, and then switched to the file contents when preparing the multipart request.
#' @export
#' @import RJSONIO ROAuth
#' @examples \dontrun{
#' dropbox_save(robject, file='filename')
#'}
dropbox_save <- function(cred, content) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
    if (is.null(content)) {
        stop("Nothing to save", call. = FALSE)
    }
    input <- RCurl:::uploadFunctionHandler(content, TRUE)
    content_upload <- OAuthRequest(cred, "https://api-content.dropbox.com/1/files_put/dropbox/", 
        "POST", upload = TRUE, .opts = list(readfunction = input, 
            infilesize = nchar(content), verbose = TRUE))
    content_upload <- cred$put("https://api-content.dropbox.com/1/files_put/dropbox/Public/", 
        .opts = list(readfunction = input, infilesize = nchar(content), 
            verbose = TRUE))
}
# API documentation: GET:
#
#
#
#   https://www.dropbox.com/developers/reference/api#files-GET
# POST:
#
#
#
#   https://www.dropbox.com/developers/reference/api#files-POST
# Testing
# df <- data.frame(x=1:10, y=rnorm(10)) 
