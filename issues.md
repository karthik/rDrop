#  Files that need  work
1. `dropbox_save` - **Not coded.**
2. `dropbox_get` - Partly works, messy output. no error handling.
3. `dropbox_move` - Works, but needs error handling.
4. `dropbox_delete` - Works, but needs error handling.
5. `dropbox_copy` - Works, but needs major error handling.
6. `dropbox_restore` - haven't worked on it yet. Will need `dropbox_get()` to work first.
7. `dropbox_search` - works fine. However, to search files in a specific path, it seems like I need to search all of Dropbox, then subset the result. I've figured it out but not coded it yet.

# Files that work fine.

1. `dropbox_acc_info()`
2. `dropbox_dir()`
3. `dropbox_error_handlers()` - A collection of helper functions.
4.   `dropbox_create_folder()`                        

# Error handling todos.
1. Check destinations for copy/move
2. Check file name formatting for copy/move for from and to.
3. <strike> Sort out issue with verifiying `dropbox_cred()`</strike>
4. **Big Bug:** `dropbox_auth()` fails on R-GUI <br>
4a. `dropbox_auth()` should not ask for a PIN.

# Other rdrop issues
1. Authentication is successful from the R GUI but crashes the application while waiting for PIN input. Will add more notes on this behavior.
2. File upload also causes the same crashing behavior.

## Reference for the API
[https://www2.dropbox.com/developers/reference/](https://www2.dropbox.com/developers/reference/)