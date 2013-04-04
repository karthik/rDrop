library(rDrop)

source("getCred.R")

if(!is.null(drop <- getCred()))
{

  dropbox_serialize(drop, "x", 1:10)
  dropbox_unserialize(drop, "x")

  dropbox_unserialize(drop, I("x.rda"))
}
