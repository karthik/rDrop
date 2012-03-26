\name{dropbox_get}
\alias{dropbox_get}
\title{Downloads a file from your Dropbox}
\usage{
  dropbox_get(cred, file_to_get)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{file_to_get}{Specifies the path to the file you
  want to retrieve.}
}
\value{
  file
}
\description{
  Currently the function does not provide much support
  other than retrieving the contents of whatever Dropbox
  file you specify. Use \code{TextConnection} to process
  data files for the time being.
}
\examples{
\dontrun{

}
}

