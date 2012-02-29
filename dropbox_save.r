NEEDS WORK
#'<brief desc>
#'
#'<full description>
#'@param cred <what param does>
#'@param  file <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox_save <- function(cred, file) {
	if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
    content = "This is simple content"
    input = RCurl:::uploadFunctionHandler(content, TRUE)
    trace(input)
    # Below crashes R64
    xx = cred$OAuthRequest("https://api-content.dropbox.com/1/files_put/dropbox/up",
        , "POST", upload = TRUE, readdata = input, infilesize = nchar(content) -
            3L, verbose = TRUE)
}
