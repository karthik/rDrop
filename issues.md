#  Functions that need work
1. `dropbox_save` - **Not coded.**
2. `dropbox_restore` - haven't worked on it yet.

# Functions with issues
1. dropbox_get() - Does not know how to deal with mime-types at this time (but that is also a larger issue with R in general.)


# Error handling todos.
1. Check destinations for copy/move
2. Check file name formatting for copy/move for from and to.

# Other rdrop issues
1. -Authentication is successful from the R GUI but crashes the application while waiting for PIN input. Will add more notes on this behavior.- - As of 03/13, it magically works (with same ROAUth install!?).<br>
2. File upload also causes the same crashing behavior that happened previously with ROAuth. <br>
3. I still cannot solve R losing object names when it passes across more than one function. I have a error handler called `is.dropbox.cred()` to check whether the Oauth credential works for Dropbox. It works when I call it in a function. But if that function calls another, which does the same check, it fails.<br>
**Example**: `dropbox_dir()` calls `is.dropbox.cred()`. If that check passes, it later calls `dropbox_search()`. Inside `dropbox_search()`, another call to `is.dropbox.cred()` is made and because the credential is being passed a second time, it loses its name and fails (unless someone uses the variable name `cred` which is the param for the function).
The call to `is.dropbox.cred()` inside `drobpox_search()` is necessary because otherwise if someone called the search function directly and passed a bad credential, there would be no check.

## Reference for the API
[https://www2.dropbox.com/developers/reference/](https://www2.dropbox.com/developers/reference/)
