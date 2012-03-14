\name{dropbox_delete}
\alias{dropbox_delete}
\title{Status:  Works, But I need to add in search paths.
Function to delete a file or folder from Dropbox}
\usage{
  dropbox_delete(cred, file_to_delete = NULL, ask = TRUE)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{file_to_delete}{Specifies the path to the file or
  folder to be deleted.}

  \item{ask}{logical set to TRUE. If set to false, function
  will not confirm delete operation}
}
\value{
  Nothing. A message upon successful deletion.
}
\description{
  Status: Works, But I need to add in search paths.
  Function to delete a file or folder from Dropbox
}
\examples{
\dontrun{
dropbox_delete(dropbox_credential, 'path/to/file')
}
}

