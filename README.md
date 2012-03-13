# rDrop: Dropbox interface via R

This package provides a  programmatic interface to [Dropbox](https://www2.dropbox.com/home) from the [R environment](http://www.r-project.org/).

> **Disclaimer: This package is currently in beta and we make no claims or warranties as to the safety of your Dropbox contents. Use at your own risk.**

Reference:
[Complete Dropbox API Reference.](https://www2.dropbox.com/developers/reference/api)


## Initial setup
(1) To begin, create an `App` on Dropbox from the [Dropbox Developer site](https://www2.dropbox.com/developers/apps). You will need to log in with your Dropbox username and password.

(2) Next, click `Create An App`.

![Create an app for your personal use on Dropbox](https://github.com/karthikram/rDrop/blob/master/screenshots/create_app.png?raw=true
)

(3) Name your personal version of this app. Dropbox requires that your app have a unique name. Dropbox [branding guidelines](https://www2.dropbox.com/developers/reference/branding) also prohibit the use of the word **"Dropbox"** or names that begin with "**Drop**". We recommend that you name the app something like "**Your_first_name_last_name_rDrop**" to avoid naming conflicts. You won't have to deal with the app name after this step.


![Alt text](https://github.com/karthikram/rDrop/blob/master/screenshots/name_your_app.png?raw=true)

(4) Once you click create, be sure to **copy your App key and App secret** and store it somewhere safe. If you forget it, you can always find it [here](https://www.dropbox.com/developers/apps) (Just click on options next to your App name). 
If you use your `.rprofile` and no one else uses your computer,  then we recommend you save your keys there by adding the following lines: <br><br>

`options(DropboxKey = "Your_App_key")`
`options(DropboxSecret = "Your_App_secret")`

<br>

![Alt text](https://github.com/karthikram/rDrop/blob/master/screenshots/keys.png?raw=true)

If you prefer not to specify keys in a `.rprofile` (especially if you are on a public computer/cluster/cloud server), you can specify both keys in the `dropbox_auth()` function directly (more below). <em>Note that once you have authorized an app, there is no need to call this function again.</em> You can just use your saved credential file to access your Dropbox. If for any reason, the file becomes compromised, just revoke access from your [list of authorized apps.](https://www2.dropbox.com/account#applications)

### Authorizing your app
From within `R`, load `rDrop` first: 

<pre><code>
library(rDrop)
# Not yet on CRAN. Will make this available via devtools shortly.
</code></pre>

<pre><code>
 dropbox_credentials <- dropbox_auth()
</code></pre>
 
 If your keys are stored in your `.rprofile`, then there is no need to provide it to the function. If you don't have that setup, then use: 
<pre><code>
 dropbox_credentials <- dropbox_auth("my_consumer_key","my_consumer_secret")
</code></pre>

 If you entered valid keys, you will be directed to a secure page on Dropbox asking you to authorize this app. Click authorize to add this to your approved app list and to return to R.

 There is no need to run `dropbox_auth()` for each subsequent run. Simply save your credentials file to disk and load as needed:

<pre><code>
 save(dropbox_credentials, file="/path/to/my_dropbox_credentials.rdata")
</code></pre>

Credentials will remain valid until you revoke them from your [Dropbox Apps page](https://www2.dropbox.com/developers/apps) by clicking the x next to your App's name.


# Quick User Guide
This package essentially provides standard Dropbox file operation functions (create/copy/move/restore/share) from within `R`. For a vignette, type: 
<pre><code>
vignette('rdrop') # from the R prompt.
\# not setup yet.
</code></pre>

To load a previously validated Dropbox credential file:
<pre><code>
load('/path/to/my_dropbox_credentials.rdata')
</code></pre>

### Summary of your Dropbox Account
<pre><code>
dropbox_acc_info(my_dropbox_cred) 
\# will return a list with your display name, email, quota, referral URL, and country.
</code></pre>

### Directory listing
<pre><code>
\# will list contents of your Dropbox root. 
dropbox_dir(cred)
\# for a complete listing with detailed information:
dropbox_dir(cred, verbose = TRUE)

\# To see contents of a specific path, use:
dropbox_dir(cred, path = 'folder_name')
</code></pre>


### Download files from your Dropbox account to R
<pre><code>
\# Example
</code></pre>

### Upload R objects to your Dropbox
<pre><code>
\# Example
</code></pre>

### Moving files within Dropobx
<pre><code>
\# Example
</code></pre>

### Copying files within Dropbox
<pre><code>
\# Example
</code></pre>

### Creating a public share for any Dropbox file or folder
<pre><code>
\# Example
</code></pre>


For more information on usage and tips, see: <br>
<em>Blog posts and CRAN repo forthcoming.</em>

