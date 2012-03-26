\name{dropbox_restore}
\alias{dropbox_restore}
\title{functions to restore a file to an older version}
\usage{
  dropbox_restore(cred, file, rev = NULL)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{file}{The path to the file.}

  \item{rev}{Revision number to restore back to.}
}
\description{
  This function currently does not work.
}
\examples{
\dontrun{
dropbox_restore(cred, file = '/test/file.csv', rev = '213566')
}
}

