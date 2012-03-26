\name{dropbox_media}
\alias{dropbox_media}
\title{Returns a link directly to a file.}
\usage{
  dropbox_media(cred, path = NULL)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{path}{Path to object on Dropbox.}
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

