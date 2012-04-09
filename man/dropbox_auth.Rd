\name{dropbox_auth}
\alias{dropbox_auth}
\alias{rDrop}
\title{rDrop: programmatic access to Dropbox from R.}
\usage{
  dropbox_auth(cKey = getOption("DropboxKey", stop("Missing Dropbox consumer key")),
    cSecret = getOption("DropboxSecret", stop("Missing Dropbox app secret")),
    curl = getCurlHandle(), ...)
}
\arguments{
  \item{cKey}{A valid Dropbox application key}

  \item{cSecret}{A valid Dropbox application secret}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{...}{optional additional curl options (debugging
  tools mostly).}
}
\value{
  Message with success or error.

  Oauth object of class \code{DropboxCredentials}
}
\description{
  Before using any of rDrop's functions, you must first
  create an application on the Dropobox developer site
  (\url{https://www2.dropbox.com/developers/apps}). This
  application is specific to you. Follow through with the
  steps to create your application and copy the generated
  consumer key/secret combo. Ideally you should save those
  keys (on separate lines) in your options as:
  \code{options(DropboxKey = 'Your_App_key')}
  \code{options(DropboxSecret = 'Your_App_secret')}. If you
  are unable to do so (example: Using rDrop from a public
  machine), then you can just specifiy both keys inline.
  Once you have authenticated, there is no reason to repeat
  this step for subsequent sessions. Simply save the OAuth
  object to disk and load it in a script as necessary.
  Future versions of ROAuth will make it easier for you to
  just update the token (if necessary) without having to
  reauthoize via the web. \emph{Do not store these keys in
  your .rprofile if you are on a public machine}. Anyone
  with access to this ROAuth object will have full control
  of your Dropbox account.
}
\details{
  Once you have created an app, retrieve your access keys
  using \code{dropbox_auth()}
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

