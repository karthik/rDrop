#'Search your Dropbox Files
#'
#'<full description>
#'@param cred <what param does>
#'@param  terms <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#' results<-dropbox_search(cred,'search_term')
#' Returns a small data.frame with path and is_dir
#' results<-dropbox_search(cred,'search_term',verbose=T)
#' Verbose results include a data.frame with columns: revision,rev,thumb_exists,bytes,modified,path,is_dir,icon,root,mime_type,size
#'}
dropbox_search <- function(cred, terms, verbose = FALSE) {
    if (!is.dropbox.cred(cred))
        stop("Invalid Oauth credentials", call. = FALSE)
    if (length(terms) == 0) {
        stop("you did not specifiy any search terms")
    }
    results = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/search/dropbox/",
        list(query = terms, include_deleted = "true")))
    search_results <- formatted_results <- ldply(results, data.frame)
    small_results <- data.frame(path = search_results$path, is_dir = search_results$is_dir)
    if (empty(small_results)) {
        cat("No files or directories found")
    }
    if (!verbose & !empty(small_results)) {
        return(small_results)
    }
    if (verbose & !empty(small_results)) {
        return(search_results)
    }
}
