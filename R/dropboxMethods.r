
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
              stop("no method named ", id, " for", class(x))
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


setMethod("[[<-", c("DropboxCredentials", "character", "missing"),
          function(x, i, j, ...) {
            dropbox_put(x, i, ...)
          })

          
