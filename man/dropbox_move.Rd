\name{dropbox_move}
\alias{dropbox_move}
\title{Function to move files with a Dropbox account}
\usage{
  dropbox_move(cred, from_path = NULL, to_path = NULL)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{from_path}{Specifies the file or folder to be
  copied from relative to root.}

  \item{to_path}{Specifies a destination path, including
  the new name for the file or folder, relative to root.}
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

}
}
\seealso{
  dropbox_copy dropbox_create_folder
}

