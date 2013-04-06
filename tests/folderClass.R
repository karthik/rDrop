library(rDrop)
source("getCred.R")

if(!is.null(drop <- getCred()))
{
   dummy = DropboxFolder("Dummy", drop)
   objs = ls(dummy)
   dummy[[objs[1], .checkIfExists = FALSE]]
}
