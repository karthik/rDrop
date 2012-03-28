\name{dropbox.file.info}
\alias{dropbox.file.info}
\title{Return file attributes for a specified file supplied in the path argument.}
\usage{
  dropbox.file.info(cred, path_to_file)
}
\arguments{
  \item{cred}{An object of class DropboxCredentials with
  Dropobox specific credentials.}

  \item{path_to_file}{Path to file relative to Dropbox
  root.}
}
\value{
  list
}
\description{
  Return file attributes for a specified file supplied in
  the path argument.
}
\examples{
\dontrun{
dropbox.file.inco(cred, '/folder/file.txt')
}
}
\seealso{
  \code{link{is.dropbox.file}},
  \code{\link{is.dropbox.dir}}
}

