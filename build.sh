#!/bin/bash

if groups $USER | grep &>/dev/null '\bdocker\b'; then
  DOCKER="docker"
else
  DOCKER="sudo docker"
fi

$DOCKER run --rm -P -v $(pwd):/src -v $(pwd)/../specifications.pages/:/output/ jojomi/hugo:0.25

sudo chown -R $USER:$USER ../specifications.pages/
