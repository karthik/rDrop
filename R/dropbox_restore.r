#' functions to restore a file to an older version (not working)
#'
#' This function currently does not work.
#' @param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param file  The path to the file.
#' @param rev  Revision number to restore back to.
#' @import RJSONIO ROAuth
#' @export
#' @examples \dontrun{
#' dropbox_restore(cred, file = '/test/file.csv', rev = '213566')
#'}
dropbox_restore <- function(cred, file, rev = NULL) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
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
