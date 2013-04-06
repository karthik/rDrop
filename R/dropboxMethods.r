#' @export Dropbox
Dropbox <-
  #
  # No need for the URIs as these are for acquiring the tokens.
  # We assume you already have them. Otherwise use dropbox_oauth
  #
function(consumerKey, consumerSecret,
         oauthKey, oauthSecret,
         signMethod = "HMAC",
         .obj = new("DropboxCredentials"))
{
  .obj@consumerKey = consumerKey
  .obj@consumerSecret = consumerSecret
  .obj@oauthKey = oauthKey
  .obj@oauthSecret = oauthSecret
  
  invisible(.obj)
}

#' @examples {
#'   dummy = DropboxFolder("Dummy", drop)
#' }
setGeneric("DropboxFolder",
           function(path, consumerKey, consumerSecret,
                    oauthKey, oauthSecret,
                    signMethod = "HMAC", ...,
                    .obj = "DropboxFolder")
           {
             standardGeneric("DropboxFolder")
           })

setMethod("DropboxFolder", c("character", "DropboxCredentials"),
           function(path, consumerKey, consumerSecret,
                    oauthKey, oauthSecret,
                    signMethod = "HMAC", ...,
                    .obj = "DropboxFolder")
           {
              if(is.character(.obj))
                .obj = new(.obj, consumerKey)
              .obj@path = path
              .obj
           })



if(FALSE) {
if(!isGeneric("ls"))
  setGeneric("ls",
             function (name, pos = -1, envir = as.environment(pos), all.names = FALSE,  pattern, ...)
                     standardGeneric("ls"))

#XXX This doesn't work. ls() is probably using non-standard evaluation.
setMethod("ls", "ANY",
           function (name, pos = -1, envir = as.environment(pos), all.names = FALSE,  pattern, ...) {
             browser()
             base::ls(name)
           })

setMethod("ls", "DropboxCredentials",
        function (name, pos = -1, envir = as.environment(pos), all.names = FALSE,  pattern, ...) {
             dropbox_dir(name)
           })
}


if(!isGeneric("dir"))
  setGeneric("dir")

#XXX This doesn't work. ls() is probably using non-standard evaluation.

setMethod("dir", "DropboxCredentials",
function (path = ".", pattern = NULL, all.files = FALSE, full.names = FALSE, 
    recursive = FALSE, ignore.case = FALSE, include.dirs = FALSE)  {
             dropbox_dir(path)
           })





setMethod("$", "DropboxCredentials",
          function(x, name) {
            id = sprintf("dropbox_%s", name)

             # currently we look in the rDrop package.
             # However, we could look along the search path
             # and allow for people to extend the set of methods
             # However, they can do this by overriding this $ method for their
             # own class.
             #
            ns = getNamespace("rDrop")
            if(!exists(id, ns, mode = "function"))
              raiseError(c("no method named ", id, " for ", class(x)), "NoMethod")
            # We could get the function, but we will leave
            # it for now to make the resulting more readable and indicative.
            #  fun = get(id, ns, mode = "function")
            
            f = function(...) fun(x, ...)
            b = body(f)
            b[[1]] = as.name(id)  # could inser the actual fun above
            body(f) = b
            return(f)

            # could create the functions manually if we want special .
            switch(name,
                   delete = function(...) dropbox_delete(x, ...),
                   get = function(...) dropbox_get(x, ...),
                   function(...) fun(x, ...)
                  )
          })

          
setMethod("[[", c("DropboxCredentials", "character", "missing"),
          function(x, i, j, ...) {
            dropbox_get(x, i, ...)
          })

if(FALSE) # path added in method
setMethod("[[", c("DropboxFolder", "character", "missing"),
          function(x, i, j, ...) {
            dropbox_get(x, sprintf("%s/%s", x@path, i), ...)            
          })


setMethod("[[<-", c("DropboxCredentials", "character", "missing"),
          function(x, i, j, ...) {
            dropbox_put(x, i, ...)
          })

if(FALSE) # path added in method
setMethod("[[<-", c("DropboxFolder", "character", "missing"),
          function(x, i, j, ...) {
            dropbox_put(x, sprintf("%s/%s", x@path, i), ...)
          })

          


setGeneric("getPath",
            function(path, url = character(), cred, ...)
                standardGeneric("getPath"))

# A class that indicates that the path has already been expanded with the
# folder information.
setClass("FolderExpandedPath", contains = "character")

setMethod("getPath", c("FolderExpandedPath"),
            function(path, url = character(), cred, ...) {
              path
            })

setMethod("getPath", c("character"),
            function(path, url = character(), cred, ...) {
              tmp = if (length(path) > 0) {
                   paste(c(url, path), collapse = "/")  # prepend / if url is character() ???
              } else {
                if(length(url))
                  url
                else
                   "/"  # or leave as character() ?
              }
              new("FolderExpandedPath", tmp) # gsub("//", "/", tmp))
            })

setMethod("getPath", c("character", cred = "DropboxFolder"),
            function(path, url = character(), cred, ...)
               getPath(c(cred@path, path), url))

