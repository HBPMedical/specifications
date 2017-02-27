#!/bin/sh
git submodule update --init

git fetch sp8 gh-pages
git worktree add ../specifications.pages sp8/gh-pages
