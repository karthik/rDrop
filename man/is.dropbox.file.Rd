\name{is.dropbox.file}
\alias{is.dropbox.file}
\title{Checks if a supplied path is a file in users Dropbox account.}
\usage{
  is.dropbox.file(cred, path)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{path}{path to file or folder that needs
  verification.}
}
\value{
  logical
}
\description{
  Checks if a supplied path is a file in users Dropbox
  account.
}
\examples{
\dontrun{

}
}
\seealso{
  is.dropbox.dir dropbox.file.info
}

