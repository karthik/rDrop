\name{dropbox_get}
\alias{dropbox_get}
\title{Downloads a file from your Dropbox}
\usage{
  dropbox_get(cred, file_to_get, curl = getCurlHandle(),
    ...)
}
\arguments{
  \item{cred}{Specifies an object of class
  DropboxCredentials with Dropobox specific credentials.}

  \item{file_to_get}{Specifies the path to the file you
  want to retrieve. Path must be relative to \code{Dropbox
  root}.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}
}
\value{
  R object
}
\description{
  Currently the function does not provide much support
  other than retrieving the contents of whatever Dropbox
  file you specify. Use \code{TextConnection} to process
  data files for the time being.
}
\examples{
\dontrun{
x <- dropbox_get(db_cred, '/folder/file.csv')
}
}

