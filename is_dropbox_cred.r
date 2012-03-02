# Status: Works but fails to recongnize missing objects passed as
#   cred from dropbox_acc_info()

#'Verifies whether a user has specified a correct Oauth credential for Dropbox
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export is.dropbox.share
#'@examples \dontrun{
#' is.dropbox.cred(your_dropbox_credential_object)
#'}
is.dropbox.cred <- function(cred, response = TRUE) {
    # Issue: seems to be looking for a variable named cred and not what is passed to the function itself.
    if (missing(cred)) {
        response <- FALSE
    }
    if (response) {

       response <- ifelse(as.character(substitute(cred)) %in% ls( envir = .GlobalEnv),TRUE,FALSE )
   }
    if (response) {
        response <- ifelse(class(cred) != "OAuth", FALSE, TRUE)
    }
    if (response) {
        response <- ifelse(grep("dropbox", cred$requestURL) != 1, FALSE,
            TRUE)
    }
    return(response)
}
