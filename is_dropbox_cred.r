Í# Status: Works but fails to recongnize missing objects passed as
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
is.dropbox.cred <- function(cred) {
    response <- TRUE
    if (missing(cred)) {
        response <- FALSE
    }
    if (response == TRUE) {
        if (!exists(as.character(substitute(cred)), envir = .GlobalEnv)) {
            response <- FALSE
        }
    }
    if (response == TRUE)
        response <- ifelse(class(cred) != "OAuth", FALSE, TRUE)
    if (response == TRUE)
        response <- ifelse(grep("dropbox", cred$requestURL) != 1, FALSE,
            TRUE)
    return(response)
}
