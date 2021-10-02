#!/usr/bin/env bash

version=`cat version`
docker push stabilatools/quickstart:$version
docker push stabilatools/quickstart:latest