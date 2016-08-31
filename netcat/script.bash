#!/bin/bash

if [ "$1" != "" ]; then
    CAT="$1"
    shift
    shift
    echo -n $CAT | nc $@
else
    shift
    shift
    nc $@
fi
