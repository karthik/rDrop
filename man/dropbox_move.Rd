\name{dropbox_move}
\alias{dropbox_move}
\title{Move files within Dropbox}
\usage{
  dropbox_move(cred, from_path = NULL, to_path = NULL,
    verbose = FALSE, curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{Specifies an object of class
  DropboxCredentials with Dropobox specific credentials.}

  \item{from_path}{Specifies the file or folder to be
  copied from relative to root.}

  \item{to_path}{Specifies a destination path, including
  the new name for the file or folder, relative to root.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{verbose}{default is FALSE. Set to true to receive
  full outcome.}
}
\value{
  Message on successful completion or error.
}
\description{
  Allows users to move files or folders inside the dropbox
  storage.
}
\examples{
\dontrun{
dropbox_move(db_cred, '/data.csv', 'data/data.csv')
}
}
\seealso{
  dropbox_copy dropbox_create_folder

  related: \code{\link{dropbox_copy}}
}

