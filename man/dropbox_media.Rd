\name{dropbox_media}
\alias{dropbox_media}
\title{Similar to /shares. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the file, so that you can effectively stream the contents of your media.}
\usage{
  dropbox_media(cred, path = NULL, curl = getCurlHandle(),
    ...)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{path}{Path to object on Dropbox.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)#'}
}
\value{
  file
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

}
}

