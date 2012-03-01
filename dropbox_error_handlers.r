
# A set of functions meant to handle errors arising from all dropbox file ops.

# Status: Works but fails to recongnize missing objects passed as cred from dropbox_acc_info()

#'Verifies whether a user has specified a correct Oauth credential for Dropbox
#'
#'@param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export is.dropbox.share
#'@examples \dontrun{
#' is.dropbox.cred(your_dropbox_credential_object)
#'}
is.dropbox.cred <- function(cred) {
    response <- TRUE
    if (missing(cred)) {
        response <- FALSE
    }
    if (response == TRUE) {
        if (!exists(as.character(substitute(cred)), envir = .GlobalEnv)) {
            response <- FALSE
        }
    }
    if (response == TRUE)
        response <- ifelse(class(cred) != "OAuth", FALSE, TRUE)
    if (response == TRUE)
        response <- ifelse(grep("dropbox", cred$requestURL) !=
            1, FALSE, TRUE)
    return(response)
}


#'Function to check whether a path is valid or not.
#'
#'<full description>
#'@param cred <what param does>
#'@param path <what param does>
#'@keywords
#'@seealso is.dropbox.file dropbox.file.info
#'@return logical
#'@alias
#'@export is.dropbox.dir
#'@examples \dontrun{
#'
#'}
is.dropbox.dir<-function(cred,path)
{
if(!is.dropbox.cred(cred)) {stop("Invalid Dropbox credentials",call.=F)}
if directory, return logical true.
else return false.
}

#'Checks if a supplied path is actually a file.
#'
#'<full description>
#'@param cred <what param does>
#'@param path <what param does>
#'@keywords
#'@seealso is.dropbox.dir dropbox.file.info
#'@return logical
#'@alias
#'@export is.dropbox.file
#'@examples \dontrun{
#'
#'}
is.dropbox.file<-function(cred,path)
{
if(!is.dropbox.cred(cred)) { stop("Invalid Dropbox credentials",call.=F) }
# if file, return TRUE
# if !file return FALSE
}

#'Return file attributes for a specified path to file.
#'
#'@param cred <what param does>
#'@param path_to_file <what param does>
#'@keywords
#'@seealso is.dropbox.file is.dropbox.dir
#'@return list
#'@alias
#'@export dropbox.file.info
#'@examples \dontrun{
#'
#'}
dropbox.file.info<-function(cred,path_to_file)
{
# Todos
# Return a list containing filename, filetype, date modified, and revision number.
}

#'Function to handle bad errors if a returned object is not the excepted JSON object
#'
#'@param dropbox_call A function call to a Dropbox method via OAuth$handshake()
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
is.valid.dropbox.operation<-function(dropbox_call)
{
	# if dropbox_call succeeds
	# return the object received
	# else
	# 	return a valid and useful error.
}

is.valid.revision<-function(cred,path,revision)
{
# Checks revision number for a file in dropbox and returns a logical yes/no.
}