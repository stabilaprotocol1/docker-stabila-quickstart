#!/usr/bin/env bash

# This script is here to support the development.
# If you like to use this with the actual image replace stabilaquickstart with stabilatools/quickstart

(

# creating the local folders if it do not exist yet
if [[ ! -d "stabila-data" ]]; then
  mkdir stabila-data
fi

# running the container using the local volumes
docker run -it -p 9090:9090 \
  --name stabila \
  -v $PWD/stabila-data:/config \
  stabilaquickstart
)