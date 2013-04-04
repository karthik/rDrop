dropbox_serialize <-
function(cred, file, precheck = TRUE, verbose = FALSE, curl = getCurlHandle(),
           ext = ".rda", ...)
{
    if (!is(cred, "DropboxCredentials")) 
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", 
            call. = FALSE)

    data = dropbox_get(cred, file, ..., curl = curl, binary = TRUE)
    unserialize(data)
}

