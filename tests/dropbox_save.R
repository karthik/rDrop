library(rDrop)


if( (ff <- Sys.getenv("DROPBOX_AUTH_RDA")) != ""
    && file.exists(ff))
{
  what = load(ff, globalenv())
  drop = get(what, globalenv())

  a = 1:10
  b = pi
  c = LETTERS
  d = rnorm
  
  dropbox_save(drop, a, b, c, d, file = "rDropTest")

  rm(a, b, c, d)
  dropbox_load(drop, "rDropTest.rda")
}
