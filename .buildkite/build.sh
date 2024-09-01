#!/bin/bash
commit_id=$(git rev-parse --short HEAD)
tag=($commit_id)
docker build -t node-app:$tag .
echo $tag > image-tag.txt


