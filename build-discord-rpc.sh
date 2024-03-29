#!/bin/bash
set -e

mkdir build_$1
cd build_$1
cmake -DCMAKE_OSX_ARCHITECTURES=$2 -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_MIN ../../../discord-rpc/
cmake --build . --config Release -v
cd ..