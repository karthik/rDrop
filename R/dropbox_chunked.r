
dropbox_chunked <-
function(cred, what, filename = basename(what), chunkSize = 4*10^6, ..., curl = getCurlHandle())
{
    # raw and files
    #   totalSize = length(z)
  input = CFILE(what, "rb")
  totalSize = file.info(what)[1, "size"]

  targetURL = "https://api-content.dropbox.com/1/chunked_upload"

    # Need to reset the Content-Length, etc.  in the final request
    # so just clone the handle now.
  dupCurl = dupCurlHandle(curl)
  
  chunkSize = min(totalSize, chunkSize)
  ans = OAuthRequest(cred, targetURL, , "PUT", upload = TRUE, verbose = TRUE,
                      readdata = input@ref, infilesize = chunkSize,
                      httpheader = c('Content-Type' = "application/octet-stream"),
                      ..., curl = curl)
  tmp = fromJSON(ans)

  offset = chunkSize + 1
  id = tmp[["upload_id"]]
 
  while(tmp$offset < totalSize)   {
    browser()
     tmp.url = sprintf("%s?upload_id=%s&offset=%d", targetURL, id, offset)
     nbytes = min(totalSize - offset, chunkSize)
     cat("sending", nbytes, "\n")
     tmp = fromJSON(OAuthRequest(cred, tmp.url, , "PUT", upload = TRUE,
                                 readdata = input@ref, infilesize = nbytes,
                                 ..., curl = curl))
     offset = offset + nbytes + 1
  }

  cat("committing upload", offset, "\n")
  url  = rDrop:::getPath(filename, "https://api-content.dropbox.com/1/commit_chunked_upload/dropbox", cred)

  fromJSON(OAuthRequest(cred, url, list(overwrite = "true", upload_id = id), "POST", ..., curl = dupCurl, .opts = list(customrequest = "POST", httpheader = character())))
}
