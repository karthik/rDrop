# Status: WORKS and now checks for existing folders.
# is unable to check for subfolders directly due to a bug in dropbox_search

#'Function to create new folders in Dropbox.
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param folder_name Specifies the path to the new folder to create relative to root.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@import stringr
#'@export dropbox_create_folder
#'@examples \dontrun{
#'
#'}
dropbox_create_folder <- function(cred, folder_name = NULL, path = NULL) {
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }

    if(is.null(folder_name)) { 
        stop("You did not specify a folder name", call.= FALSE)
    }
    # assuming someone wants to create this inside a sub-folder and not the dropbox root
    if(!is.null(path)) { 
         if(grepl('/$', path)) { 
            path <- str_sub(path, end = str_length(path)-1) 
        }
         if(grepl('^/', path)) { 
            path <- str_sub(path, start = 2)
        }
         if(grepl('/$', folder_name)) { 
            folder_name <- str_sub(folder_name, end = str_length(folder_name)-1) 
        }
         if(grepl('^/', folder_name)) { 
            folder_name <- str_sub(folder_name, start = 2) 
        }
        # Final formatted folder name with path and no extra slashes.
        folder_name <- paste(path,folder_name,sep='/')
    }
    # Check for duplicates.
    if((exists.in.dropbox(cred,folder_name, is_dir = TRUE))) {
        stop("Folder already exists", call.= FALSE)
    }

    # Now create the folder.
    dir_metadata <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/fileops/create_folder/",
        list(root = "dropbox", path = folder_name)))
    location <- paste(dir_metadata$root,dir_metadata$path,sep="")
    cat("Folder successfully created at", location,
        "on", dir_metadata$modified, "\n")
}

