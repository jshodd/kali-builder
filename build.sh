#!/bin/bash
docker build . -t kali-builder

mkdir -p ./results

docker run --privileged --rm --volume=$PWD/results:/root/results kali-builder
