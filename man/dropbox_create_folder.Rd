\name{dropbox_create_folder}
\alias{dropbox_create_folder}
\title{Function to create new folders in Dropbox.}
\usage{
  dropbox_create_folder(cred, folder_name = NULL,
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{folder_name}{Specifies the path to the new folder
  to create relative to root.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)#'}
}
\value{
  message with success or failure
}
\description{
  Function to create new folders in Dropbox.
}
\examples{
\dontrun{

}
}

