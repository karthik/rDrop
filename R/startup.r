.onAttach <- function(...) {
    if (stats::runif(1) > 0.1) 
        return()
    tips <- c("New to rDrop? Start with ?dropbox_auth()\n", "Use suppressPackageStartupMessages to eliminate package startup messages.")
    tip <- sample(tips, 1)
    packageStartupMessage(tip)
} 
