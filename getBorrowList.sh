#!/bin/bash

BASE=$(dirname $0);
SOURCE="source.html"

if [ -z "$1" ]; then
  echo "Usage: $0 <user_name>"
  exit 1;
fi

cd $BASE

rm -f ${SOURCE}
pybot --loglevel NONE -v USER_NAME:$1 $BASE/stabi.robot > /dev/null 2>&1
php transformSource.php ${SOURCE} 2>/dev/null