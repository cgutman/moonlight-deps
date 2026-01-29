#!/bin/bash
set -e

mkdir build
cd build
export CMAKE_PREFIX_PATH=../../sdl2-compat/install
cmake -DSDL2TTF_VENDORED=ON -DSDL2TTF_SAMPLES=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_MIN \
      -DCMAKE_OSX_ARCHITECTURES='arm64;x86_64' \
      ../../../SDL_ttf/
cmake --build . --config Release -v
cmake --install . --config Release --prefix ../install -v
cd ..

# Remove the version suffix from the dylib's internal name
install_name_tool -id @rpath/libSDL2_ttf.dylib install/lib/libSDL2_ttf.dylib