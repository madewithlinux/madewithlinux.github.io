#!/bin/bash
set -exo pipefail
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

livereloadx -s . &

while true; do
    inotifywait -e modify,create,delete -r ./blog/ && echo "rebuilding" && make -C blog/
done
