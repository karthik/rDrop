#' @param cred Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param  file_to_get Specifies the path to the file you want to retrieve. Path must be relative to \code{Dropbox root}.
#' @param ...  additional parameters passed to \code{\link{dropbox_get}}.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint).
#' @export dropbox_unserialize
#' @return the deserialized R object
#' @examples
#'   \dontrun{
#'       dropbox_serialize(drop, "x", 1:10)
#'       dropbox_unserialize(drop, "x")
#'
#'       dropbox_unserialize(drop, I("x.rda"))
#'   }
#'
dropbox_unserialize <-
function(cred, file, precheck = TRUE, verbose = FALSE, curl = getCurlHandle(),
           ext = ".rda", ...)
{
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)

    file <- if(!is(file, "AsIs") && !grepl(sprintf("%s$", ext), file))
               paste(str_trim(str_extract(file, "[^.]*")), ext, sep = "")
            else
               file
    
    data = dropbox_get(cred, file, ..., curl = curl, binary = TRUE)
    unserialize(data)
}

