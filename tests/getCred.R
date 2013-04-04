getCred <-
function()
{
  ff <- getOption("DROPBOX_OAUTH_RDA", "")
  if(ff == "")
    ff <- Sys.getenv("DROPBOX_OAUTH_RDA")
  
  if(ff != "" && file.exists(ff)) {
      what = load(ff, globalenv())
      get(what, globalenv())
  } else
    stop("cannot find saved dropbox credentials. Set it using the envirornment variable DROPBOX_AUTH_RDA")
}

