#!/bin/bash
set -e

COMMON_OPTIONS="-Ddefault_library=static -Dbuildtype=debugoptimized -Denable_tools=false -Denable_tests=false"

# Build dav1d for x64
mkdir build_x64
pushd build_x64
CFLAGS="-arch x86_64" meson setup ../../../dav1d $COMMON_OPTIONS
meson compile
popd

# Build dav1d for arm64
mkdir build_arm64
pushd build_arm64
CFLAGS="-arch arm64" meson setup ../../../dav1d --cross-file=../../../meson-crossfiles/apple-amd64_arm64.txt $COMMON_OPTIONS
meson compile
popd

# Combine the binaries into a single static library in the arm64 directory
lipo build_x64/src/libdav1d.a build_arm64/src/libdav1d.a -create -o build_arm64/src/libdav1d.a

# Install the universal binary
sudo ninja -C build_arm64 install
lipo -info /usr/local/lib/libdav1d.a