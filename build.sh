#!/bin/bash

docker pull ubuntu:22.04
docker build . -t base-dev:ubuntu22.04 --target base-dev
