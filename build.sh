#!/bin/bash

echo -e "\e[32mGenerating random tag name...\e[0m"
RAND=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)

echo -e "\e[32mBuilding image...\e[0m"
docker build . -t $RAND

echo -e "\e[32mCreating output directory...\e[0m"
mkdir -p ./output

echo -e "\e[32mStarting container...\e[0m"
docker run -d --privileged $RAND

sleep 2s

CID=$(docker ps | grep $RAND | awk '{ print $1 }')

if [ -z "$CID" ]
then
	echo -e "\e[31mContainer ID not found!\e[0m"
	exit 1
fi
	

echo -e "\e[32mExecuting build...\e[0m"
docker exec $CID ./lb.sh --verbose -a amd64

echo -e "\e[32mExtracting ISO from container...\e[0m"
docker cp $CID:root/kali-builder/images/*.iso $(pwd)/output/

echo -e "\e[32mKilling container...\e[0m"
docker rm -f $CID

echo -e "\e[32mRemoving image...\e[0m"
docker rmi $RAND
