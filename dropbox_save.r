
dropbox_save <- function(cred,file)
{
content = "This is simple content"
input = RCurl:::uploadFunctionHandler(content, TRUE)
trace(input)
# Below crashes R64
xx = cred$OAuthRequest("https://api-content.dropbox.com/1/files_put/dropbox/up",, "POST",
                        upload = TRUE, readdata = input, infilesize = nchar(content) - 3L, verbose = TRUE)
}