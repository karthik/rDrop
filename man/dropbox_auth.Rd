\name{dropbox_auth}
\alias{dropbox_auth}
\title{Function to authenticate into your Dropbox account and get access keys}
\usage{
  dropbox_auth(cKey = NULL, cSecret = NULL,
    verbose = FALSE)
}
\arguments{
  \item{cKey}{A valid Dropbox application key}

  \item{cSecret}{A valid Dropbox application secret}
}
\value{
  Oauth object with Dropbox keys
}
\description{
  Function to authenticate into your Dropbox account and
  get access keys
}
\examples{
\dontrun{
dropbox_auth() # if you have keys in .rprofile stored as
# options(DropboxKey='YOUR_APP_KEY')
# options(DropboxSecret='YOUR_SECRET_KEY')
# else use:
dropbox_auth('YOUR_APP_KEY', 'YOUR_APP_SECRET')
dropbox_tokens <- dropbox_auth()
dropbox_token <- dropbox_auth('consumey_key', 'consumer_secret')
save(dropbox_token, file = 'dropbox_auth.rdata')
}
}
\seealso{
  dropbox_acc_info
}
\keyword{authentication}

