\name{db.read.csv}
\alias{db.read.csv}
\title{Read CSV files stored in Dropbox}
\usage{
  db.read.csv(dropbox_credentials, file_to_get)
}
\arguments{
  \item{dropbox_credentials}{Specifies an object of class
  DropboxCredentials with Dropobox specific credentials.}

  \item{file_to_get}{Specifies the path to the file you
  want to retrieve. Path must be relative to \code{Dropbox
  root}.}
}
\value{
  data.frame
}
\description{
  This function is a simple wrapper around
  \code{\link{dropbox_get}} for csv files.
}
\examples{
\dontrun{
my_data <- db.read.csv(db_cred, 'data.csv', header = TRUE)
}
}
\seealso{
  dropbox_get
}

