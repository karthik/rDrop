#'Retrieve Dropbox account summary
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@keywords authentication OAuth
#'@seealso \code{\link{dropbox_auth}}
#'@return list containing referral_link, display_name, uid, country, quota_info, and email.
#'@alias
#'@import RJSONIO ROAuth
#'@export dropbox_acc_info
#'@examples \dontrun{
#' dropbox_acc_info(cred)
#'}
dropbox_acc_info <- function(cred) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
    status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
    return(status)
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#account-info 
