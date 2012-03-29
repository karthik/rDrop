\name{dropbox_media}
\alias{dropbox_media}
\title{Stream data from Dropbox}
\usage{
  dropbox_media(cred, path = NULL, curl = getCurlHandle(),
    ...)
}
\arguments{
  \item{cred}{Specifies an object of class
  DropboxCredentials with Dropobox specific credentials.}

  \item{path}{Path to object on Dropbox.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly).}
}
\value{
  list with URL to R object and expiration date/time.
}
\description{
  This function behaves very similar to
  \code{dropbox_share}. The difference is that this
  bypasses the Dropbox webserver, used to provide a preview
  of the file, so that you can effectively stream the
  contents of your media.
}
\examples{
\dontrun{
dropbox_media(db_cred, '/data/file.csv')
}
}
\seealso{
  \code{\link{dropbox_share}}
}

