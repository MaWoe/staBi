#!/bin/bash

BASE=$(dirname $0);
SOURCE="source.html"

if [ -z "$1" ]; then
  echo "Usage: $0 <user_name>"
  exit 1;
fi

cd $BASE

rm -f ${SOURCE}
pybot -v USER_NAME:$1 $BASE/stabi.robot
php transformSource.php ${SOURCE}