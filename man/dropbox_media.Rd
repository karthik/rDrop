\name{dropbox_media}
\alias{dropbox_media}
\title{Returns a link directly to a file.}
\usage{
  dropbox_media(cred, path = NULL)
}
\arguments{
  \item{cred}{<what param does>}

  \item{path}{= NULL <what param does>}
}
\value{
  file
}
\description{
  Similar to /shares. The difference is that this bypasses
  the Dropbox webserver, used to provide a preview of the
  file, so that you can effectively stream the contents of
  your media.
}
\examples{
\dontrun{

}
}

