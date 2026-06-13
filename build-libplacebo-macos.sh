#!/bin/bash
set -e

COMMON_OPTIONS="--pkg-config-path=$VULKAN_SDK/lib/pkgconfig -Ddefault_library=shared -Dbuildtype=debugoptimized -Ddemos=false -Dtests=false -Dopengl=disabled -Dd3d11=disabled -Dvulkan=enabled -Dvk-proc-addr=disabled -Dxxhash=disabled -Dshaderc=enabled -Dlcms=disabled"

# Enable cross compilation if needed
arch=$(uname -m)
if [[ "$arch" == "arm64" ]]; then
  X64_OPTIONS="--cross-file=../meson-crossfiles/apple-arm64_amd64.txt"
elif [[ "$arch" == "x86_64" ]]; then
  ARM64_OPTIONS="--cross-file=../meson-crossfiles/apple-amd64_arm64.txt"
else
  echo "Unknown architecture: $arch"
  exit 1
fi

export MACOSX_DEPLOYMENT_TARGET=$MACOS_MIN
export CPATH=$VULKAN_SDK/include:$CPATH
export LIBRARY_PATH=$VULKAN_SDK/lib:$LIBRARY_PATH

# Build libplacebo for x64
git apply ../patches/libplacebo_shaderc_win.patch
meson setup --prefix=$(pwd)/../build/libplacebo/build_x64 $X64_OPTIONS $COMMON_OPTIONS build
meson compile -C build
meson install -C build
git reset --hard
git clean -f -d -x

# Build libplacebo for arm64
git apply ../patches/libplacebo_shaderc_win.patch
meson setup --prefix=$(pwd)/../build/libplacebo/build_arm64 $ARM64_OPTIONS $COMMON_OPTIONS build
meson compile -C build
meson install -C build
git reset --hard
git clean -f -d -x