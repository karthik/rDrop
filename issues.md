#  Files that need  work
1. dropbox_save
2. dropbox_get
3. dropbox_move - working!
4. dropbox_delete - working!
5. dropbox_copy - works but needs major error handling

# rdropbox issues
1. Authentication is successful from the R GUI but crashes the application while waiting for PIN input.

2. File upload also causes the same crashing behavior.

3.

https://www2.dropbox.com/developers/reference/

Functions that need to be coded:

files (get) - to download a file.
https://api-content.dropbox.com/1/files/<root>/<path>
files (put)
https://api-content.dropbox.com/1/files_put/<root>/<path>?param=val

files (post)
https://api-content.dropbox.com/1/files/<root>/<path>

metadata - DONE
https://api.dropbox.com/1/metadata/<root>/<path>
revisions
https://api.dropbox.com/1/revisions/<root>/<path>
fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/revisions/dropbox/Apps"))
restore
search - Basic version coded up.
shares - BASIC VERSION CODED P
https://api.dropbox.com/1/shares/<root>/<path>
media
thumbnails

File Operations

file copy
https://api.dropbox.com/1/fileops/copy
file move
https://api.dropbox.com/1/fileops/move
file delete
https://api.dropbox.com/1/fileops/create_folder
folder create
https://api.dropbox.com/1/fileops/create_folder


Karthik's todos:
Convert bytes to gb.