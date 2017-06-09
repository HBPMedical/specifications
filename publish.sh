#!/usr/bin/env bash

set -e

count=$(git status --porcelain | wc -l)
if test $count -gt 0; then
  git status
  echo "Not all files have been committed in Git. Release aborted"
  exit 1
fi

./build.sh

git push sp8 master

(
  cd ../specifications.pages/
  git add --all
  git commit -m "Publish on $(date --iso-8601=minutes)"
  git merge -m "This content was used for producing the current site" --strategy=ours master
  git push sp8 gh-pages
)
