#'Search Dropbox files and folders.
#'
#' If you are searching for a file/folder in the root directory, you can ignore the path. If searching for a file/folder in a specific location, then you should provide a full path to the object.
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param  query The search string. Must be at least three characters long.
#' @param  deleted If this parameter is set to true, then files and folders that have been deleted will also be included in the search.
#' @param  file_limit The maximum and default value is 1,000. No more than file_limit search results will be returned.
#' @param is_dir logical, TRUE looks for directories only.
#' @param verbose logical. Default is FALSE. Set to TRUE to get a full file listing.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @return data.frame with results. No results will return empty data.frame
#' @export dropbox_search
#' @examples \dontrun{
#' results<-dropbox_search(cred,'file or folder name')
#' results<-dropbox_search(cred,'/specific/path/file or folder name')
#' Returns a small data.frame with path and is_dir
#' results<-dropbox_search(cred,'search_term',verbose=T)
#' Verbose results include a data.frame with columns: revision,rev,thumb_exists,bytes,modified,path,is_dir,icon,root,mime_type,size
#'}
dropbox_search <- function(cred, query = NULL, deleted = FALSE, 
    file_limit = 1000, is_dir = NULL, verbose = FALSE, curl = getCurlHandle(), 
    ...) {
    if (!is(cred, "DropboxCredentials")) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)
    }
    if (is.null(query)) {
        stop("No term to query")
    }
                                                                    # Save the full path if supplied.
    full_path <- query
    query <- basename(query)
    results <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/search/auto/", 
        list(query = query, include_deleted = deleted), ..., curl = curl))
    search_results <- formatted_results <- ldply(results, data.frame)
                                                                    # If user wanted to search for a file in a specific
                                                                    #   location.
    if (!identical(full_path, query)) {
        search_results <- search_results[which(search_results$path == 
            full_path), ]
    }
                                                                    # Test if someone is checking whether result is a directory
    if (dim(search_results)[1] > 0) {
        if (!is.null(is_dir)) {
            if (is_dir == TRUE) {
                search_results <- search_results[search_results$is_dir, 
                  ]
            }
            if (is_dir == FALSE) {
                search_results <- search_results[!search_results$is_dir, 
                  ]
            }
        }
    }
    if (dim(search_results)[1] > 0) {
        small_results <- data.frame(path = search_results$path, is_dir = search_results$is_dir)
    }
    if (dim(search_results)[1] == 0) {
        return(search_results[0, 0])
    }
    if (!verbose & !empty(small_results)) {
        return(small_results)
    }
    if (verbose & !empty(small_results)) {
        return(search_results)
    }
}
# API documentation:
#   https://www.dropbox.com/developers/reference/api#search   
