#'  Function to upload content (in-memory or a file) to Dropbox.

#' @param cred Specifies an object of class DropboxCredentials with Dropobox-specific credentials.
#' @param what the content to upload, which is either the name of a file, in-memory text or a raw vector.
#' @param filename the name of the file to create in the Dropbox folder.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @param verbose default is FALSE. Set to true to receive full outcome.
#' @param contentType the string describing the content type.
#' @return information about the uploaded file on dropbox.
#' @examples \dontrun{
#'   dropbox_put(auth, I("This is in-memory text"), "inMemory.txt")
#'
#'   dropbox_put(auth, "DESCRIPTION", "rDrop_DESCRIPTION")
#'   print(dropbox_get(auth, "rDrop_DESCRIPTION"))
#' }
dropbox_put <-
function(cred, what, filename = what, curl = getCurlHandle(), ..., verbose = FALSE,
         contentType = "application/octet-stream")
{
    filename = paste(filename, collapse = "/")
    url <- sprintf("https://api-content.dropbox.com/1/files_put/dropbox/%s", filename)

     #XXX what about raw?
    size = if(is(what, "AsIs")) {
              if(is.character(what))
                  sum(nchar(what))
              else
                  length(what)
           } else
              file.info(what)[1, "size"]
    
    if(size > 1048576 * 150)
        return(dropbox_chunked(cred, what, filename, curl = curl, .silent = !verbose))
    
    input <- RCurl:::uploadFunctionHandler(what)                               
    
    drop_save <- fromJSON(OAuthRequest(cred, url, , "PUT", upload = TRUE,
                                       readfunction = input, infilesize = size,
                                       httpheader = c(`Content-Type` = contentType),
                                       ..., curl = curl))

    if (verbose && is.list(drop_save))  {
        message("File succcessfully drop_saved to", drop_save$path,
                  "on", drop_save$modified)
    }

    drop_save
}

readBinary =
function(filename)
{
  readBin(filename, raw(), n = file.info(filename)[1, "size"])
}
