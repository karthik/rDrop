library(plyr)
library(ROAuth)
library(RJSONIO)

# Status: Works but only from terminal.

#'Function to authenticate into your Dropbox account and get access keys
#'
#'@import RCurl ROAuth RJSONIO plyr
#'@param cKey A valid Dropbox application key
#'@param cSecret A valid Dropbox application secret
#'@keywords
#'@seealso dropbox_acc_info
#'@return Oauth object with Dropbox keys
#'@alias
#'@export dropbox_auth
#'@examples \dontrun{
#' dropbox_auth() # if you have keys in .rprofile stored as
#' # options(DropboxKey='YOUR_APP_KEY')
#' # options(DropboxSecret='YOUR_SECRET_KEY')
#' # else use:
#' dropbox_auth('YOUR_APP_KEY','YOUR_APP_SECRET')
#' my_dropbox_tokens <- dropbox_auth()
#' mydropbox_tokens <-
#'   dropbox_auth('consumey_key','consumer_secret')
#' save(mydropbox_tokens,file='dropbox_auth.rdata')
#'}
dropbox_auth <- function(cKey = NULL, cSecret = NULL, verbose = FALSE) {
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
    cat("Beginning authenticating with Dropbox... \n")
    cred$handshake(post = FALSE)
    # Need to hide the enter PIN request for Dropbox
    if (TRUE) {
        cat("\n Dropbox Authentication completed successfully.\n")
    }
    if (FALSE) {
        cred$OAuthRequest("https://api.dropbox.com/1/account/info")
        cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/foo")
        cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/foo",
            httpheader = c(Range = "bytes=30-70"), verbose = TRUE)
    }
    return(cred)
}
# Bugs
# Works fine via R terminal, RStudio but not R console.
# Calling this fuction via terminal R works as intended. If the
#   function is run interactively on R-GUI, then it crashes R.app or
#   R64.app completely.
# My workaround so far has been to run dropbox_auth() via terminal,
#   save the OAuth object to disk, then load and use in GUI-R.

# # Todos
# 1. Add option to save (logical)
# 2. Add option to specify name for crendential file.
