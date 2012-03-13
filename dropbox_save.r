#Status: DOES NEEDS WORK, YET
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
#'@examples \dontrun{
#'
#'}
dropbox_save <- function(cred, path, file) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    content <- "This is simple content"
    input <- RCurl:::uploadFunctionHandler(df, TRUE)
    trace(input)
    # Below crashes R64.app
    xx <- cred$OAuthRequest("https://api-content.dropbox.com/1/files_put/dropbox/", 
        , "POST", upload = TRUE, readdata = input, infilesize = nchar(content) - 
            3L, verbose = TRUE)
}

# Below does not work.
# Perhaps use the Rook library to add header information
#   such as mime-type and also possibly upload multiple
#   files at once?

#  https://api-content.dropbox.com/1/files/<root>/<path>

#
#
#   cred$OAuthRequest('https://api-content.dropbox.com/1/files/dropbox/',
# , 'POST', upload = TRUE, readdata = input, infilesize =
#   nchar(df) -
#             3L, verbose = TRUE) 
