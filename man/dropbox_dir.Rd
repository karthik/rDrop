\name{dropbox_dir}
\alias{dropbox_dir}
\title{Function to list contents of a Dropbox folder.}
\usage{
  dropbox_dir(cred, path = NULL, verbose = FALSE,
    deleted = FALSE, pattern = NULL,
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class DropboxCredentials with
  Dropobox specific credentials.}

  \item{path}{The directory to list. Not yet implemented}

  \item{verbose}{logical. FALSE returns a list with file
  names in root folder. TRUE returns a \code{data.frame}
  with the following fields: id, revision, rev,
  thumb_exists, bytes, path, modified, and is_dir}

  \item{deleted}{logical. Default is FALSE. Set to TRUE to
  also list deleted files.}

  \item{pattern}{an optional regular expression. Only file
  names which match the regular expression will be
  returned.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly).}
}
\value{
  directory listing with file or folder names unless
  \code{verbose = TRUE} in which case a data.frame is
  returned.
}
\description{
  If no folder is specifies, it will only list contents of
  the root folder.
}
\examples{
\dontrun{
dropbox_dir(db_cred)
dropbox_dir(db_cred, path='/specific_folder')
dropbox_dir(db_cred,path='/specific_folder', verbose = TRUE)
dropbox_dir(db_cred,path='/specific_folder', pattern='file', verbose = TRUE)
returns a dataframe with fields .id, revision, rev, thumb_exists, bytes, modified path, is_dir, icon, root, size, client_mtime, mimetype.
}
}

