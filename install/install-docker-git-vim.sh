#!/usr/bin/env bash
set -euxo pipefail
echo "Hello, Shell Script"
PACKAGE_LIST="gitvimcurl" # dont input space between argument and  
echo "install: $PACKAGE_LIST" # point argument


if apt install -y $PACKAGE_LIST; then
  echo "completed Install!"
else 
  echo "isnstall failed"
fi

echo "OK" && echo "Continue" &&  echo "finish"
myfirstfood="karaage"
if [ -n "$myfirstfood" ]; then
  echo "My favoritefood is $myfirstfood"
else
  echo "no,,,,"
fi

