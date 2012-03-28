#' Function to save an object from R into Dropbox (not working)
#'
#' This function currently does not work.
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
#' dropbox_save(cred, file = "testRData", .objs = list(a = 1:3, b = letters[1:10]))
#' a = dropbox_get(cred, "testRData.rdata", binary = TRUE)
#' val = unserialize(rawConnection(a))
#'
#'   # specifying our own name without the standard .rdata
#' dropbox_save(cred, list(a = 1:4, b = letters[1:3]), I("duncan.rda"), verbose = TRUE)
#'   # or
#' dropbox_save(cred, list(a = 1:4, b = letters[1:3]), "duncan", verbose = TRUE, ext = ".rda")
#'}
dropbox_save <-
 function(cred, list = character(),
          file = stop("'file' must be specified"), envir = parent.frame(),
          precheck = TRUE, verbose = FALSE, curl = getCurlHandle(),
          ..., ext = ".rdata")
{
    if (!is(cred, "DropboxCredentials") || missing(cred))
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", call.= FALSE)

    # I suggest we discard this approach. The caller specifies
    #   dropbox_save(cred, list(x, y, z)).  It is up to the caller
    # to specify names for the list.
    # We could use ... and then use the names from that.
    # We can use a ..., list = character() approach as in rm()
    # but is not needed or really sane. It is non-standard evaluation.
    #Karthik: OK.
    if(FALSE && missing(.objs)) {
        names <- as.character(substitute(list(...)))[-1L]
        list <- c(list, names)
        if (precheck) {
          ok <- unlist(lapply(list, exists, envir = envir))
          if (!all(ok)) {
            n <- sum(!ok)
            stop(sprintf(ngettext(n, "object %s not found", "objects %s not found"),
                         paste(sQuote(list[!ok]), collapse = ", ")), domain = NA)
          }
        }
        .objs = structure(lapply(list, get, envir),
                           names = list)
     }

    if (is.character(file) && !nzchar(file))
        stop("'file' must be non-empty string")


       # Allow the caller to force a particular name.
    filename <- if(!is(file, "AsIs"))
                    paste(str_trim(str_extract(file, "[^.]*")), ext,
                           sep = "")
                else
                    file

    url <- sprintf("https://api-content.dropbox.com/1/files_put/dropbox/%s", filename)

    con <- rawConnection(raw(), "w")
    on.exit(close(con))

    serialize(list, con)
    z <- rawConnectionValue(con)

    input <- RCurl:::uploadFunctionHandler(z, TRUE)

    drop_save <- fromJSON(OAuthRequest(cred, url, , "PUT", upload = TRUE,
        readfunction = input, infilesize = length(z), verbose = FALSE,
        httpheader = c(`Content-Type` = "application/octet-stream"), ..., curl = curl))

    if (verbose && is.list(drop_save))  {
        message("File succcessfully drop_saved to", drop_save$path,
                  "on", drop_save$modified)
    }

    drop_save
}
# API documentation: GET:
#   https://www.dropbox.com/developers/reference/api#files-GET
