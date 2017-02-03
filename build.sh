#!/bin/bash

if groups $USER | grep &>/dev/null '\bdocker\b'; then
  DOCKER="docker"
else
  DOCKER="sudo docker"
fi

$DOCKER run --rm -P -v $(pwd):/src -v $(pwd)/../HBPSP8Repo.github.io/:/output/ jojomi/hugo:0.18

