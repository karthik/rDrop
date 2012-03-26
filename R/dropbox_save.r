#' Function to save an object from R into Dropbox (not working)
#'
#' This function currently does not work.
#' @param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param content The file contents to be uploaded. Requires a multipart upload (multipart/form-data), and the filename parameter of this field should be set to the desired destination filename. While signing this request for OAuth, the file parameter should be set to the destination filename, and then switched to the file contents when preparing the multipart request.
#' @param file Name of file to be saved. If blank, the name of the R object will be used.
#' @export
#' @import RJSONIO ROAuth
#' @examples \dontrun{
#' dropbox_save(robject, file='filename')
#'}
dropbox_save <- function(cred, content, file = NULL) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
    if (is.null(content)) {
        stop("Nothing to save", call. = FALSE)
    }
    if (is.null(file)) {
        filename <- paste(deparse(substitute(content)), ".rda",
            sep = "")
    } else {
        filename <- paste(file, ".rda", sep = "")
    }
    input <- RCurl:::uploadFunctionHandler(content, TRUE)
    destination <- paste("https://api-content.dropbox.com/1/files_put/dropbox/",
        filename, sep = "")
    content_upload <- OAuthRequest(cred, destination, "POST",
        upload = TRUE, .opts = list(readfunction = input, infilesize = nchar(content),
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
