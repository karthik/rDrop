#  Files that need  work
1. `dropbox_save` - **Not coded.**
2. `dropbox_get` - Partly works, messy output. no error handling.
3. `dropbox_move` - working, but needs error handling.
4. `dropbox_delete` - working, but needs error handling.
5. `dropbox_copy` - works but needs major error handling.
6. `dropbox_restore` - haven't worked on it yet.
7. `dropbox_search` - works
I need to be able to search a specific path only.

# Error handling todos.
1. Check destinations for copy/move
2. Check file name formatting for copy/move for from and to.
3. <strike> Sort out issue with verifiying `dropbox_cred()`</strike>
4. **Big Bug:** `dropbox_auth()` fails on R-GUI
4a. `dropbox_auth()` should not ask for a PIN.

# Other rdrop issues
1. Authentication is successful from the R GUI but crashes the application while waiting for PIN input. Will add more notes on this behavior.
2. File upload also causes the same crashing behavior.

## Reference for the API
[https://www2.dropbox.com/developers/reference/](https://www2.dropbox.com/developers/reference/)