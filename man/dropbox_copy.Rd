\name{dropbox_copy}
\alias{dropbox_copy}
\alias{dropbox_cp}
\title{Function to copy files or folder within Dropbox.}
\usage{
  dropbox_copy(cred, from_path = NULL, to_path = NULL,
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class DropboxCredentials with
  Dropobox specific credentials.}

  \item{from_path}{Path to file or folder to be copied,
  relative to dropbox root.}

  \item{to_path}{Path to destination, including the new
  name for the file or folder, relative to dropbox root.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)..}
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
> dropbox_copy(cred, 'copy.txt', 'Public')
/copy.txt succcessfully copied to /Public/copy.txt on Thu, 29 Mar 2012 20:37:51 +0000
}
}
\seealso{
  dropbox_move dropbox_create_folder

  related: \code{\link{dropbox_move}}
}
\keyword{file_copy}

