#'Downloads a file from your Dropbox
#'
#' Currently the function does not provide much support other than retrieving the contents of whatever Dropbox file you specify. Use \code{TextConnection} to process ascii files for the time being.
#' @param cred Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param  file_to_get Specifies the path to the file you want to retrieve. Path must be relative to \code{Dropbox root}.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint).
#' @param binary set if the object you are retrieving is binary content.
#' @param ... optional additional curl options (debugging tools mostly)..
#' @param root  the name of the root folder
#' @return R object
#' @export dropbox_get
#' @examples \dontrun{
#' x <- dropbox_get(db_cred, '/folder/file.csv')
#'}
dropbox_get <-
function(cred, file_to_get, curl = getCurlHandle(), ..., binary = NA,
         root = "dropbox", .checkIfExists = TRUE)
{
    if (!is(cred, "DropboxCredentials") || missing(cred))
        missingCredentialsError()

    file_to_get = getPath(file_to_get, cred = cred)  # paste(file_to_get, collapse = "/")

    if (.checkIfExists && !(exists.in.dropbox(cred, path = file_to_get, is_dir = FALSE,..., curl = curl))) {
        stop("File or folder does not exist", call. = FALSE)
    }
    
    invisible(suppressWarnings(OAuthRequest(cred, "https://api-content.dropbox.com/1/files/",
                                            list(root = root, path = file_to_get), "GET",
                                            binary = binary, ..., curl = curl)))
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#files-GET
