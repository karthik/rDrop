\name{dropbox_restore}
\alias{dropbox_restore}
\title{functions to restore a file to an older version}
\usage{
  dropbox_restore(cred, path, rev = NULL)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{file}{The path to the file.}
}
\description{
  functions to restore a file to an older version
}
\examples{
\dontrun{
dropbox_restore(cred, '/test/file.csv', rev = '213566')
}
}

