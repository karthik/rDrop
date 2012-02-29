# Dropbox interface via R

This package provides a  programmatic interface to Dropbox from within R.


## Initial setup
1. To begin, first create an `App` on dropbox from here [https://www2.dropbox.com/developers/apps](https://www2.dropbox.com/developers/apps). You will need to log in with your dropbox username and password.
2. Next, click `Create An App`.
3. Give your app a name. This has to be unique in the universe of dropbox apps. Dropbox will let you know if a name is already taken. Next add a brief description and choose Full Dropbox
4. Copy your App key and App Secret. If you use your `.rprofile` then we recommend that you save your keys there like so: <br>
`options("Dropbox_app_key"="xxxx")`<br>
`options("Dropbox_app_secret="yyyy")`
<br>
That's it.

### Authorizing your app
From within R, load rDropbox first: <br>
`library(rDropbox)`

 `dropbox_credentials <- dropbox_auth()` <br>
 If your keys are stored in your .rprofile, then there is no need to provide it to the function. If you don't have that setup, then use: <br>

 `dropbox_credentials <- dropbox_auth("my_consumer_key","my_consumer_secret")` <br>
 If this worked, you will be directed to a page asking you to authorize this app. Click ok to return to R.

 Then save this set of credentials in a file like so:

 `save(dropbox_credentials,file="my_dropbox_credentials.rdata")`

### Basic Usage
To use a saved Dropbox credential file, simply load the file when you need to use dropbox functions.
`load('/path/to/my_dropbox_credentials.rdata')`

#### Account Info
`dropbox_acc_info(my_dropbox_cred)`

#### View Files

#### Download Files to R

#### Upload Files from R

#### Move Files from R

#### Copy files to public directory

#### Get a public URL

