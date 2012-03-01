library(ROAuth)
library(RJSONIO)
library(RCurl)
library(twitteR)
# Your consumer key and secret are available
#       at https://www.dropbox.com/developers/apps


# Would handle authentication into Dropbox
reqURL <- "https://api.dropbox.com/1/oauth/request_token"
accessURL <- "https://api.dropbox.com/1/oauth/access_token"
authURL <- "https://www.dropbox.com/1/oauth/authorize"
cKey <- getOption("DROPBOX_APP_KEY")
cSecret <- getOption("DROPBOX_APP_SECRET")
access_type <- "dropbox"

dropbox_cred <- OAuthFactory$new(consumerKey = cKey,
    consumerSecret = cSecret, requestURL = reqURL, accessURL = accessURL,
    authURL = authURL)
dropbox_cred$handshake()

dropbox_cred$handshakeComplete <- TRUE
registerTwitterOAuth(dropbox_cred)
save("dropbox_cred", file = "Dropbox_credentials")




# ````````````````````````````````````````````
# Mendeley
library(ROAuth)
library(RJSONIO)
reqURL <- "http://www.mendeley.com/oauth/request_token/"
accessURL <- "http://www.mendeley.com/oauth/access_token/"
authURL <- "http://www.mendeley.com/oauth/authorize/"
cKey <- getOption("MendeleyKey")
cSecret <- getOption("MendeleyPrivateKey")

credentials <- OAuthFactory$new(consumerKey = cKey,
    consumerSecret = cSecret, requestURL <- reqURL, accessURL = accessURL,
    authURL = authURL)
credentials$handshake()

# This code below is deprecated. Do not use.
# timestamp=round(as.numeric(Sys.time()),0)
#
#
#
#
#   nonce=fromJSON(getURL('http://services.packetizer.com/nonce/?f=json'))

# oauth_signature=(paste(cKey,'&',cSecret,sep=''))


#
#
#
#
#   postForm('http://www.mendeley.com/oauth/request_token/',oauth_consumer_key=cKey,oauth_nonce=nonce,
#
#
#
#   oauth_signature_method='HMAC-SHA1',oauth_signature=oauth_signature,oauth_version='1.0',oauth_timestamp=timestamp,style=
#   'POST')

#
# ````````````````````````````````````````````
