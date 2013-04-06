#'Function to create new folders in Dropbox.
#'
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param folder_name Specifies the path to the new folder to create relative to root.
#' @return a DropboxFolder object representing the path to the folder, along wit the credentials to interact with it.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @import stringr
#' @import plyr
#' @export dropbox_create_folder
#' @examples \dontrun{
#'    dropbox_create_folder(db_cred, 'new_folder')
#'}
dropbox_create_folder <-
function(cred, folder_name = NULL,  curl = getCurlHandle(), .silent = FALSE, ...)
{
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    
    if (is.null(folder_name)) {
        stop("You did not specify a folder name", call. = FALSE)
    }
                                                                    # assuming someone wants to create this inside a sub-folder
                                                                    #   and not the dropbox root
    if (grepl("^/", folder_name)) {
        folder_name <- str_sub(folder_name, start = 2)
    }
    if (grepl("/$", folder_name)) {
        folder_name <- str_sub(folder_name, end = str_length(folder_name) - 
            1)
    }

    folder_name = getPath(folder_name, cred = cred)
                                                                    # Check for duplicates.
    if ((exists.in.dropbox(cred, folder_name, is_dir = TRUE, ..., 
        curl = getCurlHandle()))) {
        stop("Folder already exists", call. = FALSE)
    }
                                                                    # Now create the folder.
    dir_metadata <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/fileops/create_folder/", 
                                          list(root = "dropbox", path = folder_name), ..., curl = curl))

    # XXX  do we need to do this, i.e. add the dropbox. Perhaps just use folder_name now that it is expanded.
    location <- paste(dir_metadata$root, dir_metadata$path, sep = "")
    if(!.silent)
      cat("Folder successfully created at", location, "on", dir_metadata$modified, "\n")
    
    invisible(new("DropboxFolder", cred, path = location))
}
# API documentation:
#
#
#
#
#   https://www.dropbox.com/developers/reference/api#fileops-create-folder   
