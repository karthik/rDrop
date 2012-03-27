#' Function to save an object from R into Dropbox (not working)
#'
#' This function currently does not work.
#' @param cred Specifies an object of class ROAuth with Dropobox specific credentials.
#' @param list List of objects from the current R environment that needs to be saved into dropbox
#' @param file Required filename. No extenstion needs to be supplied. If you provide one, it will be stripped and replace with rda.
#' @param envir optional. Defaults to parent environment.
#' @param precheck internal use. Checks to make sure all objects are in the parent environment.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly)
#' @export
#' @return JSON object
#' @import RJSONIO ROAuth
#' @examples \dontrun{
#' dropbox_save(cred, robject, file='filename')
#'}
dropbox_save <- function(cred, ..., list = character(),
    file = stop("'file' must be specified"), envir = parent.frame(),
    precheck = TRUE, curl = getCurlHandle()) {
    if (class(cred) != "DropboxCredentials" | missing(cred)) {
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.")
    }
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
    if (is.character(file)) {
        if (!nzchar(file))
            stop("'file' must be non-empty string")
    }
    filename <- paste(str_trim(str_extract(file, "[^.]*")), ".rda",
        sep = "")
    url <- paste("https://api-content.dropbox.com/1/files_put/dropbox/",
        filename, sep = "")
    con <- rawConnection(raw(), "w")
    serialize(list(a = 1:10, b = letters), con)
    z <- rawConnectionValue(con)
    input <- RCurl:::uploadFunctionHandler(z, TRUE)
    drop_save <- fromJSON(OAuthRequest(cred, url, , "PUT", upload = TRUE,
        readfunction = input, infilesize = nchar(z), verbose = FALSE,
        httpheader = c(`Content-Type` = "application/binary")))
    close(con)
    if (is.list(drop_save)) {
        cat("File succcessfully saved to", drop_save$path, "on", drop_save$modified)
    }
}
# API documentation: GET:
#   https://www.dropbox.com/developers/reference/api#files-GET
