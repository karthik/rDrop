dropbox_load <-
function(cred, file)
{
  data = dropbox_get(cred, file)
  deserialize(data)
  
}
