NEEDS WORK
#'<brief desc>
#'
#'<full description>
#'@param cred <what param does>
#'@param file_to_copy <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
dropbox.copy(cred,file_to_copy)
{
	if(!is.dropbox.cred(cred)) stop("Invalid Oauth credentials",call. = FALSE)

}