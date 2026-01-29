#!/bin/bash
set -e

mkdir build
cd build
export CMAKE_PREFIX_PATH=../../SDL/install
cmake -DSDL2COMPAT_TESTS=OFF -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_MIN \
      -DCMAKE_OSX_ARCHITECTURES='arm64;x86_64' \
      ../../../sdl2-compat/
cmake --build . --config Release -v
cmake --install . --config Release --prefix ../install -v
cd ..

# Remove the version suffix from the dylib's internal name
install_name_tool -id @rpath/libSDL2.dylib install/lib/libSDL2.dylib