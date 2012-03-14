\name{dropbox_copy}
\alias{dropbox_copy}
\title{Function to copy files or folder within Dropbox.}
\usage{
  dropbox_copy(cred, from_path = NULL, to_path = NULL)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{from_path}{Specifies the file or folder to be
  copied from relative to root.}

  \item{to_path}{Specifies a destination path, including
  the new name for the file or folder, relative to root.}
}
\value{
  Message with success or error.
}
\description{
  Function to copy files or folder within Dropbox.
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

