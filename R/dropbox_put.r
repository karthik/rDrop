#'  Function to upload content (in-memory or a file) to Dropbox.

#' dropbox_put(auth, "DESCRIPTION", "rDrop_DESCRIPTION")
#' print(dropbox_get(auth, "rDrop_DESCRIPTION"))
dropbox_put <-
function(cred, what, filename = what, curl = getCurlHandle(), ..., verbose = FALSE)
{
    url <- sprintf("https://api-content.dropbox.com/1/files_put/dropbox/%s", filename)

    input <- RCurl:::uploadFunctionHandler(what)

    size = if(is(what, "AsIs")) {
              if(is.character(what))
                  sum(nchar(what))
              else
                  length(what)
           } else
              file.info(what)[1, "size"]
    drop_save <- fromJSON(OAuthRequest(cred, url, , "PUT", upload = TRUE,
                                       readfunction = input, infilesize = size,
                                       httpheader = c(`Content-Type` = "application/octet-stream"),
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
