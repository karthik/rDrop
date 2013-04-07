
dropbox_chunked <-
function(cred, what, filename = basename(what), chunkSize = 4*10^6, ..., curl = getCurlHandle())
{
    # source of data can be raw vectors, files and connections
  if(is.character(what)) {
    input = file(what, "rb")
    on.exit(close(input))
    totalSize = file.info(what)[1, "size"]
  } else if(is.raw(what)) {
       # raw buffer or a connection
    input =  rawConnection(what, "r")
    on.exit(close(input))    
    totalSize = length(input)
  } else if(is(what, "connection")) {
    input = what
    totalSize = NA
  }

  targetURL = "https://api-content.dropbox.com/1/chunked_upload"

    # Need to reset the Content-Length, etc.  in the final request
    # so just clone the handle now.
  dupCurl = dupCurlHandle(curl)

    # Send the first block to obtain the upload_id token
  block = readBin(input, raw(), chunkSize)
  ans = OAuthRequest(cred, targetURL, , "PUT", upload = TRUE, verbose = TRUE,
                      readfunction = block, infilesize = length(block),
                      httpheader = c('Content-Type' = "application/octet-stream"),
                      ..., curl = curl)

  tmp = fromJSON(ans)
  offset = length(block) # + 1
  id = tmp[["upload_id"]]

  while(is.na(totalSize) || offset < totalSize)   {
    browser()
     tmp.url = sprintf("%s?uploapd_id=%s&offset=%d", targetURL, id, offset)
     block = readBin(input, raw(), chunkSize)    
     nbytes = length(block)
     cat("sending", nbytes, "\n")
       #XXXX
       # There is a problem with the signature on this request.
       # Potential issue is the upload_id and offset arguments
       #  are in the URL but not in the request
       # We may need to sign it as if they are parameters, but
       # then put the parameters in the URL. ROAuth currently
       # doesn't have a mechanism to specify this.
       # Added in my version via .sendURL.
     tmp = OAuthRequest(cred,
                        targetURL, c(upload_id = id, offset = offset),
                        "PUT", upload = TRUE,
                        readfunction = block, infilesize = nbytes,
                        ..., curl = getCurlHandle(verbose = TRUE), # use curl
                        .sendURL = tmp.url)
     tmp = fromJSON(tmp)
     if("error" %in% names(tmp))
         stop("problem uploading chunk: ", tmp[["error"]])
    
     offset = offset + nbytes # + 1
  }

  cat("committing upload to the file\n")
  url  = rDrop:::getPath(filename, "https://api-content.dropbox.com/1/commit_chunked_upload/dropbox", cred)

  fromJSON(OAuthRequest(cred, url, list(overwrite = "true", upload_id = id),
                        "POST", ..., curl = dupCurl))
                        
}
