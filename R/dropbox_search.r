#'Search your Dropbox files and folders.
#'
#' @param cred An object of class ROAuth with Dropobox specific credentials.
#' @param  query The search string. Must be at least three characters long.
#' @param  include_deleted If this parameter is set to true, then files and folders that have been deleted will also be included in the search.
#' @param  file_limit The maximum and default value is 1,000. No more than file_limit search results will be returned.
#' @param  Verbose logical. Default is FALSE. Set to TRUE to get a full file listing.
#' @return data.frame with results. No results will return empty data.frame
#' @import RJSONIO ROAuth
#' @export dropbox_search
#' @examples \dontrun{
#' results<-dropbox_search(cred,'file or folder name')
#' results<-dropbox_search(cred,'/specific/path/file or folder name')
#' Returns a small data.frame with path and is_dir
#' results<-dropbox_search(cred,'search_term',verbose=T)
#' Verbose results include a data.frame with columns: revision,rev,thumb_exists,bytes,modified,path,is_dir,icon,root,mime_type,size
#'}
dropbox_search <- function(cred, query = NULL, deleted = FALSE,
    file_limit = 1000, is_dir = NULL, verbose = FALSE) {
    # Unable to pass on full path. So I must strip the last
    #   bit, search then match the full search path. Right?
    if (!is.dropbox.cred(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.",
            call. = FALSE)
    }
    #Check if a query was supplied
    if (is.null(query)) {
        stop("No term to query")
    }
    # Save the full path if supplied.
    full_path <- query
    query <- basename(query)
    results <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/search/dropbox/",
        list(query = query, include_deleted = deleted)))
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
