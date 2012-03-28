\name{dropbox_search}
\alias{dropbox_search}
\title{Search Dropbox files and folders.}
\usage{
  dropbox_search(cred, query = NULL, deleted = FALSE,
    file_limit = 1000, is_dir = NULL, verbose = FALSE,
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class DropboxCredentials with
  Dropobox specific credentials.}

  \item{query}{The search string. Must be at least three
  characters long.}

  \item{deleted}{If this parameter is set to true, then
  files and folders that have been deleted will also be
  included in the search.}

  \item{file_limit}{The maximum and default value is 1,000.
  No more than file_limit search results will be returned.}

  \item{is_dir}{logical, TRUE looks for directories only.}

  \item{verbose}{logical. Default is FALSE. Set to TRUE to
  get a full file listing.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}
}
\value{
  data.frame with results. No results will return empty
  data.frame
}
\description{
  If you are searching for a file/folder in the root
  directory, you can ignore the path. If searching for a
  file/folder in a specific location, then you should
  provide a full path to the object.
}
\examples{
\dontrun{
results<-dropbox_search(cred,'file or folder name')
results<-dropbox_search(cred,'/specific/path/file or folder name')
Returns a small data.frame with path and is_dir
results<-dropbox_search(cred,'search_term',verbose=T)
Verbose results include a data.frame with columns: revision,rev,thumb_exists,bytes,modified,path,is_dir,icon,root,mime_type,size
}
}

