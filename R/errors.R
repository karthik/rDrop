
missingCredentialsError <-
function()
{
  raiseError("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", c("MissingDropboxCredentials", "MissingOAuthCredentials"))
}

raiseError <-
function(msg, class)
{
  e <- structure(list(message = msg),
                 class = c(class, "rDropError", "simpleError", "error", "condition"))
   
   stop(e, call = NULL) #  , call.= FALSE)
}
