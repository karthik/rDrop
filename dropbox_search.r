
dropbox_search<-function(cred,terms)
{
	# Must catch a bad cred object
	if(length(terms)==0)
	{stop("you did not specifiy any search terms")}
	results = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/search/dropbox/",list(query = terms, include_deleted = "true")))
	return(formatted_results<-ldply(results, data.frame))
}

# result <- dropbox_search(cred,"dryad")
# mine_type = text/csv will get only data files.