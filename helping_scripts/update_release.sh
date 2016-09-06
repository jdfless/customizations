#!/bin/bash

if [ "$1" == "--help" ]; then
  echo "USAGE: ./update_release.sh rOLD rNEW"
  echo "All instances of the old repo will be sed replaced with the new repo."
  exit 0
fi

old=$1
new=$2

if [ -z "$old" -o -z "$new" ]; then
  echo "ERROR: provide the old and new repo. ex: ./update_release.sh r1614 r1618"
  exit 1
fi

for repo in $(ls /hg); do
  file="/hg/${repo}/.hg/hgrc"
  if [ -f "$file" ]; then
    old_grep=$(grep "$old" "$file")
    sed -i -- "s/${old}/${new}/g" "$file"
    new_grep=$(grep "$new" "$file")
    if [ -n "$old_grep" -a "$old_grep" != "$new_grep" ]; then
      echo "before ----------------"
      echo "${old_grep}"
      echo "after ----------------"
      echo "${new_grep}"
      echo "========================================"
    fi
  fi
done
