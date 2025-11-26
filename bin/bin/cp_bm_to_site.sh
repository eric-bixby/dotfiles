#!/bin/sh

cp ~/git/bookmarks/index.html ~/git/eric-bixby.github.io/bookmarks.html
cd ~/git/eric-bixby.github.io && git add bookmarks.html && git commit -m "Update bookmarks" && git push

