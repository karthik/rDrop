#' Function to load an RDA file from Dropbox.

#' @param cred Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param file the name of the file in the Dropbox folder
#' @param envir the environment in which to load the variables in the file. See the
#'     regular \code{\link{load}} function.
#' @return a character vector containing the names of the new variables created. This is the return value from a call to \code{\link{load}}.
#' @export
dropbox_load <-
function(cred, file, envir = parent.frame())
{
  data = dropbox_get(cred, file, binary = TRUE)
  con = rawConnection(data)
  load(con, envir)
}
