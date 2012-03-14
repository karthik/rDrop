\name{dropbox_search}
\alias{dropbox_search}
\title{Search your Dropbox files and folders.}
\usage{
  dropbox_search(cred, query = NULL, deleted = FALSE,
    file_limit = 1000, is_dir = NULL, verbose = FALSE)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}

  \item{query}{The search string. Must be at least three
  characters long.}

  \item{include_deleted}{If this parameter is set to true,
  then files and folders that have been deleted will also
  be included in the search.}

  \item{file_limit}{The maximum and default value is 1,000.
  No more than file_limit search results will be returned.}

  \item{Verbose}{logical. Default is FALSE. Set to TRUE to
  get a full file listing.}
}
\value{
  data.frame with results. No results will return empty
  data.frame
}
\description{
  Search your Dropbox files and folders.
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

