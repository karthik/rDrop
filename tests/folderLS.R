library(rDrop)
source("getCred.R")

if(!is.null(drop <- getCred()))
{  
   dummy = DropboxFolder("Dummy", drop)
   dropbox_dir(dummy)
   ls(dummy)
}
