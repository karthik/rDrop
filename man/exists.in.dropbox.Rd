\name{exists.in.dropbox}
\alias{exists.in.dropbox}
\title{Check to see if an object exists in Dropbox}
\usage{
  exists.in.dropbox(cred, path = NULL, is_dir = NULL, ...,
    curl = getCurlHandle())
}
\arguments{
  \item{cred}{An object of class DropboxCredentials with
  Dropobox specific credentials.}

  \item{path}{Path to object}

  \item{is_dir}{if set to TRUE, will only look for folders.
  Otherwise will return file or folder.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass}

  \item{...}{optional additional curl options (debugging
  tools mostly).}
}
\value{
  logical. TRUE/FALSE
}
\description{
  Check to see if an object exists in Dropbox
}
\examples{
\dontrun{
exists.in.dropbox(cred,'test_folder')
exists.in.dropbox(cred,'test_folder',is_dir='dir')
}
}

