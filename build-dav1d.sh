#!/bin/bash
set -e

COMMON_OPTIONS="-Ddefault_library=static -Dbuildtype=debugoptimized -Denable_tools=false -Denable_tests=false"

# Enable cross compilation if needed
arch=$(uname -m)
if [[ "$arch" == "arm64" ]]; then
  X64_OPTIONS="--cross-file=../../../meson-crossfiles/apple-arm64_amd64.txt"
  STATIC_LIB_INSTALL_PATH="/opt/homebrew/lib/libdav1d.a"
elif [[ "$arch" == "x86_64" ]]; then
  ARM64_OPTIONS="--cross-file=../../../meson-crossfiles/apple-amd64_arm64.txt"
  STATIC_LIB_INSTALL_PATH="/usr/local/lib/libdav1d.a"
else
  echo "Unknown architecture: $arch"
  exit 1
fi

# Build dav1d for x64
mkdir build_x64
pushd build_x64
CFLAGS="-arch x86_64 -mmacosx-version-min=$MACOS_MIN" LDFLAGS="-arch x86_64 -mmacosx-version-min=$MACOS_MIN" meson setup ../../../dav1d $X64_OPTIONS $COMMON_OPTIONS
meson compile
popd

# Build dav1d for arm64
mkdir build_arm64
pushd build_arm64
CFLAGS="-arch arm64 -mmacosx-version-min=$MACOS_MIN" LDFLAGS="-arch arm64 -mmacosx-version-min=$MACOS_MIN" meson setup ../../../dav1d $ARM64_OPTIONS $COMMON_OPTIONS
meson compile
popd

# Combine the binaries into a single static library in the arm64 directory
lipo build_x64/src/libdav1d.a build_arm64/src/libdav1d.a -create -o build_arm64/src/libdav1d.a

# Install the universal binary
sudo ninja -C build_arm64 install
lipo -info $STATIC_LIB_INSTALL_PATH