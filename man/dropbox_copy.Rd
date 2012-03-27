\name{dropbox_copy}
\alias{dropbox_copy}
\title{Function to copy files or folder within Dropbox.}
\usage{
  dropbox_copy(cred, from_path = NULL, to_path = NULL,
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{from_path}{Specifies the file or folder to be
  copied from relative to root.}

  \item{to_path}{Specifies a destination path, including
  the new name for the file or folder, relative to root.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly).}
}
\value{
  Message with success or error.
}
\description{
  Use this function to copy files or folders within your
  Dropbox. Destination must be a folder otherwise the
  function will return an error.
}
\examples{
\dontrun{
dropbox_copy(dropbox_token, 'file.csv', 'folder2')
}
}
\seealso{
  dropbox_move dropbox_create_folder
}
\keyword{file_copy}

