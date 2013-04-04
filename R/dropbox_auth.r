#' An S4 class that stores Dropbox credentials
#' @name DropboxCredentials-class
#' @rdname DropboxCredentials-class
#' @exportClass DropboxCredentials
setClass("DropboxCredentials", contains = "OAuthCredentials")
#' rDrop: programmatic access to Dropbox from R.
#'
#' Before using any of rDrop's functions, you must first create an application on the Dropobox developer site (\url{https://www2.dropbox.com/developers/apps}). This application is specific to you. Follow through with the steps to create your application and copy the  generated consumer key/secret combo. Ideally you should save those keys (on separate lines) in your options as:
#' \code{options(DropboxKey = 'Your_App_key')}
#' \code{options(DropboxSecret = 'Your_App_secret')}
#' If you are unable to do so (example: Using \code{rDrop} from a public machine), then you can just specifiy both keys inline. Once you have authenticated, there is no reason to repeat this step for subsequent sessions. Simply save the OAuth object to disk and load it in a script as necessary. Future versions of ROAuth will make it easier for you to just update the token (if necessary) without having to reauthoize via the web. \emph{Do not store these keys in your .rprofile if you are on a public machine}. Anyone with access to this ROAuth object will have full control of your Dropbox account.
#'
#' Once you have created an app, retrieve your access keys using \code{dropbox_auth()}
#' @param cKey A valid Dropbox application key
#' @param cSecret A valid Dropbox application secret
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @return Message with success or error.
#' @return Oauth object of class \code{DropboxCredentials}
#' @import RJSONIO ROAuth
#' @export dropbox_auth
#' @aliases rDrop
#' @import stringr
#' @import plyr
#' @import RJSONIO
#' @import ROAuth
#' @import RCurl
#' @examples \dontrun{
#' dropbox_auth() # if you have keys in .rprofile stored as
#' # options(DropboxKey='YOUR_APP_KEY')
#' # options(DropboxSecret='YOUR_SECRET_KEY')
#' # else use:
#' dropbox_auth('YOUR_APP_KEY', 'YOUR_APP_SECRET')
#' dropbox_tokens <- dropbox_auth()
#' dropbox_token <- dropbox_auth('consumey_key', 'consumer_secret')
#' save(dropbox_token, file = 'dropbox_auth.rdata')
#'}
dropbox_auth <-
function(cKey = getOption("DropboxKey", stop("Missing Dropbox consumer key")),
         cSecret = getOption("DropboxSecret", stop("Missing Dropbox app secret")),
         curl = getCurlHandle(...), ..., .opts = list(...))
{

  reqURL <- "https://api.dropbox.com/1/oauth/request_token"
  authURL <- "https://www.dropbox.com/1/oauth/authorize"
  accessURL <- "https://api.dropbox.com/1/oauth/access_token/"

  if(!missing(curl) && length(.opts))
    curlSetOpt(.opts = .opts, curl = curl)

  dropbox_oa <- oauth(cKey, cSecret, reqURL, authURL, accessURL,
                      obj = new("DropboxCredentials"))

  cred <- handshake(dropbox_oa, 
                    verify = paste("Use the Web browser to grant permission to this code",
                                   "to access Dropbox on your behalf.\nWhen you see 'Success!', hit enter in R",
                                    sep = "\n"),
                    curl = curl)

  if (TRUE) 
    cat("\n Dropbox authentication completed successfully.\n")

  if (FALSE) {
    info <- OAuthRequest(dropbox_oa, "https://api.dropbox.com/1/account/info")
    OAuthRequest(dropbox_oa, "https://api-content.dropbox.com/1/files/dropbox/foo")
    OAuthRequest(dropbox_oa, "https://api-content.dropbox.com/1/files/dropbox/foo",
                 httpheader = c(Range = "bytes=30-70"), verbose = TRUE)
  }

  return(cred)
}
# API documentation:

# https://www.dropbox.com/developers/reference/api#request-token 
