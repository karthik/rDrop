# A set of functions meant to handle errors arising from all dropbox file ops.

# startup checks that need to get done.
# .onLoad()
# if(packageVersion("ROAuth") < "0.9.1") {
#     stop("You will version 0.9.1 (or higher) of ROAuth for rDrop to work. \n")
# }

#'Verifies whether a user has specified a correct Oauth credential for Dropbox
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@keywords
#'@seealso
#'@return logical
#'@alias
#'@export is.dropbox.share
#'@examples \dontrun{
#' is.dropbox.cred(your_dropbox_credential_object)
#'}
is.dropbox.cred <- function(cred, response = TRUE) {
    if (missing(cred)) {
        response <- FALSE
    }
    if (response) {

       response <- ifelse(as.character(substitute(cred)) %in% ls( envir = .GlobalEnv),TRUE,FALSE )
   }
    if (response) {
        response <- ifelse(class(cred) != "OAuth", FALSE, TRUE)
    }
    if (response) {
        response <- ifelse(grep("dropbox", cred$requestURL) != 1, FALSE,
            TRUE)
    }
    return(response)
}

#' Check to see if an object exists in Dropbox
#'
#'<longer description>
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path Path to object
#'@param  type = NULL dir or file if a function needs to know. Otherwise it will ignore type and return TRUE if object exists in Dropbox folder.
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#' exists.in.dropbox(cred,'test_folder')
#' exists.in.dropbox(cred,'test_folder',is_dir='dir')
#'}
exists.in.dropbox <- function(cred, path = NULL, query, is_dir = NULL) {
    response <- TRUE
    # First search Dropbox to see if the object exists
    if(is.null(path)) {
        path <- '/'
    }
    res <- dropbox_search(cred, path=path, query=query)
    if(is.null(res)) {
    response <- FALSE
  }
  # OK, object exists, but let's see if there was more than one result
  if(response) {
    if(dim(res)[1]>1) response <- FALSE
  }

  # OK, only one result returned. 
if(response) {
    if(!is.null(is_dir)) {
        if(is_dir) { response <- ifelse(res$is_dir,TRUE, FALSE) }
        if(!is_dir) { response <- ifelse(!res$is_dir,TRUE, FALSE) }
    }
}

 return(response)
}

#'Function to check whether a path supplied exists in a users Dropbox account.
#'
#'<full description>
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path <what param does>
#'@keywords
#'@seealso is.dropbox.file dropbox.file.info
#'@return logical
#'@alias
#'@export is.dropbox.dir
#'@examples \dontrun{
#'
#'}
is.dropbox.dir <- function(cred,path) {
if(!is.dropbox.cred(cred)) {stop("Invalid Dropbox credentials",call.=F)}
is_d_dir <- TRUE
res <- dropbox_search(cred,path)
if(is.null(res)) {
is_d_dir <- FALSE
}
if(is_d_dir) {
    if(dim(res)[1]>1) {
    is_d_dir <- FALSE
    }
}
if(is_d_dir) {
    if(!unique(res$is_dir)) {
        is_d_dir <- FALSE
    }
}
return(is_d_dir)
}
# Check for leading slash first using grep. If missing, append it.
# if directory, return logical true.
# else return false.


#'Checks if a supplied path is a file in users Dropbox account.
#'
#'<full description>
#'@param cred An object of class ROAuth with Dropobox specific credentials.
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
if(!is.dropbox.cred(cred)) {stop("Invalid Dropbox credentials", call.=F)}
is_d_file <- TRUE
res <- dropbox_search(cred,path)
if(is.null(res)) {
is_d_file <- FALSE
}
if(is_d_file) {
    if(dim(res)[1]>1) {
    is_d_file <- FALSE
    }
}
if(is_d_file) {
    if(!unique(res$is_dir)) {
        is_d_file <- FALSE
    }
}
return(is_d_file)
}

#'Return file attributes for a specified file supplied in the path argument.
#'
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path_to_file <what param does>
#'@keywords
#'@seealso is.dropbox.file is.dropbox.dir
#'@return list
#'@alias
#'@export dropbox.file.info
#'@examples \dontrun{
#'
#'}
dropbox.file.info <- function(cred,path_to_file)
{
    # Add leading slash in case it is missing
    if(!grepl('^/',path_to_file))
    {
        path_to_file <- paste('/',path_to_file,sep="")
    }
dfile <- dropbox_search(cred, path_to_file)
# Return a list containing filename, filetype, date modified, and revision number.
}

#'Function to handle errors if a returned object is not the excepted JSON object
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
is.valid.dropbox.operation <- function(dropbox_call) {
	# if dropbox_call succeeds
	# return the object received
	# else
	# 	return a valid and useful error.
}

#' Checks whether supplied revision number is valid on Dropobx
#'
#'<longer description>
#'@param cred An object of class ROAuth with Dropobox specific credentials.
#'@param path <what param does>
#'@param revision <what param does>
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#'
#'}
# is.valid.revision <- function(cred,path,revision)
# {
# }
# need to extract revision number
# Check for leading slash first using grep. If missing, append it.
# Checks revision number for a file in dropbox and returns a logical yes/no.