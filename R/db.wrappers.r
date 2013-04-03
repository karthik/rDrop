#' Read CSV files stored in Dropbox
#'
#' This function is a simple wrapper around \code{\link{dropbox_get}} for csv files.
#' @param dropbox_credentials Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param  file_to_get Specifies the path to the file you want to retrieve. Path must be relative to \code{Dropbox root}.
#' @export
#' @seealso dropbox_get
#' @return data.frame
#' @examples \dontrun{
#' my_data <- db.read.csv(db_cred, 'data.csv', header = TRUE)
#'}
db.read.csv <- function(dropbox_credentials, file_to_get) {
    file <- dropbox_get(dropbox_credentials, file_to_get)
    return(unserialize(file))
}
