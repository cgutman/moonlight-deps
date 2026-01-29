#!/bin/bash
set -e

mkdir build
cd build
cmake -DSDL_INSTALL_DOCS=OFF -DSDL_TEST_LIBRARY=OFF -DSDL_HIDAPI_LIBUSB=OFF \
      -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_MIN \
      -DCMAKE_OSX_ARCHITECTURES='arm64;x86_64' -DCMAKE_OBJC_FLAGS="-DSDL_MAC_NO_SANDBOX=1" \
      ../../../SDL/
cmake --build . --config Release -v -j
cmake --install . --config Release --prefix ../install -v
cd ..

# Remove the version suffix from the dylib's internal name
install_name_tool -id @rpath/libSDL3.dylib install/lib/libSDL3.dylib