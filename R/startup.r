.onAttach <- function(...) {
    if (stats::runif(1) > 0.1)
        return()
packageStartupMessage("New to rDrop? Start with ?dropbox_auth()\n")
}
