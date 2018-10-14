#!/bin/bash -e

BASE=$(dirname $0);
cd $BASE;

. config.sh

for name in $NAMES; do
    echo "Processing \"$name\""
    ./getBorrowList.sh $name > "lists/$name.txt"
done