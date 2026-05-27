#!/bin/bash
set -e

mkdir build_$1
cd build_$1
cmake -DOPUS_BUILD_SHARED_LIBRARY=ON \
      -DCMAKE_OSX_ARCHITECTURES=$2 \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_MIN \
      -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON \
      ../../../opus/
cmake --build . --config Release -v
cd ..