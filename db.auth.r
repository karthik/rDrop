library(plyr)
library(ROAuth)
library(RJSONIO)

#'Authenticate into your Dropbox account and get access keys
#'
#' @import RCurl ROAuth RJSONIO plyr
#'@param cKey Your Dropbox  application key
#'@param cSecret your Drpbox application secret
#'@keywords
#'@seealso
#'@return
#'@alias
#'@export
#'@examples \dontrun{
#' dropbox_auth() # if you have keys in .rprofile stored as
#' # options(DropboxKey='YOUR_APP_KEY')
#' # options(DropboxSecret='YOUR_SECRET_KEY')
#' # else use:
#' dropbox_auth('YOUR_APP_KEY','YOUR_APP_SECRET')
#'}
dropbox_auth <- function(cKey = NULL, cSecret = NULL,
    verbose = FALSE) {
    #Checking to make sure you specify keys one way or
    #   another
    if (is.null(cKey) && is.null(cSecret)) {
        cKey = getOption("DropboxKey")
        cSecret = getOption("DropboxSecret")
        if (length(cKey) == 0 | length(cSecret) == 0) {
            stop("Could not find your Dropbox keys in the function arguments or in your options. ?rDropbox for more help")
        }
    }
    reqURL <- "https://api.dropbox.com/1/oauth/request_token"
    authURL <- "https://www.dropbox.com/1/oauth/authorize"
    accessURL <- "https://api.dropbox.com/1/oauth/access_token/"
    cred <- OAuthFactory$new(consumerKey = cKey, consumerSecret = cSecret,
        requestURL = reqURL, accessURL = accessURL, authURL = authURL)
    cat("Authenticating with Dropbox \n")
    cred$handshake(post = FALSE)
    # Need to hide the enter PIN request for this case
    if (TRUE) {
        cat("\n Dropbox Authentication complete, please wait for handshake to finish....\n")
    }
    if (FALSE) {
        cred$OAuthRequest("https://api.dropbox.com/1/account/info")
        cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/foo")
        cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/foo",
            httpheader = c(Range = "bytes=30-70"), verbose = TRUE)
    }
    return(cred)
}

# my_dropbox_tokens <- dropbox_auth()
# mydropbox_tokens <-
#   dropbox_auth('consumey_key','consumer_secret')
# save(mydropbox_tokens,file="dropbox_auth.rdata")
