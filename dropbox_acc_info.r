#Status: Almost fully works...need error catching

#'Retrieve Dropbox account summary
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@keywords authentication OAuth
#'@seealso
#'@return list containing referral_link,display_name,uid,country,quota_info, and email
#'@alias
#'@export dropbox_acc_info
#'@examples \dontrun{
#' dropbox_acc_info(cred)
#'}
dropbox_acc_info <- function(cred) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
    return(status)
}

# Errors:
# Passing a non-existent variable is caught in is.dropbox.cred()
#   function but does not work when passed to dropbox_acc_info()
#
# Example
#ls()
# [1] 'cred'
# # only my dropbox credential object in my namespace
# >is.dropbox.cred(variable)
# [1] FALSE
# good because there isn't an object named variable
# >is.dropbox.cred(cred)
# [1] TRUE
# good because cred is an OAuth object specific to Dropbox
# # The function to check works fine even on objects that don't
#   exist in the namespace
# >dropbox_acc_info(variable)
# Error in ifelse(class(cred) != 'OAuth', FALSE, TRUE) :
#   object 'variable' not found
# # Odd because it is failing in is.dropbox.cred() but works when
#   that function is called directly.
# >dropbox_acc_info(cred)
# $referral_link
# [1] 'https://www.dropbox.com/referrals/NTIyMjM0MTE5'
#....and the rest of my account info is returned.

