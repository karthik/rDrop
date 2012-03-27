\name{dropbox_share}
\alias{dropbox_share}
\title{Creates and returns a shareable link to files or folders.}
\usage{
  dropbox_share(cred, file = NULL, curl = getCurlHandle(),
    ...)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{file}{Path to the file or folder you want a
  shareable link to.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)#'}
}
\value{
  list with url to file or zipped folder and expiry date.
}
\description{
  Returns a list containing the URL to a zipped copy of a
  folder or a direct link in case input is a file. Also
  returns a date when link will expire.
}
\examples{
\dontrun{
dropbox_share(cred, 'test_folder')
}
}
\keyword{share_url}
\keyword{sharing}

