#'Status:  Works, But I need to add in search paths.
#'Function to delete a file or folder from Dropbox
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param file_to_delete Specifies the path to the file or folder to be deleted.
#'@param ask logical set to TRUE. If set to false, function will not confirm delete operation
#'@keywords
#'@seealso
#'@return Nothing. A message upon successful deletion.
#'@alias
#'@export dropbox_delete
#'@examples \dontrun{
#' dropbox_delete(dropbox_credential, 'path/to/file')
#'}
dropbox_delete <- function(cred, file_to_delete = NULL, 
    ask = TRUE) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
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
        deleted <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/delete", 
            list(root = "dropbox", path = file_to_delete)))
        if (is.list(deleted)) {
            cat(deleted$path, "was successfully deleted on", deleted$modified, 
                "\n")
        }
    }
}
# API documentation:
#
#
#
#
#   https://www.dropbox.com/developers/reference/api#fileops-delete 
