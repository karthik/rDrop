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
#'
#'}
dropbox_delete <- function(cred, file_to_delete = NULL, 
    ask = TRUE) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
    # Replace with a more elegant file exists checker.
    file_to_del <- dropbox_search(cred, file_to_delete)
    if (empty(file_to_del)) {
        stop("File or folder wasn't found at the specified path\n", 
            call. = F)
    }
    if (dim(file_to_del)[1] > 1) {
        stop("More than one file or folder was found, please check supplied path. \n", 
            call. = F)
    }
    file_to_del <- as.character(file_to_del$path[1])
    if (ask == TRUE) {
        verify <- readline(paste("Are you sure you want to delete", 
            file_to_del, " (Y/N)? "))
        if (verify != "Y" & verify != "N") {
            stop("Unexpected response. \n", call. = F)
        }
    }
    if (verify == "Y" | ask == FALSE) {
        deleted <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/delete", 
            list(root = "dropbox", path = file_to_del)))
        if (deleted$is_deleted) {
            cat(deleted$path, "was successfully deleted on", 
                deleted$modified, "\n")
        }
    }
    invisible()
} 
# API documentation: https://www.dropbox.com/developers/reference/api#fileops-delete