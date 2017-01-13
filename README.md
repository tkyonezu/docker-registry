# docker-registry
Private Docker repository container

# Docker-Registry on Ubuntu 16.04 LTS

Docker-Registry を Ubuntu 16.04 上のコンテナとして作成します。

## コンテナの作成

``` bash
docker build -t soramitsu/docker-registry .
```

## コンテナの実行

``` bash
./run-docker-registry.sh
```

この `run-docker-registry.sh` は、以下の内容となっています。

```bash
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
```

ここでは、カレントディレクトリに`docker-registry`の`/var/lib/docker-registry`用のディレクトリを作成して、Ubuntuの`docker-registry`で使用されている`uid=105`と`gid=106`にしています。場合によっては、別のファイルシステムを使用するのが良いかも知れません。

また`--restart=always`としていますから、一度コンテナを起動すればUbuntuを再起動しても自動的に起動される用になります。

現在は、TLSを使用していないため外部からアクセスできる環境では、5000/tcpから誰でも操作できる点に留意してください。

## 操作例

[Dockerのドキュメント](https://docs.docker.com/registry/)にあるように、コンテナにタグをつけてローカルでプッシュ、プルできるようになります。

``` bash
docker pull ubuntu

docker tag ubuntu localhost:5000/myfirstimage

docker push localhost:5000/myfirstimage
```

## API V2

Ubuntuにある`docker-registry`は、API V2となっていますので、APIドキュメントを参照してREST APIで操作することが可能です。

[Docker Registry HTTP API V2](https://github.com/docker/distribution/blob/master/docs/spec/api.md)


## Ubuntu の Dockerパッケージ

Ubuntu 16.04 LTSでは、以下のDockerパッケージを利用することができます。

``` bash
# apt-cache search docker
docker - System tray for KDE3/GNOME2 docklet applications
docker-compose - Punctual, lightweight development environments using Docker
docker-registry - Docker toolset to pack, ship, store, and deliver content
docker.io - Linux container runtime
docker-doc - Linux container runtime -- documentation
docker-engine - Docker: the open-source application container engine
```

# Author
[Takeshi Yonezu](https://github.com/tkyonezu)

Copyrights (c) 2017, Soramitsu Co., Ltd.
All Rights Reserved.
