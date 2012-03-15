# rDrop: Dropbox interface via R

This package provides a  programmatic interface to [Dropbox](https://www2.dropbox.com/home) from the [R environment](http://www.r-project.org/).

> **Disclaimer: This package is currently in development and we make no claims or warranties as to the safety of your Dropbox contents. Use at your own risk.**

Reference:
[Complete Dropbox API Reference.](https://www2.dropbox.com/developers/reference/api)


#Initial setup
(1) To begin, create an `App` on Dropbox from the [Dropbox Developer site](https://www2.dropbox.com/developers/apps). You will need to log in with your Dropbox username and password.Then, click `Create An App`.

![Create an app for your personal use on Dropbox](https://github.com/karthikram/rDrop/blob/master/screenshots/create_app.png?raw=true
)

(2) Name your personal version of this app. Dropbox requires that your app have a unique name. Dropbox [branding guidelines](https://www2.dropbox.com/developers/reference/branding) also prohibit the use of the word **"Dropbox"** or names that begin with "**Drop**". We recommend that you name the app something like "**Your_first_name_last_name_rDrop**" to avoid naming conflicts. You won't have to deal with the app name after this step.


![Alt text](https://github.com/karthikram/rDrop/blob/master/screenshots/name_your_app.png?raw=true)

(3) Once you click create, be sure to **copy your App key and App secret** and store it somewhere safe. If you forget it, you can always find it [here](https://www.dropbox.com/developers/apps) (Just click on options next to your App name).  If you use your `.rprofile` and no one else uses your computer,  then we recommend you save your keys there by adding the following lines: <br><br>
<pre><code>
options(DropboxKey = "Your_App_key")
options(DropboxSecret = "Your_App_secret")
</code></pre>
<br>

![Alt text](https://github.com/karthikram/rDrop/blob/master/screenshots/keys.png?raw=true)

If you prefer not to specify keys in a `.rprofile` (especially if you are on a public computer/cluster/cloud server), you can specify both keys in the `dropbox_auth()` function directly (more below). <em>Note that once you have authorized an app, there is no need to call this function again.</em> You can just use your saved credential file to access your Dropbox. If for any reason, the file becomes compromised, just revoke access from your [list of authorized apps.](https://www2.dropbox.com/account#applications)

### Authorizing your app
<pre><code>
library(rDrop)
# Not yet on CRAN. Will make this available via devtools shortly.

# If you have Dropbox keys in your .rprofile, simply run:
 dropbox_credentials &lt;- dropbox_auth()

# Otherwise:
 dropbox_credentials &lt;- dropbox_auth("Your_consumer_key", "Your_consumer_secret")
</code></pre>


If you entered valid keys, you will be directed to a secure Dropbox page on your browser asking you to authorize the app you just created. Click authorize to add this to your approved app list and return to R. This is a one time authorization. Once you have completed these steps, return to `R` and press enter (Ignore <em>When complete, record the PIN given to you and provide it here</em>). If `is.dropbox.cred(dropbox_credentials)` returns `TRUE`, then you are all set. There is no need to run `dropbox_auth()` for each subsequent run. Simply save your credentials file to disk and load as needed:

<pre><code>
 save(dropbox_credentials, file="/path/to/my_dropbox_credentials.rdata")
</code></pre>

Credentials will remain valid until you revoke them from your [Dropbox Apps page](https://www2.dropbox.com/developers/apps) by clicking the x next to your App's name.

# Quick User Guide
This package essentially provides standard Dropbox file operation functions (create/copy/move/restore/share) from within `R`. 

To load a previously validated Dropbox credential file:
<pre><code>
load('/path/to/my_dropbox_credentials.rdata')
# or once again run,
dropbox_credentials &lt;- dropbox_auth('Your_consumer_key', 'Your_consumer_secret')
</code></pre>

### Summary of your Dropbox Account
<pre><code>
dropbox_acc_info(dropbox_credentials) 
# will return a list with your display name, email, quota, referral URL, and country.
</code></pre>

### Directory listing
<pre><code>
dropbox_dir(dropbox_credentials)
# To list files and folders in your Dropbox root. 

dropbox_dir(dropbox_credentials, verbose = TRUE)
# for a complete listing (filename, revision, thumb, bytes, modified, path, and is_dir) with detailed information.


dropbox_dir(dropbox_credentials, path = 'folder_name')
# To see contents of a specific path.

dropbox_dir(dropbox_credentials, path = 'folder_name', verbose = TRUE)
# For verbose content listing of a specific path.
</code></pre>


### Download files from your Dropbox account to R
<pre><code>
# Example
</code></pre>

### Upload R objects to your Dropbox
<pre><code>
# Example
</code></pre>

### Moving files within Dropobx
<pre><code>
dropbox_move(dropbox_credentials, from_path, to_path)	
# from_to can be a folder or file. to_path has to be a folder.
# To overwrite existing file/folder in destination, add overwrite = TRUE.
</code></pre>

### Copying files within Dropbox
<pre><code>
dropbox_copy(dropbox_credentials, from_path, to_path)
# To overwrite existing file/folder in destination, add overwrite = TRUE.
</code></pre>

### Creating a public share for any Dropbox file or folder
<pre><code>
dropbox_share(dropbox_credentials, file)
# File/folder to share. Returns share URL with expiration information.
# Link goes directly to files. Folder are automatically zipped up.
</code></pre>


For more information on usage and tips, see: <br>
<em>Blog posts and CRAN repo forthcoming.</em>

