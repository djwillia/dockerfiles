#!/bin/bash

CONTAINERS="\
mirage-make \
solo5-make \
objdump \
"
# runner  (built differently below)

for f in $CONTAINERS; do
    docker build -f $f/Dockerfile -t $f $f
done

if [ ! -e docker_unikernel_runner ]; then
    git clone -b combo https://github.com/djwillia/docker-unikernel-runner.git
fi

docker build -f docker-unikernel-runner/Dockerfile.runner-combo -t runner docker-unikernel-runner/

