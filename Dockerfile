#-----------------------------------------------------------------------
# docker-registry - Private Docker repository
#
# build : docker build -t soramitsu/docker-registry .
#
# Copyright (c) 2017 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM ubuntu

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t soramitsu/docker-registry ."
LABEL RUN="docker run -d  -p 5000:5000--name docker-registry --restart=always soramitsu/docker-registry"

RUN apt update && \
    apt -y upgrade && \
    apt -y install docker-registry

COPY entrypoint.sh /

EXPOSE 5000

CMD ["/bin/bash","/entrypoint.sh"]
