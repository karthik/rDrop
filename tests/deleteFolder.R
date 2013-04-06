library(rDrop)
source("getCred.R")

if(!is.null(drop <- getCred())) {
  dummy = DropboxFolder("Dummy", drop)
  e = dropbox_create_folder(dummy, "Extra")
  e = dropbox_delete(dummy, "Extra")  
}
