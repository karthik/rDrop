#' Function to save an object from R into Dropbox (not working)
#'
#' This function saves an R object to Dropbox. One can then retrieve it and load
#' it back into R.
#' @param cred Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param list List of objects from the current R environment that needs to be saved into dropbox
#' @param file Required filename. No extenstion needs to be supplied. If you provide one, it will be stripped and replace with rda.
#' @param envir optional. Defaults to parent environment.
#' @param precheck internal use. Checks to make sure all objects are in the parent environment.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param verbose default is FALSE. Set to true to receive full outcome.
#' @param ... optional additional curl options (debugging tools mostly).
#' @param ext file extension. Default is \code{.rda}
#' @export
#' @return JSON object
#' @examples \dontrun{
#' dropbox_save(cred, robject, file='filename')
#' dropbox_save(cred, file = 'testRData', .objs = list(a = 1:3, b = letters[1:10]))
#' a = dropbox_get(cred, 'testRData.rdata', binary = TRUE)
#' val = unserialize(rawConnection(a))
#'
#'   # specifying our own name without the standard .rdata
#' dropbox_save(cred, list(a = 1:4, b = letters[1:3]), I('duncan.rda'), verbose = TRUE)
#'   # or
#' dropbox_save(cred, list(a = 1:4, b = letters[1:3]), 'duncan', verbose = TRUE, ext = '.rda')
#'}
dropbox_serialize <-
function(cred, file, object, 
            precheck = TRUE, verbose = FALSE, curl = getCurlHandle(),
           ext = ".rda", ...)
{
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)

    if (is.character(file) && !nzchar(file)) 
        stop("'file' must be non-empty string")
                   # Allow the caller to force a particular name.
    filename <- if(!is(file, "AsIs") && !grepl(sprintf("%s$", ext), file)) 
                   paste(str_trim(str_extract(file, "[^.]*")), ext, sep = "")
                else
                   file
    url <- sprintf("https://api-content.dropbox.com/1/files_put/dropbox/%s", 
                   filename)
    
    z = serialize(object, NULL)
    input <- RCurl:::uploadFunctionHandler(z, TRUE)
    drop_save <- fromJSON(OAuthRequest(cred, url, , "PUT", upload = TRUE, 
                                       readfunction = input, infilesize = length(z), verbose = FALSE, 
                                       httpheader = c(`Content-Type` = "application/octet-stream"), 
                                       ..., curl = curl))
    if (verbose && is.list(drop_save)) {
        message("File succcessfully drop_saved to", drop_save$path, 
                "on", drop_save$modified)
    }
    drop_save
}
# API documentation: GET:
#   https://www.dropbox.com/developers/reference/api#files-GET   
