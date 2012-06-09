\name{dropbox_save}
\alias{dropbox_save}
\title{Function to save an object from R into Dropbox (not working)}
\usage{
  dropbox_save(cred, list = character(),
    file = stop("'file' must be specified"),
    envir = parent.frame(), precheck = TRUE,
    verbose = FALSE, curl = getCurlHandle(), ...,
    ext = ".rdata")
}
\arguments{
  \item{cred}{Specifies an object of class
  DropboxCredentials with Dropobox specific credentials.}

  \item{list}{List of objects from the current R
  environment that needs to be saved into dropbox}

  \item{file}{Required filename. No extenstion needs to be
  supplied. If you provide one, it will be stripped and
  replace with rda.}

  \item{envir}{optional. Defaults to parent environment.}

  \item{precheck}{internal use. Checks to make sure all
  objects are in the parent environment.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{verbose}{default is FALSE. Set to true to receive
  full outcome.}

  \item{...}{optional additional curl options (debugging
  tools mostly).}

  \item{ext}{file extension. Default is \code{.rda}}
}
\value{
  JSON object
}
\description{
  This function saves an R object to Dropbox. One can then
  retrieve it and load it back into R.
}
\examples{
\dontrun{
dropbox_save(cred, robject, file='filename')
dropbox_save(cred, file = 'testRData', .objs = list(a = 1:3, b = letters[1:10]))
a = dropbox_get(cred, 'testRData.rdata', binary = TRUE)
val = unserialize(rawConnection(a))

  # specifying our own name without the standard .rdata
dropbox_save(cred, list(a = 1:4, b = letters[1:3]), I('duncan.rda'), verbose = TRUE)
  # or
dropbox_save(cred, list(a = 1:4, b = letters[1:3]), 'duncan', verbose = TRUE, ext = '.rda')
}
}

