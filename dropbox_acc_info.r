Works fine.
#'<brief desc>
#'
#'<full description>
#'@param cred = NULL <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#' dropbox_acc_info(cred)
#'}
dropbox_acc_info <- function(cred = NULL) {
if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
 return(status)
}

