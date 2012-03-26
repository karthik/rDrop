\name{dropbox_save}
\alias{dropbox_save}
\title{Function to save an object from R into Dropbox (not working)}
\usage{
  dropbox_save(cred, content, file = NULL)
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

  \item{content}{The file contents to be uploaded. Requires
  a multipart upload (multipart/form-data), and the
  filename parameter of this field should be set to the
  desired destination filename. While signing this request
  for OAuth, the file parameter should be set to the
  destination filename, and then switched to the file
  contents when preparing the multipart request.}

  \item{file}{Name of file to be saved. If blank, the name
  of the R object will be used.}
}
\description{
  This function currently does not work.
}
\examples{
\dontrun{
dropbox_save(robject, file='filename')
}
}

