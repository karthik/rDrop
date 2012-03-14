\name{dropbox_acc_info}
\alias{dropbox_acc_info}
\title{Retrieve Dropbox account summary}
\usage{
  dropbox_acc_info(cred)
}
\arguments{
  \item{cred}{An object of class ROAuth with Dropobox
  specific credentials.}
}
\value{
  list containing referral_link, display_name, uid,
  country, quota_info, and email.
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
  \code{\link{dropbox_auth}}
}
\keyword{authentication}
\keyword{OAuth}

