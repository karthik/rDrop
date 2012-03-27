\name{dropbox_delete}
\alias{dropbox_delete}
\title{Function to delete a file or folder from Dropbox}
\usage{
  dropbox_delete(cred, file_to_delete = NULL, ask = TRUE,
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{file_to_delete}{Specifies the path to the file or
  folder to be deleted.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{ask}{logical set to TRUE. If set to false, function
  will not confirm delete operation}
}
\value{
  Nothing. A message upon successful deletion.
}
\description{
  Function will delete specified object in Dropbox
  (assuming it exists). To skip deletion conformation, set
  ask = FALSE in function call. Accidentally deleted
  objects may be recovered using Dropbox's restore feature.
}
\examples{
\dontrun{
dropbox_delete(dropbox_credential, 'path/to/file')
}
}

