# Dropbox interface via R

This package provides a  programmatic interface to Dropbox from within R. Disclaimer: We take absolutely no responsibility if you lose files because of using this package.

[Full API guidelines](https://www2.dropbox.com/developers/reference/api)


## Initial setup
1. To begin, create an `App` on dropbox from the [Dropbox Developer site ](https://www2.dropbox.com/developers/apps). You will need to log in with your dropbox username and password.
2. Next, click `Create An App`.
3. Give your app a name. This has to be unique in the universe of dropbox apps. Dropbox will let you know if a name is already taken. Dropbox branding guidelines prohibit the use of the word "Dropbox" or names that begin with "Drop". We recommend that you name the app something like "Your_first_name_last_name_rDrop" to avoid naming conflicts.

3a. Next add a brief description and choose Full Dropbox

4. Copy your App key and App Secret. If you use your `.rprofile` then we recommend that you save your keys there like so: <br>
`options("Dropbox_app_key"="xxxx")`<br>
`options("Dropbox_app_secret="yyyy")`
<br>
If you prefer not to specify keys in a .rprofile (or if you are on a public computer), you can specify both keys in the dropbox_auth() function directly. Note that once you have authorized an app, there is no need to call this function again. You can just use your saved credential file to access your Dropbox. If for any reason, the file becomes compromised, just revoke access from your Web panel.
That's it.

### Authorizing your app
From within R, load rDropbox first: <br>
`library(rDrop)`

 `dropbox_credentials <- dropbox_auth()` <br>
 If your keys are stored in your .rprofile, then there is no need to provide it to the function. If you don't have that setup, then use: <br>

 `dropbox_credentials <- dropbox_auth("my_consumer_key","my_consumer_secret")` <br>
 If this worked, you will be directed to a page asking you to authorize this app. Click ok to return to R.

 There is no need to run `dropbox_auth()` for each run. Simply save your credentials file to disk and load as needed:

 `save(dropbox_credentials,file="my_dropbox_credentials.rdata")`

 Credentials will remain valid until you revoke them from your [Dropbox Apps page](https://www2.dropbox.com/developers/apps).

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

