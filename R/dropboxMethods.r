
setMethod("$", "DropboxCredentials",
          function(x, name) {
            id = sprintf("dropbox_%s", name)
            ns = getNamespace("rDrop")
            if(!exists(id, ns, mode = "function"))
              stop("no method named ", id, " for", class(x))
            fun = get(id, ns, mode = "function")
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


setMethod("[[<-", c("DropboxCredentials", "character", "missing"),
          function(x, i, j, ...) {
            dropbox_put(x, i, ...)
          })

          
