#!/usr/bin/env bash

# This script builds all the containers locally as an alternative to pulling
# from the docker registry.

cd ${0%/*}

usage() {
    echo "./build-all.sh [-n] [-q]"
    echo "  -n Do not use cache when building docker images"
    echo "  -q Quiet mode"
    exit 1
}

ARGS=

while getopts ":nq" opt; do
    case $opt in
        n) ARGS="$ARGS --no-cache" ;;
        q) ARGS="$ARGS --quiet" ;;
        \?) usage ;;
    esac
done

docker build -t wakemaster39/seedbox:base --pull Dockerfiles/base

docker build -t wakemaster39/seedbox:frontend $ARGS Dockerfiles/frontend &
docker build -t wakemaster39/seedbox:rtorrent $ARGS Dockerfiles/rtorrent  &

wait
