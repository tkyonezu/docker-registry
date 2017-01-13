#!/bin/bash

docker stop docker-registry
docker rm docker-registry

if [ ! -d $(pwd)/docker-registry ]; then
  mkdir docker-registry
  chown 105:106 docker-registry
fi

docker run -d -p 5000:5000 --name docker-registry --restart=always \
  -v $(pwd)/docker-registry:/var/lib/docker-registry \
  soramitsu/docker-registry
