Works, needs some tuning
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
#'
#'}
dropbox_search <- function(cred, terms,verbose=FALSE) {
	if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)
    if (length(terms) == 0) {
        stop("you did not specifiy any search terms")
    }
    results = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/search/dropbox/",
        list(query = terms, include_deleted = "true")))
    return(formatted_results <- ldply(results, data.frame))
}

# result <- dropbox_search(cred,'dryad')
# mine_type = text/csv will get only data files.
