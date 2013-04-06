#' Function to copy files or folder within Dropbox.
#'
#' Use this function to copy files or folders within your Dropbox. Destination must be a folder otherwise the function will return an error.
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param from_path Path to file or folder to be copied, relative to dropbox root.
#' @param to_path Path to destination, including the new name for the file or folder, relative to dropbox root.  This can also be a \code{DropboxFolder} in which case the name of the \code{from_path} file is used as the target file name in the destination folder.
#' @keywords file_copy
#' @seealso dropbox_move dropbox_create_folder
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly)..
#' @return Message with success or error.
#' @seealso related: \code{\link{dropbox_move}}
#' @aliases dropbox_cp
#' @export dropbox_copy
#' @examples \dontrun{
#'   dropbox_copy(cred, 'copy.txt', 'Public')
#' 
#'}
dropbox_copy <-
function(cred, from_path = NULL, to_path = NULL, 
         curl = getCurlHandle(), ..., .checkIfExists = TRUE, .silent = FALSE)
{
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    if (is.null(from_path)) {
        stop("Did not specify full path for source", call. = F)
    }

    if(is(to_path, "DropboxFolder"))  {
       to_path = sprintf("%s/%s", to_path@path, basename(getPath(from_path, cred = cred)))
     }

    
    check_paths <- sanitize_paths(from_path, to_path, cred)
    from_path <- check_paths[[1]]
    to_path <- check_paths[[2]]

    if (!exists.in.dropbox(cred, from_path, ..., curl = getCurlHandle())) 
       raiseError(c("Source file or folder ", from_path, " does not exist"),
                    "NonExistantFile")
    
    if (.checkIfExists && !exists.in.dropbox(cred, dirname(to_path), is_dir = TRUE, 
        ..., curl = getCurlHandle())) 
        raiseError(c("Destination ", dirname(to_path), " is not a valid folder"),  c("InvalidFolder", "NonExistantFile"))

    if (grepl("\\.", to_path)) {
        if (.checkIfExists && exists.in.dropbox(cred, to_path, ..., curl = getCurlHandle())) 
            raiseError(c("File ", to_path, " already exists in destination"), "TargetFileExists")
    }
    
    copy <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/fileops/copy", 
        list(root = "dropbox", from_path = from_path, to_path = to_path), 
        , "POST", ..., curl = curl))
    if (is.character(copy)) {
        stop(copy[[1]], call. = FALSE)
    }
    if (is.list(copy) && !.silent) {
        cat(from_path, "succcessfully copied to", copy$path, "on", 
            copy$modified, "\n")
    }
}
# API documentation: #
#
#   https://www.dropbox.com/developers/reference/api#fileops-copy   
