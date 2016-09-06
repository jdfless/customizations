#!/bin/bash

# release should be rXXXX
release=$1
if [ -z "$release" ]; then
  echo "ERROR: you need to provide a valid release as a parameter"
  exit 1
fi

jdf="jdf = ssh://jflessner@source.corp.skytap.com//hg/"

for repo in $(ls /hg); do
  file="/hg/${repo}/.hg/hgrc"
  if [ -f "$file" ]; then
    if grep -q "$release" "$file"; then
      echo "${jdf}${release}/${repo}" >> "$file"
    else
      echo "${jdf}${repo}" >> "$file"
    fi
  fi
done
