#Status: Works but I have not incorporated path and error handling.
# Bug: cannot supply a subfolder for search. videos works. ifttt. works. but ifttt/videos does not. Perhaps I need to escape the / character?

#'Search your Dropbox Files
#'
#'<full description>
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@param  query The search string. Must be at least three characters long.
#'@param  include_deleted If this parameter is set to true, then files and folders that have been deleted will also be included in the search.
#'@param  path The path to the folder you want to search from.
#'@param  file_limit The maximum and default value is 1,000. No more than file_limit search results will be returned.
#'@keywords
#'@seealso
#'@return
#'@alias dropbox_acc_info dropbox_dir
#'@export dropbox_search
#'@examples \dontrun{
#' results<-dropbox_search(cred,'search_term')
#' Returns a small data.frame with path and is_dir
#' results<-dropbox_search(cred,'search_term',verbose=T)
#' Verbose results include a data.frame with columns: revision,rev,thumb_exists,bytes,modified,path,is_dir,icon,root,mime_type,size
#'}
dropbox_search <- function(cred, query = NULL, path = NULL, deleted = FALSE,
    file_limit = 1000, is_dir = NULL, verbose = FALSE) {
    # Unable to pass on full path. So I must strip the last bit, search then match the full search path. Right?
    if (!is.dropbox.cred(cred)) {
        stop("Invalid Oauth credentials", call. = FALSE)
    }
        #Check of path is valid
    if (is.null(query)) {
        stop("you did not specifiy any search query")
    }

    results = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/search/dropbox/",
        list(query = query, include_deleted = deleted)))
   search_results <- formatted_results <- ldply(results, data.frame)

     if(!is.null(path)) {
        full_path <- paste(path, query, sep="")
        search_results <- search_results[which(search_results$path==full_path),]
    }

    
    if(!is.null(is_dir)) {
    if(is_dir) { search_results <- search_results[search_results$is_dir,]}
    if(!is_dir) { search_results <- search_results[!search_results$is_dir,]}
    }

  
    small_results <- data.frame(path = search_results$path, is_dir = search_results$is_dir)

    if (empty(search_results)) {
       search_results <- NULL
       return (search_results)
    }
    if (!verbose & !empty(small_results)) {
        return(small_results)
    }
    if (verbose & !empty(small_results)) {
        return(search_results)
    }
}

# Search doesn't work on full paths. Just the final name.