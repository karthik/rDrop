\name{dropbox_save}
\alias{dropbox_save}
\title{Function to save an object from R into Dropbox (not working)}
\usage{
  dropbox_save(cred, ..., list = character(),
    file = stop("'file' must be specified"),
    envir = parent.frame(), precheck = TRUE,
    curl = getCurlHandle())
}
\arguments{
  \item{cred}{Specifies an object of class ROAuth with
  Dropobox specific credentials.}

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

  \item{...}{optional additional curl options (debugging
  tools mostly)}
}
\value{
  JSON object
}
\description{
  This function currently does not work.
}
\examples{
\dontrun{
dropbox_save(cred, robject, file='filename')
}
}

