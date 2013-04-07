#' Upload large content in chunks
#'
#' Use this function to upload very large files or content which exceeds the 150Mb
#' maximum size for dropbox_put. This allows us to upload the content in chunks
#' each of which can be up to 150Mb but which combined are much larger.
#' This also allows us to resume uploads.
#' @param cred An object of class DropboxCredentials with Dropobox specific credentials.
#' @param what the content to upload, which is either the name of a file, in-memory text or a raw vector.
#' @param filename the name of the file to create in the Dropbox folder.
#' @param chunkSize the number of bytes to send in each chunk. The default is 4Mb.
#' @param range  allows the caller to specify a range of bytes rather than uploading the entire content.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @param .silent a logical value that controls whether progress information is displayed on the console.
#' @param contentType the string describing the content type.
#' @return
#' @seealso  \code{\link{dropbox_put}}
dropbox_chunked <-
function(cred, what, filename = basename(what), chunkSize = 4*10^6,
         range = c(1, NA), ..., curl = getCurlHandle(), .silent = FALSE,
         contentType = "application/octet-stream")
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

  if(!is.na(range[1]) && range[1] > 1) {
    readBin(input, raw(), range[1])
  }

  if(!is.na(range[2]))
     totalSize = range[2]
  
  targetURL = "https://api-content.dropbox.com/1/chunked_upload"

    # Need to reset the Content-Length, etc.  in the final request
    # so just clone the handle now.
  dupCurl = dupCurlHandle(curl)

    # Send the first block to obtain the upload_id token
  block = readBin(input, raw(), chunkSize)
  ans = OAuthRequest(cred, targetURL, , "PUT", upload = TRUE, 
                      readfunction = block, infilesize = length(block),
                      httpheader = c('Content-Type' = contentType),
                      ..., curl = curl)

  tmp = fromJSON(ans)
  offset = length(block)  # + 1
  id = tmp[["upload_id"]]
  ctr = 2

  while(is.na(totalSize) || offset < totalSize)   {
     tmp.url = sprintf("%s?upload_id=%s&offset=%d", targetURL, id, offset)
     block = readBin(input, raw(), chunkSize)    
     nbytes = length(block)
     if(!.silent) {
        cat(ctr, "sending", nbytes, "bytes\n")
        ctr = ctr + 1
     }
     
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
                         httpheader = c('Content-Type' = contentType),
                        readfunction = block, infilesize = nbytes,
                        ..., curl = curl,
                        .sendURL = tmp.url)
     tmp = fromJSON(tmp)
     if("error" %in% names(tmp))
         stop("problem uploading chunk: ", tmp[["error"]])
    
     offset = offset + nbytes 
  }

  cat("committing upload to the file\n")
  url  = rDrop:::getPath(filename, "https://api-content.dropbox.com/1/commit_chunked_upload/dropbox", cred)

  fromJSON(OAuthRequest(cred, url, list(overwrite = "true", upload_id = id),
                        "POST", ..., curl = dupCurl))
                        
}
