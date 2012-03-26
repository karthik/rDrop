#'Function to delete a file or folder from Dropbox
#'
#' Function will delete specified object in Dropbox (assuming it exists). To skip deletion conformation, set ask = FALSE in function call. Accidentally deleted objects may be recovered using Dropbox's restore feature.
#' @param cred An object of class ROAuth with Dropobox specific credentials.
#' @param file_to_delete Specifies the path to the file or folder to be deleted.
#' @param ask logical set to TRUE. If set to false, function will not confirm delete operation
#' @return Nothing. A message upon successful deletion.
#' @export dropbox_delete
#' @examples \dontrun{
#' dropbox_delete(dropbox_credential, 'path/to/file')
#'}
dropbox_delete <- function(cred, file_to_delete = NULL, 
    ask = TRUE) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
                        # Replace with a more elegant file exists checker.
    if (!exists.in.dropbox(cred, file_to_delete)) {
        stop("File or folder not found", call. = FALSE)
    }
    if (ask == TRUE) {
        verify <- readline(paste("Are you sure you want to delete", 
            file_to_delete, " (Y/N)? "))
        verify <- toupper(verify)
        if (verify != "Y" & verify != "N") {
            stop("Unexpected response. \n", call. = F)
        }
    }
    if (verify == "Y" | ask == FALSE) {
        deleted <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/fileops/delete", 
            list(root = "dropbox", path = file_to_delete)))
        if (is.list(deleted)) {
            cat(deleted$path, "was successfully deleted on", 
                deleted$modified, "\n")
        }
    }
}
# API documentation:
#
#
#
#
#   https://www.dropbox.com/developers/reference/api#fileops-delete   
