VERSION=$(shell grep 'Version:' DESCRIPTION  | sed -e 's/Version: //')
TAR_FILE=rDrop_$(VERSION).tar.gz

# code to roxygenize the help pages.
# Why can't roxygen2 be more flexible and 
#  allow us to control which bits it creates and which bits it 
#  leaves to us

../$(TAR_FILE) build:
	(cd .. ; R CMD build rDrop)

check: build
	(cd .. ; R CMD check --as-cran $(TAR_FILE))



