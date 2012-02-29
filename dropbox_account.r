
dropbox_acc_info<-function(cred)
{
status <- fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/account/info"))
metadata = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/metadata/dropbox/"))
names(metadata$contents) = basename(sapply(metadata$contents, `[[`, "path"))
file_system<-metadata[[8]]
status$files <- ldply(file_system, data.frame)
status$raw_metadata <- metadata
return(status)
}

# Todos:
# clean up the dates
# rename ID to filename
