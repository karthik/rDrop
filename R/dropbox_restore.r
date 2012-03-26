#' functions to restore a file to an older version
#'
#' This function currently does not work.
#' @param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param file  The path to the file.
#' @import RJSONIO ROAuth
#' @export
#' @examples \dontrun{
#' dropbox_restore(cred, '/test/file.csv', rev = '213566')
#'}
dropbox_restore <- function(cred, path, rev = NULL) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    if (is.null(rev)) {
        stop("You need to specify a revision number to restore a file \n",
            call. = F)
    }
        # List should contain path and revision number
        # 1. Check revision to make sure it exists.
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#restore
# Status: Still setting up
