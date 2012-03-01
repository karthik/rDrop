# Dropbox interface via R

This package provides a  programmatic interface to Dropbox from within R.

**Disclaimer: This package is currently in beta and we make no claims or warranties as to the safety of your Dropbox contents. Use at your own risk.**

Also see:
[Complete Dropbox API Reference](https://www2.dropbox.com/developers/reference/api)


## Initial setup
1. To begin, create an **App** on Dropbox from the [Dropbox Developer site](https://www2.dropbox.com/developers/apps). You will need to log in with your dropbox username and password.

2. Next, click `Create An App`.

<!-- Screenshot -->


3. Give your app a name. Dropbox requires that your app have a unique name. Dropbox branding guidelines also prohibit the use of the word **"Dropbox"** or names that begin with "**Drop**". We recommend that you name the app something like "**Your_first_name_last_name_rDrop**" to avoid naming conflicts.

<!-- Screenshot -->

3. Copy your application key and application Secret. If you use your `.rprofile` then we recommend that you save your keys there like so: <br>
`options("Dropbox_app_key"="YOUR_APPLICATION_KEY")`<br>
`options("Dropbox_app_secret="YOUR_APPLICATION_SECRET")`
<br>

<!-- Screenshot -->

If you prefer not to specify keys in a `.rprofile` (or if you are on a public computer/cluster), you can specify both keys in the `dropbox_auth()` function directly. Note that once you have authorized an app, there is no need to call this function again. You can just use your saved credential file to access your Dropbox. If for any reason, the file becomes compromised, just revoke access from your [Dropbox web panel](https://www2.dropbox.com/developers/apps).
That's it.

### Authorizing your app
From within R, load rDrop first: <br>
`library(rDrop)`

 `dropbox_credentials <- dropbox_auth(save=T,file='my_dropbox_cred.rdata')`
 <br>
 If your keys are stored in your `.rprofile`, then there is no need to provide it to the function. If you don't have that setup, then use: <br>

 `dropbox_credentials <- dropbox_auth("my_consumer_key","my_consumer_secret")` <br>

 If you entered valid keys, you will be directed to a page on Dropbox asking you to authorize this app. Click **FFFFFF** to return to R.

 There is no need to run `dropbox_auth()` for each run. Simply save your credentials file to disk and load as needed:

 `save(dropbox_credentials,file="my_dropbox_credentials.rdata")`

 Credentials will remain valid until you revoke them from your [Dropbox Apps page](https://www2.dropbox.com/developers/apps).


### Quick Guide
This package essentially provides standard Dropbox file operation functions (create/copy/move/restore/share) from within `R`. For a vignette, type in: <br>

`vignette('rdrop')` from the `R` prompt.

To load a previously validated Dropbox credential file: <br>
`load('/path/to/my_dropbox_credentials.rdata')`

#### Summary of your Dropbox Account

`dropbox_acc_info(my_dropbox_cred)`

Returns a list with your display name, email, quota, referral URL and country.

#### Directory listing

`dropbox_dir(cred)` # will list contents of your Dropbox root.
`dropbox_dir(cred,path) # will return dir listing of specified path.

#### Download files from your Dropbox account to R

#### Upload R objects to your Dropbox

#### Moving files within Dropobx

#### Copying files within Dropbox

#### Creating a public share for any Dropbox file or folder


For more information on usage and tips, see [Introducing a programmatic interface to Dropbox from R](http://inundata.org/...)
[rDrop on CRAN](http://cran link)

