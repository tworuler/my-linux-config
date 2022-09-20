#!/bin/bash

docker pull ubuntu:22.04
docker build . -t base-dev:ubt22.04 --target base-dev
docker build . -t android-dev:ubt22.04 --target android-dev
