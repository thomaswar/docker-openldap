#!/usr/bin/env bash

SCRIPTDIR=$(cd $(dirname $BASH_SOURCE[0]) && pwd)
source $SCRIPTDIR/conf.sh

if [ $(id -u) -ne 0 ]; then
    sudo="sudo"
fi
${sudo} docker rmi -f $IMAGENAME 2> /dev/null || true
${sudo} docker build $BUILDARGS -t=$IMAGENAME .
