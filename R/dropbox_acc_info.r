#'Retrieve Dropbox account summary
#'
#' @param cred An object of class ROAuth with Dropobox specific credentials.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly)#' @export dropbox_acc_info
#' @keywords authentication OAuth
#' @seealso \code{\link{dropbox_auth}}
#' @return list containing referral_link, display_name, uid, country, quota_info, and email.
#' @examples \dontrun{
#' dropbox_acc_info(cred)
#'}
dropbox_acc_info <- function(cred, curl = getCurlHandle(), 
    ...) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
    info <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/account/info"))
    return(info)
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#account-info   
