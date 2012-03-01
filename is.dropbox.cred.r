#'Verifies whether a user has specified a correct Oauth credential for Dropbox
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
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
        response <- ifelse(grep("dropbox", cred$requestURL) !=
            1, FALSE, TRUE)
    return(response)
}
