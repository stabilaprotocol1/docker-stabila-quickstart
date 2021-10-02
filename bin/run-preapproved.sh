#!/usr/bin/env bash

if [[ $(docker inspect stabila | grep NetworkSettings) != "" ]]; then
  docker rm -f stabila
fi

docker run -it --rm \
  -p 9090:9090 \
  -e "preapprove=maxCpuTimeOfOneTx:20" \
  --name stabila \
  stabilaquickstart