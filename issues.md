#  Functions that need work
1. `dropbox_save` - **Not coded.**
2. `dropbox_get` - Partly works but not sure how to process all the contents of a requested file that it dumps into a R object. No error handling.
3. `dropbox_restore` - haven't worked on it yet. Will need `dropbox_get()` to work first.
4. `dropbox_media` - might work as an alternate to `dropbox_get()`


# Functions that work fine.

1. `dropbox_acc_info`
2. `dropbox_dir`
3. `dropbox_error_handlers` - A collection of helper functions                 
4. `dropbox_share`  
5. `dropbox_create_folder`  
6. `dropbox_move` - Works, but needs error handling.
7. `dropbox_delete` - Works, but needs error handling.
8. `dropbox_copy` - Works, but needs major error handling.
9. `dropbox_search` - works fine. minor issues almost resolved.           

# Error handling todos.
1. Check destinations for copy/move
2. Check file name formatting for copy/move for from and to.
3. <strike> Sort out issue with verifiying `dropbox_cred()`

# Other rdrop issues
<strike>1. Authentication is successful from the R GUI but crashes the application while waiting for PIN input. Will add more notes on this behavior.</strike> - As of 03/13, it magically works (with same ROAUth install!?).<br>
2. File upload also causes the same crashing behavior that happened previously with ROAuth. <br>
3. I still cannot solve R losing object names when it passes across more than one function. I have a error handler called `is.dropbox.cred()` to check whether the Oauth credential works for Dropbox. It works when I call it in a function. But if that function calls another, which does the same check, it fails.<br>
**Example**: `dropbox_dir()` calls `is.dropbox.cred()`. If that check passes, it later calls `dropbox_search()`. Inside `dropbox_search()`, another call to `is.dropbox.cred()` is made and because the credential is being passed a second time, it loses its name and fails (unless someone uses the variable name `cred` which is the param for the function). 
The call to `is.dropbox.cred()` inside `drobpox_search()` is necessary because otherwise if someone called the search function directly and passed a bad credential, there would be no check.

## Reference for the API
[https://www2.dropbox.com/developers/reference/](https://www2.dropbox.com/developers/reference/)