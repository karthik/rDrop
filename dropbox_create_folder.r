#'Function to create new folders in Dropbox.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param folder_name Specifies the path to the new folder to create relative to root.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@import stringr plyr
#'@export dropbox_create_folder
#'@examples \dontrun{
#'
#'}
dropbox_create_folder <- function(cred, folder_name = NULL) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
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
    # Check for duplicates.
    if ((exists.in.dropbox(cred, folder_name, is_dir = TRUE))) {
        stop("Folder already exists", call. = FALSE)
    }
    # Now create the folder.
    dir_metadata <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/create_folder/", 
        list(root = "dropbox", path = folder_name), "POST"))
    location <- paste(dir_metadata$root, dir_metadata$path, sep = "")
    cat("Folder successfully created at", location, "on", dir_metadata$modified, 
        "\n")
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#fileops-create-folder 