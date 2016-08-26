#!/bin/bash

CONTAINERS="\
mirage-make \
solo5-make \
objdump \
"

for f in $CONTAINERS; do
    docker build -f $f/Dockerfile -t $f $f
done
