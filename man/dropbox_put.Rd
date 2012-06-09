\name{dropbox_put}
\alias{dropbox_put}
\title{Function to upload content (in-memory or a file) to Dropbox.}
\usage{
  dropbox_put(cred, what, filename = what,
    curl = getCurlHandle(), ..., verbose = FALSE)
}
\arguments{
  \item{cred}{Specifies an object of class
  DropboxCredentials with Dropobox specific credentials.}

  \item{what}{the content to upload, which is either the
  name of a file, in-memory text or a raw vector.}

  \item{filename}{the name of the file to create in the
  Dropbox folder.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly).}

  \item{verbose}{default is FALSE. Set to true to receive
  full outcome.}
}
\value{
  information about the uploaded file on dropbox.
}
\description{
  Function to upload content (in-memory or a file) to
  Dropbox.
}
\examples{
\dontrun{
  dropbox_put(auth, 'DESCRIPTION', 'rDrop_DESCRIPTION')
  print(dropbox_get(auth, 'rDrop_DESCRIPTION'))
}
}

