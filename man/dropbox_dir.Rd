\name{dropbox_dir}
\alias{dropbox_dir}
\title{Function to list contents of a Dropbox folder. If no folder is specified, function will list contents of root folder.}
\usage{
  dropbox_dir(cred, path = NULL, verbose = FALSE,
    deleted = FALSE)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{path}{The directory to list. Not yet implemented}

  \item{verbose}{logical. FALSE returns a list with file
  names in root folder. TRUE returns a data.frame with the
  following fields: .id,revision, rev, thumb_exists,
  bytes,modified, path, is_dir, icon,root,size,mime_type.}

  \item{recursive}{logical. Setting this to true will list
  all your dropbox files. Not yet implemented.}

  \item{deleted}{logical. Default is FALSE. Set to TRUE to
  also list deleted files.}
}
\value{
  message
}
\description{
  Function to list contents of a Dropbox folder. If no
  folder is specified, function will list contents of root
  folder.
}
\examples{
\dontrun{
dropbox_dir(cred)
dropbox_dir(cred, recursive = TRUE)
dropbox_dir(cred,path='/specific_folder')
dropbox_dir(cred,path='/specific_folder',verbose = TRUE)
returns a dataframe with fields .id,
}
}

