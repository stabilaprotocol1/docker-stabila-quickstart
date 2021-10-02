#!/usr/bin/env bash

if [[ $(docker inspect stabila | grep NetworkSettings) != "" ]]; then
  docker rm -f stabila
fi

docker run -it --rm \
  -p 9090:9090 \
  -e "defaultBalance=100000" \
  -e "showQueryString=true" \
  -e "showBody=true" \
  -e "formatJson=true" \
  --name stabila \
  stabilatools/quickstart:2.0.15