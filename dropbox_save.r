#Status: DOES NOT WORK YET
#' Function to save an object from R into Dropbox
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param  path The path to the folder the file should be uploaded to. This parameter should not point to a file.
#'@param  file The file contents to be uploaded. Requires a multipart upload (multipart/form-data), and the filename parameter of this field should be set to the desired destination filename. While signing this request for OAuth, the file parameter should be set to the destination filename, and then switched to the file contents when preparing the multipart request.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@import RJSONIO ROAuth
#'@examples \dontrun{
#' dropbox_save(robject, file='filename')
#'}
dropbox_save <- function(cred, path, file) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    df <- data.frame(x = 1:10, y = 1:10)
    content <- "This is simple content"
    inputz <- RCurl:::uploadFunctionHandler(df, TRUE)
    trace(inputz)
    # Below crashes R64.app
    xx <- cred$OAuthRequest("https://api-content.dropbox.com/1/files_put/dropbox/", 
        , "POST", upload = TRUE, readdata = inputz, infilesize = nchar(content) - 
            3L, verbose = TRUE)
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
# x <-
#
#
#
#   cred$OAuthRequest('https://api-content.dropbox.com/1/files_put/dropbox/',list(file=df,
#   filename='file.rdata', mime_type='text/csv'), 'POST')