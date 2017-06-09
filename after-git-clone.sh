#!/bin/sh
git submodule update --init

git remote show | grep sp8 > /dev/null || (git remote add sp8 git@github.com:HBPMedical/specifications.git && git pull sp8 master) || true

git fetch sp8 gh-pages

# Create a worktree for the generated pages
[ -d ../specification.pages ] || (
  git worktree add ../specifications.pages sp8/gh-pages
  cd ../specifications.pages && git checkout gh-pages
)
