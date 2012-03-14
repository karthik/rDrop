#'Function to authenticate into your Dropbox account and get access keys
#'
#'@import RCurl ROAuth RJSONIO plyr
#'@param cKey A valid Dropbox application key
#'@param cSecret A valid Dropbox application secret
#'@keywords
#'@seealso dropbox_acc_info
#'@return Oauth object with Dropbox keys
#'@alias
#'@import RJSONIO ROAuth
#'@export dropbox_auth
#'@examples \dontrun{
#' dropbox_auth() # if you have keys in .rprofile stored as
#' # options(DropboxKey='YOUR_APP_KEY')
#' # options(DropboxSecret='YOUR_SECRET_KEY')
#' # else use:
#' dropbox_auth('YOUR_APP_KEY', 'YOUR_APP_SECRET')
#' dropbox_tokens <- dropbox_auth()
#' dropbox_token <- dropbox_auth('consumey_key', 'consumer_secret')
#' save(dropbox_token, file = 'dropbox_auth.rdata')
#'}
dropbox_auth <- function(cKey = NULL, cSecret = NULL, 
    verbose = FALSE) {
    #Checking to make sure you specify keys one way or
    #   another
    if (is.null(cKey) && is.null(cSecret)) {
        cKey <- getOption("DropboxKey")
        cSecret <- getOption("DropboxSecret")
        if (length(cKey) == 0 | length(cSecret) == 0) {
            stop("Could not find your Dropbox keys in the function arguments or in your options. ?rDrop for more help")
        }
    }
    reqURL <- "https://api.dropbox.com/1/oauth/request_token"
    authURL <- "https://www.dropbox.com/1/oauth/authorize"
    accessURL <- "https://api.dropbox.com/1/oauth/access_token/"
    cred <- OAuthFactory$new(consumerKey = cKey, consumerSecret = cSecret, 
        requestURL = reqURL, accessURL = accessURL, authURL = authURL)
    cat("Beginning authenticating with Dropbox... \n")
    cred$handshake(post = FALSE)
    # Need to hide the enter PIN request for Dropbox but not
    #   critical.
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
# API documentation:
#
#
#
#
#   https://www.dropbox.com/developers/reference/api#request-token 
