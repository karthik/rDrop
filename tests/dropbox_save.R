library(rDrop)

source("getCred.R")

if(!is.null(drop <- getCred()))
{

  a = 1:10
  b = pi
  c = LETTERS
  d = rnorm
  
  dropbox_save(drop, a, b, c, d, file = "rDropTest")

  rm(a, b, c, d)
  dropbox_load(drop, "rDropTest.rda")
}
