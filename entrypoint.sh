#!/bin/bash

/etc/init.d/docker-registry start --quiet --background

tail -f /dev/null
