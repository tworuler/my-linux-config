#!/bin/bash

docker pull ubuntu:22.04
docker build . -t base-dev:ubt2204 --target base-dev
docker build . -t android-dev:ubt2204 --target android-dev
