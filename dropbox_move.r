#' Function to move files with a Dropbox account
#'
#' Allows users to move files or folders inside the dropbox storage.
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param from_path Specifies the file or folder to be copied from relative to root.
#'@param to_path Specifies a destination path, including the new name for the file or folder, relative to root.
#'@keywords
#'@seealso dropbox_copy dropbox_create_folder
#'@return
#'@alias
#'@export dropbox_move
#'@examples \dontrun{
#'
#'}
dropbox_move <- function(cred, from_path = NULL, to_path = NULL, overwrite = FALSE) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
    # Note: to_path needs a leading / because root is 'dropbox'
    if (is.null(from_path) || is.null(to_path)) {
        stop("Did not specify full path for source and/or destination",
            call. = F)
    }
    if(!(exists.in.dropbox(cred, from_path))) {
        stop("File or folder does not exist", call.= FALSE)
    }    

    if(!(exists.in.dropbox(cred, to_path, is_dir = TRUE))) {
        stop("Destination does not exist or isn't a folder", call.= FALSE)
    }    
    
    move <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/move",
        list(root = "dropbox", from_path = from_path, to_path = to_path)))
    if (length(move$modified) > 0) {
        cat("Move to", move$path, "was successful on", move$modified,
            " \n")
    }
    if (length(move$modified) == 0) {
        cat("Unknown error occured. Bug", " \n")   
  invisible()
}
}