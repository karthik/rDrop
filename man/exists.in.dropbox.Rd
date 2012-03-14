\name{exists.in.dropbox}
\alias{exists.in.dropbox}
\title{Check to see if an object exists in Dropbox}
\usage{
  exists.in.dropbox(cred, path = NULL, is_dir = NULL)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{path}{Path to object}

  \item{type}{= NULL dir or file if a function needs to
  know. Otherwise it will ignore type and return TRUE if
  object exists in Dropbox folder.}
}
\value{
  logical
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

