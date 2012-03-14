\name{is.dropbox.cred}
\alias{is.dropbox.cred}
\title{Verifies whether a user has specified a correct Oauth credential for Dropbox}
\usage{
  is.dropbox.cred(cred, response = TRUE)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}
}
\value{
  logical
}
\description{
  Verifies whether a user has specified a correct Oauth
  credential for Dropbox
}
\examples{
\dontrun{
is.dropbox.cred(your_dropbox_credential_object)
}
}

