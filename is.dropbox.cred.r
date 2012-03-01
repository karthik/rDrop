#'Verifies whether once has specified a correct Oauth credential for Dropbox
#'
#'<full description>
#'@param cred <what param does>
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
