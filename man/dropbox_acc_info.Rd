\name{dropbox_acc_info}
\alias{dropbox_acc_info}
\title{Retrieve Dropbox account summary}
\usage{
  dropbox_acc_info(cred, curl = getCurlHandle(), ...)
}
\arguments{
  \item{cred}{An object of class DropboxCredentials with
  Dropobox specific credentials.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly).}
}
\value{
  list containing \item{referral link}{Dropbox referral
  link.} \item{display_name}{Dropbox display name}
  \item{uid}{Dropbox user id} \item{country}{Dropbox
  country} \item{quota_info}{Information on shared, quota,
  and normal.} \item{email}{Dropbox user email}
}
\description{
  Retrieve Dropbox account summary
}
\examples{
\dontrun{
dropbox_acc_info(cred)
}
}
\seealso{
  related: \code{\link{dropbox_auth}}
}
\keyword{authentication}
\keyword{OAuth}

